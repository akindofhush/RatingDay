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
    
    @IBOutlet var tableView: UITableView!
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return areaList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AREACELL", for: indexPath)
        cell.textLabel?.text = areaList[indexPath.row]
        return cell
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
