//
//  NewViewController.swift
//  RatingDay
//
//  Created by Tzu-Yen Huang on 2018/10/12.
//  Copyright © 2018年 Tzu-Yen Huang. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate{
    var list = [Restaurant]()
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.search.resignFirstResponder()
        list = RestaurantDAO.getResByName(name: self.search.text ?? "")!
        tableView.reloadData()
    }
    
    @IBOutlet var search: UISearchBar!
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
        let next = segue.destination as! ContentViewController
        next.placeId = list[tableView.indexPathForSelectedRow!.row].placeId
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        search.delegate = self
        

        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
        list = RestaurantDAO.getAllRestaurant()!
        tableView.reloadData()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
    }

}
