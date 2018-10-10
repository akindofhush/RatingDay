//
//  HomeViewController.swift
//  RatingDay
//
//  Created by Tzu-Yen Huang on 2018/10/5.
//  Copyright © 2018年 Tzu-Yen Huang. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

       
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
    }

}
