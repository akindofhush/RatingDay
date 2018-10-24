//
//  RegisterViewController.swift
//  RatingDay
//
//  Created by Tzu-Yen Huang on 2018/10/4.
//  Copyright © 2018年 Tzu-Yen Huang. All rights reserved.
//

import UIKit
import FirebaseStorage

class RegisterViewController: UIViewController,UITextFieldDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate {

    @IBOutlet var imgView: UIImageView!
    @IBOutlet var nameInput: UITextField!
    @IBOutlet var emailInput: UITextField!
    @IBOutlet var passwordInput: UITextField!
    @IBOutlet var alert: UILabel!
    @IBAction func segHandler(_ sender: UISegmentedControl) {
        let idx = sender.selectedSegmentIndex
        let controller = UIImagePickerController()
        if idx == 0 {
            controller.sourceType = .camera
        }else{
            controller.sourceType = .photoLibrary
        }
        sender.selectedSegmentIndex = -1
        controller.delegate = self
        present(controller,animated: true,completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let img = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        imgView.image = img
        picker.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func confirmBtn(_ sender: UIButton) {
        var name:String = ""
        var email:String = ""
        var password:String = ""
        var alertStr:String = ""
        let userImg = imgView.image
        
        if nameInput.text?.count != 0{
            name = nameInput.text!
            alertStr.append("")
        }else{
            alertStr.append("請輸入名稱資訊\n")
        }
        
        if emailInput.text?.count != 0 {
            if emailInput.text!.contains("@"){
                email = emailInput.text!
                alertStr.append("")
            }else{
                alertStr.append("不合法的Email")
            }
        }else{
            alertStr.append("請輸入Email資訊\n")
        }
        
        if passwordInput.text?.count != 0{
            password = passwordInput.text!
            alertStr.append("")
        }else {
            alertStr.append("請輸入密碼資訊")
        }
        alert.text = alertStr
        if alert.text?.count == 0 {
            self.navigationController?.popViewController(animated: true)?.dismiss(animated: true, completion: nil)
            Account.setUserInfo(email: email, name: name, password: password)
        }
        //將image寫到storage
        let uniqueString = NSUUID().uuidString
        if let selectedImage = userImg {
            let storageRef = Storage.storage().reference().child("userPic").child("\(uniqueString).png")
            if let uploadData = selectedImage.pngData() {
                //FirebaseStorage的存取方法
                storageRef.putData(uploadData, metadata: nil, completion: {(data, error) in
                    if error != nil {
                        // 若有接收到錯誤就直接印在Console
                        print("Error: \(error!.localizedDescription)")
                        return
                    }else{
                        print("complete upload")
                    }
                })
            }
            
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameInput.delegate = self
        emailInput.delegate = self
        passwordInput.delegate = self
    }
}
