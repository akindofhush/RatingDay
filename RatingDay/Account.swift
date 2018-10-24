//
//  Account.swift
//  RatingDay
//
//  Created by Tzu-Yen Huang on 2018/10/24.
//  Copyright © 2018年 Tzu-Yen Huang. All rights reserved.
//

import Foundation
import Firebase

class Account{
    
    static func setUserInfo(email:String,name:String,password:String){
        let fbDb = Firestore.firestore()
        let settings = fbDb.settings
        settings.areTimestampsInSnapshotsEnabled = true
        fbDb.settings = settings
        fbDb.collection("userInfo").document(email).setData([
            "name": name,
            "password":password
        ]) { err in
            if let err = err {
                print("Error adding document: \(err)")
            } else {
                print("Document successfully written!")
            }
        }
    }
    
    static func setPhotoUrl(email:String,photoUrl:URL){
        let fbDb = Firestore.firestore()
        let settings = fbDb.settings
        settings.areTimestampsInSnapshotsEnabled = true
        fbDb.settings = settings
        fbDb.collection("userInfo").document(email).setData([
            "url": photoUrl
            
        ]) { err in
            if let err = err {
                print("Error adding document: \(err)")
            } else {
                print("Document successfully written!")
            }
        }
    }
    
}
