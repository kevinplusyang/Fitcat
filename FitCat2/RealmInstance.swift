//
//  RealmInstance.swift
//  FitCat2
//
//  Created by Austin Astorga on 1/21/17.
//  Copyright © 2017 Ming Yang. All rights reserved.
//

import Foundation
import RealmSwift

class RealmInstance {
    
    
    static let sharedInstance = RealmInstance()
    let serverURL = URL(string: "http://104.236.122.187:9080")!
    let syncServerURL = URL(string: "realm://104.236.122.187:9080/~/fitcat")!
    var globalRealm: Realm?
    
    func openRealm(googleID: String) {
        let googleCredentials = SyncCredentials.google(token: googleID)
        
        SyncUser.logIn(with: googleCredentials, server: serverURL, onCompletion: {
            user, error in
            if let user = user {
                // can now open a synchronized Realm with this user
                
                let config = Realm.Configuration(syncConfiguration: SyncConfiguration(user: user, realmURL: self.syncServerURL))
                do {
                    self.globalRealm = try Realm(configuration: config)
                    
                } catch let error as NSError {
                    fatalError(error.localizedDescription)
                }
                
            } else if let error = error {
                print(error.localizedDescription)
            }
        })
    }
    
    func save(realmObject: Object) {
        
        do {
            try self.globalRealm?.write {
                self.globalRealm?.add(realmObject, update: true)
            }
        } catch let error as NSError {
            fatalError(error.localizedDescription)
        }
    }
    
}
