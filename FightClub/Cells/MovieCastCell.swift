//
//  MovieCastCell.swift
//  FightClub
//
//  Created by APPLE on 23/09/20.
//  Copyright © 2020 APPLE. All rights reserved.
//

import UIKit

class MovieCastCell: UICollectionViewCell {
    //MARK: - Declarations -
    
    @IBOutlet weak var lblActorName: UILabel!
    @IBOutlet weak var imgActor: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setUpData(object: Credit?) {
        if let obj = object {
            lblActorName.text = obj.name
        }
    }
}
