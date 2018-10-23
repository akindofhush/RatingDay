//
//  LoginViewController.swift
//  RatingDay
//
//  Created by Tzu-Yen Huang on 2018/10/4.
//  Copyright © 2018年 Tzu-Yen Huang. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet var account: UITextField!
    @IBOutlet var password: UITextField!
    @IBOutlet var alert: UILabel!
    @IBOutlet var switchStatus: UISwitch!
    //var googleReviewData = [[String : Any]]()
    
    let ud = UserDefaults.standard
    @IBAction func login(_ sender: UIButton) {
        let email = ud.string(forKey: "USEREMAIL")
        let password = ud.string(forKey: "USERPASSWORD")
        if account.text == email && self.password.text == password{
            //jump to specific page
            if let controller = storyboard?.instantiateViewController(withIdentifier: "Navi"){
                present(controller, animated: true, completion: nil)
            }
            if switchStatus.isOn {
                ud.set(true, forKey: "SWITCH")
            }else{
                ud.set(false, forKey: "SWITCH")
            }
            
        }else{
            alert.text = "請輸入正確帳號密碼"
        }
    }

    @IBAction func `switch`(_ sender: UISwitch) {
    }
    
    @IBAction func forget(_ sender: UIButton) {
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        account.delegate = self
        password.delegate = self
        if ud.bool(forKey: "SWITCH"){
            switchStatus.setOn(true, animated: false)
            account.text = ud.string(forKey: "USEREMAIL")
            password.text = ud.string(forKey: "USERPASSWORD")
        }
//Testing Place
//        let test = ReviewViewController()
//        print("settingData")
//        test.setRatingData(placeId: "ChIJGTcKOW6sQjQRFOYp_8ce8yM", email: "aa@hotmail.com", dayRating: 4.0, dayReview: "Good!")
//        test.setRatingData(placeId: "ChIJGTcKOW6sQjQRFOYp_8ce8yM", email: "bb@hotmail.com", dayRating: 4.3, dayReview: "Nice!")
        
//        GetGoogleReviews.setGoogleReviews(placeId: "ChIJGTcKOW6sQjQRFOYp_8ce8yM", completion: {(data,error) in
//           if let data = data{
//                self.googleReviewData = data
//            }
//        })
    let path = RestaurantDAO.dbPath
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
    }
}
