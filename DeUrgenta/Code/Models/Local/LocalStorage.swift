//
//  LocalStorage.swift
//  DeUrgenta
//
//  Created by Cristi Habliuc on 08.06.2021.
//

import UIKit
import CoreData

/**
 Use this object to sync the local database.
 It uses CoreData to manage the object graph
 */
public class LocalStorage: NSObject {
    
    /// Use this shared object to do the syncing
    public static var shared: LocalStorage = LocalStorage()
    
    /// The persistent container
    public private(set) var container: NSPersistentContainer
    
    /// The managed object context
    public var moc: NSManagedObjectContext {
        return container.viewContext
    }
    
    static var managedObjectModel: NSManagedObjectModel {
        let bundle = Bundle(for: self.self)
        let modelURL = bundle.url(forResource: "Local", withExtension: "momd")!
        return NSManagedObjectModel(contentsOf: modelURL)!
    }
    
    /// Creates the local container and calls back when it's done
    public func createLocalContainer(then completion: @escaping (NSPersistentContainer) -> Void) {
        container.loadPersistentStores(completionHandler: { [weak self] _, maybeError in
            guard let self = self else { return }
            if let error = maybeError {
                fatalError("Could not load local model: \(error)")
            }
            
            DispatchQueue.main.async {
                #if DEBUG
                LogDebug("loaded store at: \(NSPersistentContainer.defaultDirectoryURL())")
                #endif
                completion(self.container)
            }
        })
    }
    
    public func save() throws {
        try moc.save()
    }
    
    // MARK: - Object
    
    public init(container: NSPersistentContainer? = nil) {
        self.container = container ?? NSPersistentContainer(name: "Local", managedObjectModel: LocalStorage.managedObjectModel)
        super.init()
    }
    
}

// MARK: - MOC decoder injection

public extension CodingUserInfoKey {
    // Helper property to retrieve the context
    static let managedObjectContext = CodingUserInfoKey(rawValue: "managedObjectContext")
}

public protocol CodingWithContext {
    static var jsonDecoder: JSONDecoder { get }
}

extension NSManagedObject: CodingWithContext {
    public static var jsonDecoder: JSONDecoder {
        let decoder = JSONDecoder()
        if let mocUIKey = CodingUserInfoKey.managedObjectContext {
            decoder.userInfo[mocUIKey] = LocalStorage.shared.moc
        }
        return decoder
    }
}

// MARK: - Dictionary Decodable protocol & extension

public protocol DictionaryDecodable: AnyObject {
    static func fromDictionary(_ dict: [AnyHashable: Any]) throws -> Self
}

extension DictionaryDecodable where Self: Decodable & CodingWithContext {
    public static func fromDictionary(_ dict: [AnyHashable: Any]) throws -> Self {
        let json = try JSONSerialization.data(withJSONObject: dict, options: [])
        let decoder = Self.jsonDecoder
        return try decoder.decode(Self.self, from: json)
    }
}

public protocol DictionaryEncodable: AnyObject {
    func toDictionary() throws -> [AnyHashable: Any]
}

extension DictionaryEncodable where Self: Encodable & CodingWithContext {
    public func toDictionary() throws -> [AnyHashable: Any] {
        let encoder = JSONEncoder()
        let data = try encoder.encode(self)
        let dict = try JSONSerialization.jsonObject(with: data, options: []) as! [AnyHashable: Any]
        return dict
    }
}
