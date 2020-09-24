//
//  SimilarMovieCell.swift
//  FightClub
//
//  Created by APPLE on 23/09/20.
//  Copyright © 2020 APPLE. All rights reserved.
//

import UIKit

class SimilarMovieCell: UICollectionViewCell {
    
    
    @IBOutlet weak var lblMovieName: UILabel!
    @IBOutlet weak var imgSimilarMovie: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setUpData(object: SimilarMovie?) {
        if let obj = object {
            lblMovieName.text = obj.title
        }
    }
}
