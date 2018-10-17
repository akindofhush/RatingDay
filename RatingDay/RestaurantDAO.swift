//
//  RestaurantDAO.swift
//  RatingDay
//
//  Created by Tzu-Yen Huang on 2018/10/8.
//  Copyright © 2018年 Tzu-Yen Huang. All rights reserved.
//

import Foundation
import Firebase

class RestaurantDAO{
    
    static var dbPath:String{
        let target = "\(NSHomeDirectory())/Documents/information.sqlite"
        let fileMgr = FileManager.default
        if !fileMgr.fileExists(atPath: target){
            let source = Bundle.main.path(forResource: "restaurant", ofType: "sqlite")!
            try? fileMgr.copyItem(atPath: source, toPath: target)
        }
        //print(target)
        return target
    }
    
    static func sqlDataToRes(dbPath:String,sqlStr:String)->[Restaurant]?{
        var list = [Restaurant]()
        let db = FMDatabase(path: dbPath)
        db?.open()
        if let result = db?.executeQuery(sqlStr, withArgumentsIn: []){
            while result.next(){
                let placeId = result.string(forColumn: "placeId")
                let name = result.string(forColumn: "name")
                let address = result.string(forColumn: "address")
                let photo = result.data(forColumn: "photo")
                let phone = result.string(forColumn: "phone")
                let lat = result.double(forColumn: "lat")
                let lng = result.double(forColumn: "lng")
                let googleRating = result.double(forColumn: "googleRating")
                let tripRating = result.double(forColumn: "tripRating")
                let type = result.string(forColumn: "type")
                //firebase
                let likeNum = 0
                let dayRating = 0.0
                let data = Restaurant(placeId:placeId!,name:name!,address:address ?? "無地址資訊",photo:photo,phone:phone ?? "無電話資訊",lat:lat,lng:lng,googleRating:googleRating,tripRating:tripRating,type:type ?? "中式",likeNum:likeNum,dayRating:dayRating)
                list.append(data)
            }
            result.close()
        }
        db?.close()
        return list
    }
    
    static func fbDataToRes(document:QueryDocumentSnapshot)->Restaurant?{
        return nil
    }
    
    static func getAllRestaurant()->[Restaurant]?{
        let data = self.sqlDataToRes(dbPath: dbPath, sqlStr: "SELECT * FROM info")
        return data
    }
    
    static func getResByPlaceId(placeId:String)->Restaurant?{
        var res : Restaurant!
        let db = FMDatabase(path: dbPath)
        db?.open()
        if let result = db?.executeQuery("SELECT * FROM info WHERE placeId = \"\(placeId)\"", withArgumentsIn: []){
            while result.next(){
                let placeId = result.string(forColumn: "placeId")
                let name = result.string(forColumn: "name")
                let address = result.string(forColumn: "address")
                let photo = result.data(forColumn: "photo")
                let phone = result.string(forColumn: "phone")
                let lat = result.double(forColumn: "lat")
                let lng = result.double(forColumn: "lng")
                let googleRating = result.double(forColumn: "googleRating")
                let tripRating = result.double(forColumn: "tripRating")
                let type = result.string(forColumn: "type")
                //firebase
                let likeNum = 0
                let dayRating = 0.0
                res = Restaurant(placeId:placeId!,name:name!,address:address ?? "無地址資訊",photo:photo,phone:phone ?? "無電話資訊",lat:lat,lng:lng,googleRating:googleRating,tripRating:tripRating,type:type ?? "中式",likeNum:likeNum,dayRating:dayRating)
            }
            result.close()
        }
        db?.close()
        return res
    }
    
    static func getResByName(name:String)->[Restaurant]?{
        let data = self.sqlDataToRes(dbPath: dbPath, sqlStr: "SELECT * FROM info WHERE name LIKE '%\(name)%'")
        return data
    }
    
    static func getResByArea(area:String)->[Restaurant]?{
        let data = self.sqlDataToRes(dbPath: dbPath, sqlStr: "SELECT * FROM info WHERE address LIKE '%\(area)%'")
        return data
    }
    
    static func getResByType(type:String)->[Restaurant]?{
        let data = self.sqlDataToRes(dbPath: dbPath, sqlStr: "SELECT * FROM info WHERE type = \(type)")
        return data
    }
    
    static func getGoogleRatingByPlaceId(placeId:String)->Double{
        var rating = 0.0
        let db = FMDatabase(path: dbPath)
        db?.open()
        if let result = db?.executeQuery("SELECT * FROM info WHERE placeId = \"\(placeId)\"", withArgumentsIn: []){
            while result.next(){
                rating = result.double(forColumn: "googleRating")
            }
            result.close()
        }
        db?.close()
        return rating
    }

    
    static func getTripRatingByPlaceId(placeId:String)->Double{
        var rating = 0.0
        let db = FMDatabase(path: dbPath)
        db?.open()
        if let result = db?.executeQuery("SELECT * FROM info WHERE placeId = \"\(placeId)\"", withArgumentsIn: []){
            while result.next(){
                rating = result.double(forColumn: "tripRating")
            }
            result.close()
        }
        db?.close()
        return rating
    }
    
    static func getDayRatingByPlaceId(placeId:String,completion: @escaping (Double?, Error?) -> Void){
        let fbDb = Firestore.firestore()
        let settings = fbDb.settings
        settings.areTimestampsInSnapshotsEnabled = true
        fbDb.settings = settings

        fbDb.collection(placeId).getDocuments() { (querySnapshot, err) in
            var ratingAverage = 0.0
            var count = 0.0
            if let err = err {
                print("Error getting documents: \(err)")
                completion(nil, err)
            } else {
                for document in querySnapshot!.documents {
                    if let ra = document.get("dayRating") as? Double{
                    count += 1
                    ratingAverage = (ratingAverage + ra)/count
                    }
                }
                completion(ratingAverage, nil)
            }
        }
    }
    
    
}
