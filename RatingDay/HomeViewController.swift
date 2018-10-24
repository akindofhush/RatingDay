//
//  NewViewController.swift
//  RatingDay
//
//  Created by Tzu-Yen Huang on 2018/10/12.
//  Copyright © 2018年 Tzu-Yen Huang. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate, UIPickerViewDelegate,UIPickerViewDataSource{
    
    let pickerList = ["綜合評分排序","Google評分排序","TripAdvisor評分排序"]
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerList.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerList[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if row == 0 {
            list = list.sorted(by:{
                var comRating0 = 0.0
                if $0.googleRating != 0.0{
                    if $0.tripRating != 0.0{
                        comRating0 = ($0.googleRating + $0.tripRating)/2.0
                    }else{
                        comRating0 = $0.googleRating
                    }
                }else{
                    if $0.tripRating != 0.0{
                        comRating0 = $0.tripRating
                    }
                }
                var comRating1 = 0.0
                if $1.googleRating != 0.0{
                    if $1.tripRating != 0.0{
                        comRating1 = ($1.googleRating + $1.tripRating)/2.0
                    }else{
                        comRating1 = $1.googleRating
                    }
                }else{
                    if $1.tripRating != 0.0{
                        comRating1 = $1.tripRating
                    }
                }
                return comRating0 > comRating1
            })
        }else if row == 1{
            list = list.sorted(by:{ $0.googleRating > $1.googleRating })
        }else if row == 2{
            list = list.sorted(by:{ $0.tripRating > $1.tripRating })
        }
        
    }
    
    var list = [Restaurant]()
    @IBOutlet var search: UISearchBar!
    @IBOutlet var pickerView: UIView!
    
    
    @IBAction func doneClick(_ sender: UIButton) {
        displayPickerView(false)
        tableView.reloadData()
        
    }
    @IBAction func selectClick(_ sender: UIButton) {
        displayPickerView(true)
    }
    
    func displayPickerView(_ show:Bool){
        for constraint in view.constraints{
            if constraint.identifier == "bottom"{
                constraint.constant = (show) ? -50:128
                break
            }
        }
        UIView.animate(withDuration: 0.5){
            self.view.layoutIfNeeded()
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.search.resignFirstResponder()
        list = RestaurantDAO.getResByName(name: self.search.text ?? "")!
        tableView.reloadData()
    }
    

    @IBOutlet var tableView: UITableView!
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CELL", for: indexPath) as! HomeTableViewCell
        cell.resName.text = list[indexPath.row].name
        if let data = list[indexPath.row].photo{
            cell.picture.image = UIImage(data: data)
        }
        cell.phone.text = list[indexPath.row].phone
        cell.address.text = list[indexPath.row].address
        var comRating = 0.0
        if list[indexPath.row].googleRating != 0.0{
            if list[indexPath.row].tripRating != 0.0{
                comRating = (list[indexPath.row].googleRating + list[indexPath.row].tripRating)/2.0
            }else{
                comRating = list[indexPath.row].googleRating
            }
        }else{
            if list[indexPath.row].tripRating != 0.0{
                comRating = list[indexPath.row].tripRating
            }
        }
        cell.rating.text = String(comRating)
        cell.type.text = list[indexPath.row].type
        Rating.printStarsByRating(rating:comRating,star1:cell.star1,star2:cell.star2,star3:cell.star3,star4:cell.star4,star5:cell.star5)
        
        return cell
    }

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "content" {
            let next = segue.destination as! ContentViewController
            next.placeId = list[tableView.indexPathForSelectedRow!.row].placeId
        }else if segue.identifier == "type"{
            
        }else{
          
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        search.delegate = self
        list = RestaurantDAO.getAllRestaurant()!
        list = list.sorted(by:{
            var comRating0 = 0.0
            if $0.googleRating != 0.0{
                if $0.tripRating != 0.0{
                    comRating0 = ($0.googleRating + $0.tripRating)/2.0
                }else{
                    comRating0 = $0.googleRating
                }
            }else{
                if $0.tripRating != 0.0{
                    comRating0 = $0.tripRating
                }
            }
            var comRating1 = 0.0
            if $1.googleRating != 0.0{
                if $1.tripRating != 0.0{
                    comRating1 = ($1.googleRating + $1.tripRating)/2.0
                }else{
                    comRating1 = $1.googleRating
                }
            }else{
                if $1.tripRating != 0.0{
                    comRating1 = $1.tripRating
                }
            }
            return comRating0 > comRating1
        })
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
        //list = RestaurantDAO.getAllRestaurant()!
        //tableView.reloadData()
        //設定pickerview
        view.addSubview(pickerView)
        //關掉autoresizing
        pickerView.translatesAutoresizingMaskIntoConstraints = false
        pickerView.heightAnchor.constraint(equalToConstant: 128).isActive = true
        pickerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
        pickerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10).isActive = true
        //預設讓pickerView在隱藏在下方
        let bottomConstraint = pickerView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 128)
        bottomConstraint.identifier = "bottom"
        bottomConstraint.isActive = true
        
        pickerView.layer.cornerRadius = 10
        
        super.viewWillAppear(animated)
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
        
    }

}
