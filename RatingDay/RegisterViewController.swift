//
//  RegisterViewController.swift
//  RatingDay
//
//  Created by Tzu-Yen Huang on 2018/10/4.
//  Copyright © 2018年 Tzu-Yen Huang. All rights reserved.
//

import UIKit

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
        
        let ud = UserDefaults.standard
        var alertStr:String = ""
        
        //save imgView.image to userDefaults => save as Data
        let userImg = imgView.image!.pngData()
        ud.set(userImg, forKey: "USERIMG")

        
        if nameInput.text?.count != 0{
            ud.set(nameInput.text, forKey: "USERNAME")
            alertStr.append("")
        }else{
            alertStr.append("請輸入名稱資訊\n")
        }
        
        if emailInput.text?.count != 0 {
            if emailInput.text!.contains("@"){
                ud.set(emailInput.text, forKey: "USEREMAIL")
                alertStr.append("")
            }else{
                alertStr.append("不合法的Email")
            }
        }else{
            alertStr.append("請輸入Email資訊\n")
        }
        
        if passwordInput.text?.count != 0{
            ud.set(passwordInput.text, forKey: "USERPASSWORD")
            alertStr.append("")
        }else {
            alertStr.append("請輸入密碼資訊")
        }
        alert.text = alertStr
        if alert.text?.count == 0 {
            self.navigationController?.popViewController(animated: true)?.dismiss(animated: true, completion: nil)
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
