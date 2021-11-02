//
//  Config.swift
//  DeUrgenta
//
//  Created by Cristi Habliuc on 02.04.2021.
//

import UIKit
import FirebaseRemoteConfig
import Promises

/// Main entry point for any  app config
class Config: NSObject {
    static let shared = Config()
    
    private var remoteConfig = RemoteConfig.remoteConfig()
    private var isRemoteConfigLoaded = false
    
    private override init() {
        super.init()
    }
    
    func remoteValue(of key: RemoteConfigKey) -> RemoteConfigValue {
        remoteConfig.value(of: key)
    }
    
    func configValue(of key: CustomConfigKey) -> String {
        guard let info = Bundle.main.infoDictionary,
              let value = info[key.rawValue] as? String else { return "" }
        return value
    }
    
    func loadRemoteConfig() -> Promise<()> {
        guard !isRemoteConfigLoaded else {
            return .init(())
        }
        
        let promise = Promise<()>.pending()
        let settings = RemoteConfigSettings()
        #if DEBUG
        settings.minimumFetchInterval = 0
        #else
        settings.minimumFetchInterval = 3600
        #endif
        remoteConfig.configSettings = settings
        remoteConfig.setDefaults(RemoteConfigKey.defaults() as? [String: NSObject])
        remoteConfig.fetchAndActivate { [weak self] (status, error) -> Void in
            DispatchQueue.main.async {
                if status == .successFetchedFromRemote || status == .successUsingPreFetchedData {
                    self?.isRemoteConfigLoaded = true
                    promise.fulfill(())
                } else {
                    promise.reject(ConfigError.failure(reason: "\(error?.localizedDescription  ?? "unknown reason")"))
                }
            }
        }
        return promise
    }
}

enum ConfigError: Error {
    case failure(reason: String)
}

/// remote config keys as an enum to help with typos and add some defaults
enum RemoteConfigKey: String, CaseIterable {
    case isDisabled = "is_disabled"
    case apiURL = "api_url"
    
    var defaultValue: Any {
        switch self {
        case .isDisabled: return false
        case .apiURL: return "https://api.deurgenta.hostmysite.ro"
        }
    }
}

extension RemoteConfigKey {
    public static func defaults() -> [String: Any] {
        var dict = [String: Any]()
        for key in allCases { dict[key.rawValue] = key.defaultValue }
        return dict
    }
}

extension RemoteConfig {
    func value(of key: RemoteConfigKey) -> RemoteConfigValue {
        return self[key.rawValue]
    }
}

enum CustomConfigKey: String, CaseIterable {
    case verboseAPI = "VERBOSE_API"
    case apiURL = "API_URL"
    case hereMapAppId = "HERE_MAP_APP_ID"
    case hereMapAppCode = "HERE_MAP_APP_CODE"
    case hereMapLicenseKey = "HERE_MAP_LICENSE_KEY"
    case mapCenterLatitude = "MAP_CENTER_LATITUDE"
    case mapCenterLongitude = "MAP_CENTER_LONGITUDE"
    case debugLoginEmail = "DEBUG_LOGIN_EMAIL"
    case debugLoginPass = "DEBUG_LOGIN_PASS"
}
