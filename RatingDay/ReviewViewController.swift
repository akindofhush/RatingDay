//
//  ReviewViewController.swift
//  RatingDay
//
//  Created by Tzu-Yen Huang on 2018/10/10.
//  Copyright © 2018年 Tzu-Yen Huang. All rights reserved.
//

import UIKit
import Firebase

class ReviewViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    func setRatingData(placeId:String,email:String,dayRating:Double,dayReview:String){
        let fbDb = Firestore.firestore()
        let settings = fbDb.settings
        settings.areTimestampsInSnapshotsEnabled = true
        fbDb.settings = settings
        fbDb.collection(placeId).document(email).setData([
        "dayRating": dayRating,
        "dayReview": dayReview
        ]) { err in
            if let err = err {
                print("Error adding document: \(err)")
            } else {
                print("Document successfully written!")
            }
        }
    }
    
    func getRatingDataByPlaceId(placeId :String)->[QueryDocumentSnapshot]{
        let fbDb = Firestore.firestore()
        let settings = fbDb.settings
        settings.areTimestampsInSnapshotsEnabled = true
        fbDb.settings = settings
        var list = [QueryDocumentSnapshot]()
        fbDb.collection(placeId).getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    print("\(document.documentID) => \(document.data())")
                    list.append(document)
                }
            }
        }
        return list
    }
    
    static func getDayRatingByPlaceId(placeId :String)->Double{
        let fbDb = Firestore.firestore()
        let settings = fbDb.settings
        settings.areTimestampsInSnapshotsEnabled = true
        fbDb.settings = settings
        //var email = [String]()
        //var rating = [Double]()
        var ratingAverage = 0.0
        var count = 0.0
        //var review = [String]()
        fbDb.collection(placeId).getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    //let e = document.documentID
                    let ra = document.get("dayRating") as! Double
                    //let re = document.get("dayReview") as! String
                    //email.append(e)
                    count += 1
                    ratingAverage = (ratingAverage + ra)/count
                    //review.append(re)
                }
            }
        }
        return ratingAverage
    }
    
    
    func deleteDataInRating(placeId:String,email:String){
        let fbDb = Firestore.firestore()
        let settings = fbDb.settings
        settings.areTimestampsInSnapshotsEnabled = true
        fbDb.settings = settings
        fbDb.collection(placeId).document(email).delete() { err in
            if let err = err {
                print("Error removing document: \(err)")
            } else {
                print("Document successfully removed!")
            }
        }
    }
    
}
