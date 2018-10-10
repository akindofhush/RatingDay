//
//  CollectionViewController.swift
//  RatingDay
//
//  Created by Tzu-Yen Huang on 2018/10/10.
//  Copyright © 2018年 Tzu-Yen Huang. All rights reserved.
//

import UIKit
import Firebase

class CollectionViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func setData(rateName:String,dayRating:Double,dayReview:String){
        let fbDb = Firestore.firestore()
        fbDb.collection("rating").document("ChIJGTcKOW6sQjQRFOYp_8ce8yM").setData([
        "rateName":rateName,
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
    
    func getData(){
        let fbDb = Firestore.firestore()
        fbDb.collection("ChIJGTcKOW6sQjQRFOYp_8ce8yM").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    print("\(document.documentID) => \(document.data())")
                }
            }
        }
    }
    func deleteData(){
        let fbDb = Firestore.firestore()
        fbDb.collection("ChIJGTcKOW6sQjQRFOYp_8ce8yM").document("I0YOURVXOuZiDb6wTD9G").delete() { err in
            if let err = err {
                print("Error removing document: \(err)")
            } else {
                print("Document successfully removed!")
            }
        }
    }
    
}
