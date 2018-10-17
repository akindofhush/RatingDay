//
//  HomeTableViewCell.swift
//  RatingDay
//
//  Created by Tzu-Yen Huang on 2018/10/11.
//  Copyright © 2018年 Tzu-Yen Huang. All rights reserved.
//

import UIKit

class HomeTableViewCell: UITableViewCell {

    @IBOutlet var picture: UIImageView!
    @IBOutlet var resName: UILabel!
    @IBOutlet var rateName: UILabel!
    @IBOutlet var stars: UILabel!
    @IBOutlet var phone: UILabel!
    @IBOutlet var address: UILabel!
    @IBOutlet var type: UILabel!
    @IBOutlet var rating: UILabel!
    
    @IBOutlet var star1: UIImageView!
    @IBOutlet var star2: UIImageView!
    @IBOutlet var star3: UIImageView!
    @IBOutlet var star4: UIImageView!
    @IBOutlet var star5: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
