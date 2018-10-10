//
//  Restaurant.swift
//  RatingDay
//
//  Created by Tzu-Yen Huang on 2018/10/8.
//  Copyright © 2018年 Tzu-Yen Huang. All rights reserved.
//

import Foundation

struct Restaurant{
    var placeId = ""
    var name = ""
    var address = ""
    var photo : Data?
    var phone = ""
    var lat = 0.0
    var lng = 0.0
    var googleRating = 0.0
    var tripRating = 0.0
    var type = ""
    
    //firebase
    var likeNum = 0
    var dayRating = 0.0
}
