//
//  LocalStorage+User.swift
//  DeUrgenta
//
//  Created by Cristi Habliuc on 08.06.2021.
//

import Foundation
import CoreData

extension LocalStorage {
    
    func getUser(byEmail email: String) throws -> StoredUser? {
        let request: NSFetchRequest<StoredUser> = StoredUser.fetchRequest()
        request.predicate = NSPredicate(format: "email == %@", email)
        return try moc.fetch(request).first
    }
    
    @discardableResult
    func createUser(withEmail email: String) throws -> StoredUser? {
        guard try getUser(byEmail: email) == nil else {
            LogError("A user with the same email already exists!")
            return nil
        }
        let user = StoredUser(context: moc)
        user.email = email
        return user
    }

}
