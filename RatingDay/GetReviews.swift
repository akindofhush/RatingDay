//
//  GetReviews.swift
//  RatingDay
//
//  Created by Tzu-Yen Huang on 2018/10/14.
//  Copyright © 2018年 Tzu-Yen Huang. All rights reserved.
//

import Foundation


class GetGoogleReviews{
    
    static func setGoogleReviews(placeId:String,completion: @escaping ([[[String:Any]]]?, Error?) -> Void){
        let path = "https://maps.googleapis.com/maps/api/place/details/json?placeid="+"\(placeId)"+"&key=AIzaSyBMU77ApcC6NmY3Lv2L1K4Mw6kvKdym7l4"
        
        var reviewList = [[[String : Any]]]()
        var req = URLRequest(url: URL(string: path)!)
        req.httpMethod = "GET"
        
        NSURLConnection.sendAsynchronousRequest(req, queue: OperationQueue.main){(res,data,error) in
            if let e = error{
                print("Error:\(e)")
                return
            }
            //print("\(String(data: data!,encoding:String.Encoding.utf8))")
            if let result = try? JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as? [String:Any]{
                //ReviewList.removeAll()
                let item = result!["result"]! as! [String:Any]
                let data = item["reviews"] as! [[String:Any]]//array
                for reviews in data{
                    let reviews = data//dict
                    reviewList.append(reviews)
                }
                completion(reviewList,nil)
            }
        }
    }
    
    static func getRatingFromList
}


