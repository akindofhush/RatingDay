//
//  TypeViewController.swift
//  RatingDay
//
//  Created by Tzu-Yen Huang on 2018/10/23.
//  Copyright © 2018年 Tzu-Yen Huang. All rights reserved.
//

import UIKit

class TypeViewController: UIViewController {
    
    var list = [Restaurant]()
    @IBAction func chinese(_ sender: UIButton) {
        list = RestaurantDAO.getResByType(type: "中式")!
    }
    
    @IBAction func american(_ sender: UIButton) {
        list = RestaurantDAO.getResByType(type: "美式")!
    }
    @IBAction func thai(_ sender: UIButton) {
        list = RestaurantDAO.getResByType(type: "泰式")!
    }
    
    @IBAction func italian(_ sender: UIButton) {
        list = RestaurantDAO.getResByType(type: "義式")!
    }
    
    @IBAction func japanese(_ sender: UIButton) {
        list = RestaurantDAO.getResByType(type: "日式")!
        list += RestaurantDAO.getResByType(type: "韓式")!
    }
    
    @IBAction func others(_ sender: UIButton) {
        let allRes = RestaurantDAO.getAllRestaurant()
        for res in allRes!{
            if res.type != "中式" && res.type != "美式" && res.type != "泰式" && res.type != "義式" && res.type != "日式" && res.type != "韓式"{
                self.list.append(res)
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let next = segue.destination as! TableViewController
        next.list = self.list
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    
    }
    

}
