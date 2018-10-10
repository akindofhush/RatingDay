//
//  RestaurantDAO.swift
//  RatingDay
//
//  Created by Tzu-Yen Huang on 2018/10/8.
//  Copyright © 2018年 Tzu-Yen Huang. All rights reserved.
//

import Foundation

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
    static func getAllRestaurant()->[Restaurant]{
        var list = [Restaurant]()
        let db = FMDatabase(path: dbPath)
        db?.open()
        if let result = db?.executeQuery("SELECT * FROM info", withArgumentsIn: []){
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
                let data = Restaurant(placeId:placeId!,name:name!,address:address ?? "無資料",photo:photo,phone:phone ?? "無資料",lat:lat,lng:lng,googleRating:googleRating,tripRating:tripRating,type:type ?? "無資料",likeNum:likeNum,dayRating:dayRating)
                list.append(data)
            }
            result.close()
        }
        db?.close()
        return list
    }
    
    static func 
}
