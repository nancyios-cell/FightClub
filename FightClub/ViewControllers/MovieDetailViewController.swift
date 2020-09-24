//
//  MovieDetailViewController.swift
//  FightClub
//
//  Created by APPLE on 23/09/20.
//  Copyright © 2020 APPLE. All rights reserved.
//

import UIKit

class MovieDetailViewController: UIViewController {
    //MARK: - Declaration -
    var viewModel : MovieDetailViewProtocol!
    
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblMovieVote: UILabel!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblMovieType: UILabel!
    @IBOutlet weak var mainTableView: UITableView!
    var movieId = 0
    var movieTitle = ""
    
    //MARK: - View Controller Life Cycles -
    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetup()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        mainTableView.delegate = viewModel
        mainTableView.dataSource = viewModel
        mainTableView.register(UINib(nibName: "HeaderView", bundle: Bundle.main), forHeaderFooterViewReuseIdentifier: "HeaderView")
        
        self.viewModel.movieId(movieId)
            self.viewModel.callMovieIDApi { (success,response)  in
                if success {
                    DispatchQueue.main.async {
                        self.lblDate.text = "\(response?.status ?? "") on \(response?.release_date ?? ""))"
                        self.lblMovieType.text = response?.genres[0].name
                        self.lblMovieVote.text = "\( response?.vote_average ?? 0.0))"
                    }
                } else {
                    self.showAlertMessage(alertTitle: "Fight Club Error", alertMessage: " Movie List Error", firstBtnTitle: "Okay", secondBtnTitle: nil, completionHandler: nil)
                }
            }
            self.viewModel.callMovieCastApi {(success) in
                if success {
                    print("2")
                } else {
                    self.showAlertMessage(alertTitle: "Fight Club Error", alertMessage: "No Movie Casts", firstBtnTitle: "Okay", secondBtnTitle: nil, completionHandler: nil)
                }
            }
            self.viewModel.callMovieReviewApi {(success) in
                if success {
                    print("3")
                } else {
                    self.showAlertMessage(alertTitle: "Fight Club Error", alertMessage: "No Movie Reviews", firstBtnTitle: "Okay", secondBtnTitle: nil, completionHandler: nil)
                }
            }
            self.viewModel.callSimilarMovieApi {(success,response) in
                if success {
                    
                    print("4")
                } else {
                    self.showAlertMessage(alertTitle: "Fight Club Error", alertMessage: "No Similar Movies", firstBtnTitle: "Okay", secondBtnTitle: nil, completionHandler: nil)
                }
            }
            DispatchQueue.main.async {
                self.mainTableView.reloadData()
            }
    }
    
    func initialSetup() {
        title = "Details"
        viewModel = MovieDetailViewModel()
        backButton(_title: "")
        lblTitle.text = movieTitle
    }
    
    
}
