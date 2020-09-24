//
//  Extension.swift
//  FightClub
//
//  Created by APPLE on 22/09/20.
//  Copyright © 2020 APPLE. All rights reserved.
//

import Foundation
import UIKit

enum ViewCell: String {
case kMovieListCell     = "MovieListCell"
case kMovieCastTCell    = "MovieCastTableViewCell"
case kMovieCastCell     = "MovieCastCell"
case kMovieReviewCell     = "MovieReviewCell"
case kSimilarMovieTCell     = "SimilarMovieTableViewCell"
case kSimilarMovieCell    = "SimilarMovieCell"

}

extension AppDelegate {
func navigationBarSetUp() {
  UIBarButtonItem.appearance().setBackButtonTitlePositionAdjustment(UIOffset(horizontal: -200, vertical: 0), for: .default)
    UINavigationBar.appearance().shadowImage = UIImage()
    UINavigationBar.appearance().setBackgroundImage(UIImage(), for: .default)
    UINavigationBar.appearance().isTranslucent = true
    UINavigationBar.appearance().backgroundColor = .clear
  }
}

extension SceneDelegate {
     func navigationBarSetUp() {
       UIBarButtonItem.appearance().setBackButtonTitlePositionAdjustment(UIOffset(horizontal: -200, vertical: 0), for: .default)
       UINavigationBar.appearance().shadowImage = UIImage()
       UINavigationBar.appearance().setBackgroundImage(UIImage(), for: .default)
       UINavigationBar.appearance().isTranslucent = true
       UINavigationBar.appearance().backgroundColor = .clear
     }
}



extension UIViewController {
    
    func showAlertMessage(alertTitle: String, alertMessage: String, firstBtnTitle: String, secondBtnTitle: String?, completionHandler: ((Bool)-> ())?) {
        let alert = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: .alert)
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 4
        paragraphStyle.alignment = .center
        
        //NSAttributedString.Key.foregroundColor: UIColor.fromHex(hexString: "515151")
        alert.setValue(NSAttributedString(string: "\n\(alertMessage)", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 13), NSAttributedString.Key.paragraphStyle: paragraphStyle]), forKey: "attributedMessage")
        //NSAttributedString.Key.foregroundColor: UIColor.fromHex(hexString: "151d3c")
        alert.setValue(NSAttributedString(string: alertTitle, attributes: [
            NSAttributedString.Key.font: UIFont.systemFontSize ]), forKey: "attributedTitle")
        
        let okAction = UIAlertAction(title: firstBtnTitle, style: .default) { (action) in
            completionHandler?(true)
        }
        alert.addAction(okAction)
        
        if let cancelBtnTitle = secondBtnTitle {
            let cancelAction = UIAlertAction(title: cancelBtnTitle, style: .default) { (action) in
                completionHandler?(false)
            }
            alert.addAction(cancelAction)
        }
        self.present(alert, animated: true, completion: nil)
    }
    
    
    func backButton(_title: String) {
        self.view.endEditing(true)
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        let barButton = UIBarButtonItem(image: UIImage(named: "ic_back"), style: .plain, target: self, action: #selector(UIViewController.gotoBack))
        barButton.title = _title
        barButton.tintColor = UIColor.white
        self.navigationController?.navigationBar.barTintColor = .white
        self.navigationItem.setHidesBackButton(true, animated: false)
        self.navigationItem.leftBarButtonItems = [barButton]
        self.navigationController?.navigationBar.titleTextAttributes = [ NSAttributedString.Key.font : UIFont.systemFont(ofSize: 20.0)  , NSAttributedString.Key.foregroundColor: UIColor.white]
    }
    
    func backPurpleButton(_title: String) {
        self.view.endEditing(true)
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        let barButton = UIBarButtonItem(image: UIImage(named: "ic_back"), style: .plain, target: self, action: #selector(UIViewController.gotoBack))
        barButton.title = _title
        barButton.tintColor = UIColor.getColor(fromHex: "#17152E")
        self.navigationController?.navigationBar.barTintColor = .white
        self.navigationItem.setHidesBackButton(true, animated: false)
        self.navigationItem.leftBarButtonItems = [barButton]
        self.navigationController?.navigationBar.titleTextAttributes = [ NSAttributedString.Key.font : UIFont.systemFont(ofSize: 20.0)  , NSAttributedString.Key.foregroundColor: UIColor.getColor(fromHex: "#17152E")]
    }

    
    func showRecent() {
        self.view.endEditing(true)
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        let barButton = UIBarButtonItem(title: "Show recents", style: .plain, target: self, action: #selector(UIViewController.goToRecent))
        barButton.tintColor = UIColor.white
        self.navigationController?.navigationBar.barTintColor = UIColor.getColor(fromHex: "#17152E")
        self.navigationItem.setHidesBackButton(true, animated: false)
        self.navigationItem.rightBarButtonItems = [barButton]
        self.navigationController?.navigationBar.titleTextAttributes = [ NSAttributedString.Key.font : UIFont.systemFont(ofSize: 20.0)  , NSAttributedString.Key.foregroundColor: UIColor.getColor(fromHex: "#17152E")]
    }

    
    @objc func gotoBack() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func goToRecent() {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "CoreDataMovieListViewController") as! CoreDataMovieListViewController
         self.navigationController?.pushViewController(vc, animated: true)

    }
    
}


extension UIView {
    func setViewShadow(color:UIColor) {
        self.layoutIfNeeded()
        self.layer.shadowColor = color.cgColor
        layer.shadowOpacity = 1.0
        self.layer.cornerRadius = 10.0
        self.clipsToBounds = true
        layer.shadowOffset = CGSize(width: 0, height: 20)
        layer.shadowOpacity = 1.0//25
        layer.shadowRadius = 10//15
    }
    
    func setBorder(color:UIColor) {
        self.layer.borderWidth = 1.0
        self.layer.borderColor = color.cgColor
    }
}


public extension UIColor {
    
    static func getColor(fromHex hex:String, opacity: Float = 1.0) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        if ((cString.count) != 6) {
            return UIColor.gray
        }
        
        var rgbValue:UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(opacity)
        )
    }
}

