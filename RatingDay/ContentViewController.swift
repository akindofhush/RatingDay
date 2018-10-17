//
//  ContentViewController.swift
//  RatingDay
//
//  Created by Tzu-Yen Huang on 2018/10/12.
//  Copyright © 2018年 Tzu-Yen Huang. All rights reserved.
//

import UIKit

class ContentViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet var resPic: UIImageView!
    @IBOutlet var resName: UILabel!
    @IBOutlet var resType: UILabel!
    @IBOutlet var resPhone: UILabel!
    @IBOutlet var resAddress: UILabel!
    @IBOutlet var favorite: UIImageView!
    @IBOutlet var share: UIImageView!
    @IBOutlet var mapConnection: UIButton!
    
    @IBOutlet var comStar1: UIImageView!
    @IBOutlet var comStar2: UIImageView!
    @IBOutlet var comStar3: UIImageView!
    @IBOutlet var comStar4: UIImageView!
    @IBOutlet var comStar5: UIImageView!
    @IBOutlet var googleStar1: UIImageView!
    @IBOutlet var googleStar2: UIImageView!
    @IBOutlet var googleStar3: UIImageView!
    @IBOutlet var googleStar4: UIImageView!
    @IBOutlet var googleStar5: UIImageView!
    @IBOutlet var tripStar1: UIImageView!
    @IBOutlet var tripStar2: UIImageView!
    @IBOutlet var tripStar3: UIImageView!
    @IBOutlet var tripStar4: UIImageView!
    @IBOutlet var tripStar5: UIImageView!
    @IBOutlet var dayStar1: UIImageView!
    @IBOutlet var dayStar2: UIImageView!
    @IBOutlet var dayStar3: UIImageView!
    @IBOutlet var dayStar4: UIImageView!
    @IBOutlet var dayStar5: UIImageView!
    @IBOutlet var comRating: UILabel!
    @IBOutlet var googleRating: UILabel!
    @IBOutlet var tripRating: UILabel!
    @IBOutlet var dayRating: UILabel!
    
    @IBOutlet var segmentControl: UISegmentedControl!
    @IBOutlet var tableView: UITableView!

    
    //Data
    var current:Restaurant!
    var placeId:String = ""
    var googleReviewData = [[String:Any]]()
    
    //favorite 行為設定
    var status = false
    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer){
        if status == false{
            favorite.image = UIImage(named: "fulllove")
            status = true
        }else{
            favorite.image = UIImage(named: "emptylove")
            status = false
        }
        
    }
    //按下前往地圖傳值到下一個畫面
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            let next = segue.destination as! GoogleMapViewController
            next.placeId = current.placeId
    }
    
    
    //segment選取時reload tableView
    @IBAction func segmentValueChanged(_ sender: Any) {
        tableView.reloadData()
    }
    
    //tableView內容設定
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var number = 0
        if segmentControl.selectedSegmentIndex == 0{
            number = googleReviewData.count
        }else if segmentControl.selectedSegmentIndex == 1{
            number = 5
        }else {
            number = 10
        }
        return number
    }
    
   func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "REVIEW", for: indexPath) as! ReviewTableViewCell
        if segmentControl.selectedSegmentIndex == 0{
            let ratingList = GetGoogleReviews.getRatingFromList(reviewList: googleReviewData)
            let authorList = GetGoogleReviews.getAuthorFromList(reviewList: googleReviewData)
            let contentList = GetGoogleReviews.getContentFromList(reviewList: googleReviewData)
            cell.rating.text = String(ratingList[indexPath.row] as! Int)
            cell.author.text = authorList[indexPath.row] as! String
            cell.contentLabel.text = contentList[indexPath.row] as! String
        }else if segmentControl.selectedSegmentIndex == 1{
            cell.rating.text = "0.0"
            cell.author.text = "name"
            cell.contentLabel.text = "review"
        }
        return cell
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        favorite.isUserInteractionEnabled = true
        favorite.addGestureRecognizer(tapGestureRecognizer)
        
        //設定畫面初始值
        current = RestaurantDAO.getResByPlaceId(placeId: placeId)!
        if let data = current.photo{
            resPic.image = UIImage(data: data)
        }
        resName.text = current.name
        resType.text = current.type
        resPhone.text = current.phone
        resAddress.text = current.address
        RestaurantDAO.getDayRatingByPlaceId(placeId: current.placeId, completion:{(data,error) in
            if let error = error{
                print(error.localizedDescription)
            }
            if let data = data{
                self.dayRating.text = String(data)
                Rating.printStarsByRating(rating: data, star1: self.dayStar1, star2: self.dayStar2, star3: self.dayStar3, star4: self.dayStar4, star5: self.dayStar5)
            }
        })
        googleRating.text = String(current.googleRating)
        tripRating.text = String(current.tripRating)
        Rating.printStarsByRating(rating: current.googleRating, star1: googleStar1, star2: googleStar2, star3: googleStar3, star4: googleStar4, star5: googleStar5)
        Rating.printStarsByRating(rating: current.tripRating, star1: tripStar1, star2: tripStar2, star3: tripStar3, star4: tripStar4, star5: tripStar5)
        var comRating = 0.0
        if current.googleRating != 0.0{
            if current.tripRating != 0.0{
                comRating = (current.googleRating + current.tripRating)/2.0//加上取到小數點後第二位
            }else{
                comRating = current.googleRating
            }
        }else{
            if current.tripRating != 0.0{
                comRating = current.tripRating
            }
        }
        self.comRating.text = String(comRating)
        Rating.printStarsByRating(rating: comRating, star1: comStar1, star2: comStar2, star3: comStar3, star4: comStar4, star5: comStar5)
        
        //googlereview data傳入
        GetGoogleReviews.setGoogleReviews(placeId: current.placeId, completion: {(data,error) in
        if let data = data{
            self.googleReviewData = data
            //*****
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        })
    }
    
}
