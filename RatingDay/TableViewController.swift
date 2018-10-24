//
//  TableViewController.swift
//  RatingDay
//
//  Created by Tzu-Yen Huang on 2018/10/23.
//  Copyright © 2018年 Tzu-Yen Huang. All rights reserved.
//

import UIKit

class TableViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    
    @IBOutlet var tableView: UITableView!
    var list = [Restaurant]()
 
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CELLTWO", for: indexPath) as! TableViewCell
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
    
}

    



