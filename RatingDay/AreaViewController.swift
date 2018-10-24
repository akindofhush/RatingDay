//
//  AreaViewController.swift
//  RatingDay
//
//  Created by Tzu-Yen Huang on 2018/10/23.
//  Copyright © 2018年 Tzu-Yen Huang. All rights reserved.
//

import UIKit

class AreaViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    var areaList = [String]()
    var targetPath : String!
    var list = [Restaurant]()
    
    @IBOutlet var tableView: UITableView!
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return areaList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AREACELL", for: indexPath)
        cell.textLabel?.text = areaList[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0{
            list = RestaurantDAO.getResByArea(area: "中山")!
        }else if indexPath.row == 1{
            list = RestaurantDAO.getResByArea(area: "北投")!
        }else if indexPath.row == 2{
            list = RestaurantDAO.getResByArea(area: "士林")!
        }else if indexPath.row == 3{
            list = RestaurantDAO.getResByArea(area: "內湖")!
        }else if indexPath.row == 4{
            list = RestaurantDAO.getResByArea(area: "松山")!
        }else if indexPath.row == 5{
            list = RestaurantDAO.getResByArea(area: "大同")!
        }else if indexPath.row == 6{
            list = RestaurantDAO.getResByArea(area: "信義")!
        }else if indexPath.row == 7{
            list = RestaurantDAO.getResByArea(area: "大安")!
        }else if indexPath.row == 8{
            list = RestaurantDAO.getResByArea(area: "中正")!
        }else if indexPath.row == 9{
            list = RestaurantDAO.getResByArea(area: "南港")!
        }else if indexPath.row == 10{
            list = RestaurantDAO.getResByArea(area: "萬華")!
        }else if indexPath.row == 11{
            list = RestaurantDAO.getResByArea(area: "文山")!
        }
        self.performSegue(withIdentifier: "AREA", sender: tableView)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "AREA"{
            let next = segue.destination as! TableViewController
            next.list = self.list
            print("prepare")
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        areaList = NSArray(contentsOfFile: targetPath) as! [String]
        self.tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        targetPath = "\(NSHomeDirectory())/Documents/data.plist"
        //print(targetPath)
        let fileMgr = FileManager.default
        if !fileMgr.fileExists(atPath: targetPath){
            let source = Bundle.main.path(forResource: "AreaList", ofType: "plist")!
            try? fileMgr.copyItem(atPath: source, toPath: targetPath)
        }
        // Do any additional setup after loading the view.
    }
}
