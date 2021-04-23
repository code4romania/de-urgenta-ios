//
//  DUAPI.swift
//  DeUrgenta
//
//  Created by Cristi Habliuc on 22.04.2021.
//

import Foundation
import Promises
import Alamofire

/// Handles API remote calls
class DUAPICore: NSObject {
    enum URI {
        case login
        case register

        public var uri: String {
            switch self {
            case .login:
                return "/auth/login"
            case .register:
                return "/auth/register"
            }
        }
        
        /// Some URIs might need to be routed to a different base url (such as notification related ones)
        public var baseUrl: String? {
            let localURL = Config.shared.configValue(of: .apiURL)
            if !localURL.isEmpty {
                return localURL
            } else {
                return Config.shared.remoteValue(of: .apiURL).stringValue
            }
        }
    }
    
    enum APIError: Error, LocalizedError {
        /// Used when an API response actually fails with Error
        case responseError(originalError: Error)
        /// Used when a logic/validation message should be presented to the user
        case genericError(message: String)
        /// Used when an internal error occured, like an unexpected Exception being thrown
        case genericInternalError(originalError: Error)
        case unknownError
        case unreachable
        case jsonParseFail
        case invalidData
        case unauthorized
        case notFound(what: String)
        
        var errorDescription: String? {
            switch self {
            case .responseError(let originalError):
                return "Response error: " + originalError.localizedDescription
            case .genericError(let message):
                return message
            case .genericInternalError(let originalError):
                return "Internal Exception: " + originalError.localizedDescription
            case .unknownError:
                return "Unknown error"
            case .jsonParseFail:
                return "Internal Error (JSONParse)"
            case .unreachable:
                return "No Connection"
            case .invalidData:
                return "Invalid data"
            case .unauthorized:
                return "Unauthorized"
            case .notFound(let what):
                return what + " not found"
            }
        }
    }
}

typealias DUUID = String

protocol DUAPIType {
    static var shared: DUAPIType { get }
//    func getAuthUserId() -> Promise<DUUID>
//    func authUserId() -> DUUID?
    func get<Response: Decodable>(from uri: DUAPICore.URI) -> Promise<Response>
    func get<Response: Decodable>(from uri: DUAPICore.URI, authenticated: Bool) -> Promise<Response>
    func post<Response: Decodable, Request: Encodable>(to uri: DUAPICore.URI, body: Request) -> Promise<Response>
    func post<Response: Decodable, Request: Encodable>(to uri: DUAPICore.URI, body: Request, authenticated: Bool) -> Promise<Response>
}

extension DUAPICore: DUAPIType {
    static let shared: DUAPIType = DUAPICore()
    
    private var isVerbose: Bool {
        Config.shared.configValue(of: .verboseAPI) == "true"
    }
    
    func get<Response>(from uri: URI) -> Promise<Response> where Response : Decodable {
        return get(from: uri, authenticated: true)
    }
    
    func get<Response: Decodable>(from uri: DUAPICore.URI, authenticated: Bool) -> Promise<Response> {
        let promise = Promise<Response>.pending()
        
        if isVerbose {
            LogDebug("GET " + uri.uri + ", authenticated: \(authenticated)")
        }
        
        guard let apiEndpoint = uri.baseUrl else {
            promise.reject(APIError.genericError(message: "no api endpoint"))
            return promise
        }
        
        guard let url = URL(string: apiEndpoint + uri.uri) else {
            promise.reject(APIError.genericError(message: "invalid url"))
            return promise
        }
        
        if authenticated {
            return createAuthenticatedRequest(url: url, method: "GET")
                .then { self.getRequest($0) }
        } else {
            let body: String? = nil
            return createPublicRequest(url: url, method: "GET", body: body)
                .then { self.getRequest($0) }
        }
    }
    
    func post<Response, Request>(to uri: URI, body: Request) -> Promise<Response> where Response : Decodable, Request : Encodable {
        return post(to: uri, body: body, authenticated: true)
    }
    
    func post<Response, Request>(to uri: DUAPICore.URI, body: Request, authenticated: Bool) -> Promise<Response>
        where Response : Decodable, Request : Encodable {
        
        if isVerbose {
            LogDebug("POST " + uri.uri + ", authenticated: \(authenticated)")
        }
        
        let promise = Promise<Response>.pending()
        guard let apiEndpoint = uri.baseUrl else {
            promise.reject(APIError.genericError(message: "no api endpoint"))
            return promise
        }
        
        guard let url = URL(string: apiEndpoint + uri.uri) else {
            promise.reject(APIError.genericError(message: "invalid url"))
            return promise
        }
        
        if authenticated {
            return createAuthenticatedRequest(url: url, method: "POST", body: body)
                .then { self.postRequest($0) }
        } else {
            return createPublicRequest(url: url, method: "POST", body: body)
                .then { self.postRequest($0) }
        }
    }
    
    // MARK: Internal
    
