//
//  MovieReviewCell.swift
//  FightClub
//
//  Created by APPLE on 23/09/20.
//  Copyright © 2020 APPLE. All rights reserved.
//

import UIKit

class MovieReviewCell: UITableViewCell {
    @IBOutlet weak var lblReview: UILabel!
    @IBOutlet weak var lblAuthor: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setUpData(object: Review?) {
        if let obj = object {
            lblReview.text = obj.content
            lblAuthor.text = obj.author
        }
    }

}
