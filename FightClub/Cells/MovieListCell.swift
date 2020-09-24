//
//  MovieListCell.swift
//  FightClub
//
//  Created by APPLE on 22/09/20.
//  Copyright © 2020 APPLE. All rights reserved.
//

import UIKit

class MovieListCell: UITableViewCell {
    
 //MARK: - Declaration -
    
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var imgMovie: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblReleaseDate: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
    
    @IBOutlet weak var btnBook: UIButton!
    var blockBook:(()->())?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        mainView.setViewShadow(color: UIColor.systemPink)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func btnBookClicked(_ sender: UIButton) {
        if blockBook != nil {
            self.blockBook?()
        }
    }
    
    
    func setData(object: Movie?) {
        if let obj = object {
            lblTitle.text = obj.title
            lblReleaseDate.text = obj.release_date
            lblDescription.text = obj.overview
        }
    }
    
}
