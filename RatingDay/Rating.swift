//
//  Rating.swift
//  RatingDay
//
//  Created by Tzu-Yen Huang on 2018/10/12.
//  Copyright © 2018年 Tzu-Yen Huang. All rights reserved.
//

import Foundation
import UIKit
class Rating {
    static func printStarsByRating(rating:Double,star1:UIImageView,star2:UIImageView,star3:UIImageView,star4:UIImageView,star5:UIImageView)->(){
        let emptyStarImage = UIImage(named: "emptystar")
        let halfStarImage = UIImage(named: "halfstar")
        let fullStarImage = UIImage(named: "fullstar")
        if rating >= 0.5 && rating <= 0.99 {
            star1.image = halfStarImage
            star2.image = emptyStarImage
            star3.image = emptyStarImage
            star4.image = emptyStarImage
            star5.image = emptyStarImage
        }
        if rating >= 1 && rating <= 1.49 {
            star1.image = fullStarImage
            star2.image = emptyStarImage
            star3.image = emptyStarImage
            star4.image = emptyStarImage
            star5.image = emptyStarImage
        }
        if rating >= 1.5 && rating <= 1.99 {
            star1.image = fullStarImage
            star2.image = halfStarImage
            star3.image = emptyStarImage
            star4.image = emptyStarImage
            star5.image = emptyStarImage
        }
        if rating >= 2 && rating <= 2.49 {
            star1.image = fullStarImage
            star2.image = fullStarImage
            star3.image = emptyStarImage
            star4.image = emptyStarImage
            star5.image = emptyStarImage
        }
        if rating >= 2.5 && rating <= 2.99  {
            star1.image = fullStarImage
            star2.image = fullStarImage
            star3.image = halfStarImage
            star4.image = emptyStarImage
            star5.image = emptyStarImage
        }
        if rating >= 3 && rating <= 3.49 {
            star1.image = fullStarImage
            star2.image = fullStarImage
            star3.image = fullStarImage
            star4.image = emptyStarImage
            star5.image = emptyStarImage
        }
        if rating >= 3.5 && rating <= 3.99{
            star1.image = fullStarImage
            star2.image = fullStarImage
            star3.image = fullStarImage
            star4.image = halfStarImage
            star5.image = emptyStarImage
        }
        if rating >= 4 && rating <= 4.49 {
            star1.image = fullStarImage
            star2.image = fullStarImage
            star3.image = fullStarImage
            star4.image = fullStarImage
            star5.image = emptyStarImage
        }
        if rating >= 4.5 && rating <= 4.99 {
            star1.image = fullStarImage
            star2.image = fullStarImage
            star3.image = fullStarImage
            star4.image = fullStarImage
            star5.image = halfStarImage
        }
        if rating == 5 {
            star1.image = fullStarImage
            star2.image = fullStarImage
            star3.image = fullStarImage
            star4.image = fullStarImage
            star5.image = fullStarImage
        }
        
    }
}
