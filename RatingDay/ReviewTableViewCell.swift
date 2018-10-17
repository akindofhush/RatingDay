//
//  ReviewTableViewCell.swift
//  RatingDay
//
//  Created by Tzu-Yen Huang on 2018/10/16.
//  Copyright © 2018年 Tzu-Yen Huang. All rights reserved.
//

import UIKit

class ReviewTableViewCell: UITableViewCell {
    @IBOutlet var author: UILabel!
    @IBOutlet var rating: UILabel!
    @IBOutlet var contentLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