    private func getRequest<Response: Decodable>(_ request: URLRequest) -> Promise<Response> {
        let promise = Promise<Response>.pending()
        AF.request(request, interceptor: DefaultRetrier())
        .responseDecodable(completionHandler: { (response: DataResponse<Response, AFError>) in
            if self.isVerbose {
                LogDebug("GET " + (request.url?.absoluteString ?? "nil") + ", status code: \(response.response?.statusCode ?? 0)")
            }
            if let result = try? response.result.get() {
                if self.isVerbose,
                   let data = response.data,
                   let text = String(data: data, encoding: .utf8) {
                    LogDebug("Body:\n\(text)")
                }
                promise.fulfill(result)
            } else {
                if self.isVerbose {
                    LogDebug("GET " + (request.url?.absoluteString ?? "nil") + ", error: \(response.error?.localizedDescription ?? "unknown")")
                }
                promise.reject(APIError.responseError(originalError: response.error ?? APIError.unknownError))
            }
        })
        return promise
    }
    
    private func postRequest<Response>(_ request: URLRequest) -> Promise<Response>
        where Response : Decodable {
        let promise = Promise<Response>.pending()

        if Response.self == String.self {
            AF.request(request, interceptor: DefaultRetrier())
            .responseString(completionHandler: { (response: DataResponse<String, AFError>) in
                if self.isVerbose {
                    LogDebug("POST " + (request.url?.absoluteString ?? "nil") + ", status code: \(response.response?.statusCode ?? 0)")
                }
                if let result = try? response.result.get() {
                    if self.isVerbose,
                       let data = response.data,
                       let text = String(data: data, encoding: .utf8) {
                        LogDebug("Body:\n\(text)")
                    }
                    promise.fulfill(result as! Response)
                } else {
                    if self.isVerbose {
                        LogDebug("POST " + (request.url?.absoluteString ?? "nil") + ", error: \(response.error?.localizedDescription ?? "unknown")")
                        if let data = response.data,
                           let text = String(data: data, encoding: .utf8) {
                            LogDebug("Body:\n\(text)")
                        }
                    }
                    promise.reject(APIError.responseError(originalError: response.error ?? APIError.unknownError))
                }
            })
        } else {
            AF.request(request, interceptor: DefaultRetrier())
            .responseDecodable(completionHandler: { (response: DataResponse<Response, AFError>) in
                if self.isVerbose {
                    LogDebug("POST " + (request.url?.absoluteString ?? "nil") + ", status code: \(response.response?.statusCode ?? 0)")
                }
                if let result = try? response.result.get() {
                    if self.isVerbose,
                       let data = response.data,
                       let text = String(data: data, encoding: .utf8) {
                        LogDebug("Body:\n\(text)")
                    }
                    promise.fulfill(result)
                } else {
                    if self.isVerbose {
                        LogDebug("POST " + (request.url?.absoluteString ?? "nil") + ", error: \(response.error?.localizedDescription ?? "unknown")")
                        if let data = response.data,
                           let text = String(data: data, encoding: .utf8) {
                            LogDebug("Body:\n\(text)")
                        }
                    }
                    promise.reject(APIError.responseError(originalError: response.error ?? APIError.unknownError))
                }
            })
        }
        return promise
    }

    private func createAuthenticatedRequest(url: URL,
                                            method: String) -> Promise<URLRequest> {
        let noBody: String? = nil
        return createAuthenticatedRequest(url: url, method: method, body: noBody)
    }

    private func createAuthenticatedRequest<T>(url: URL,
                                            method: String,
                                            body: T?) -> Promise<URLRequest> where T: Encodable {

        let promise = Promise<URLRequest>.pending()
        guard let token = AccountManager.shared.token else {
            promise.reject(APIError.unauthorized)
            return promise
        }

        var request = URLRequest(url: url)
        var headers = request.allHTTPHeaderFields ?? [:]
        headers["Authorization"] = "Bearer \(token)"
        headers["Content-Type"] = "application/json"
        request.allHTTPHeaderFields = headers
        request.httpMethod = method
        if body != nil {
            do {
                request.httpBody = try JSONEncoder().encode(body)
            } catch {
                promise.reject(error)
            }
        }
        promise.fulfill(request)
        
        return promise
    }

    private func createPublicRequest<T>(url: URL,
                                        method: String,
                                        body: T?) -> Promise<URLRequest> where T: Encodable {

        let promise = Promise<URLRequest>.pending()

        var request = URLRequest(url: url)
        request.httpMethod = method
        if body != nil {
            do {
                request.httpBody = try JSONEncoder().encode(body)
                var headers = request.allHTTPHeaderFields ?? [:]
                headers["Content-Type"] = "application/json"
                request.allHTTPHeaderFields = headers
            } catch {
                promise.reject(error)
            }
        }
        promise.fulfill(request)
        
        return promise
    }
}


class DefaultRetrier: RequestInterceptor {
    private let RetryDelay: TimeInterval = 0.1
    private var maxRetries: Int
    private static let DefaultRetries: Int = 3

    init(count: Int = DefaultRetrier.DefaultRetries) {
        self.maxRetries = count
    }

    func retry(_ request: Request, for session: Alamofire.Session, dueTo error: Error, completion: @escaping (RetryResult) -> Void) {
        if request.retryCount < maxRetries {
            completion(.retryWithDelay(RetryDelay))
        } else {
            completion(.doNotRetry)
        }
    }

}
