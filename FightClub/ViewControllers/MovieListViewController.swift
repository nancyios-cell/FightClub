//
//  ViewController.swift
//  FightClub
//
//  Created by APPLE on 22/09/20.
//  Copyright © 2020 APPLE. All rights reserved.
//

import UIKit

class MovieListViewController: UIViewController, UISearchBarDelegate{
    //MARK: - Declaration -
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tblMovieList: UITableView!
    var viewModel: MovieListViewProtocol!
    var searchedText = ""
    
    //MARK: - ViewController LifeCycle -
    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.titleTextAttributes = [ NSAttributedString.Key.font : UIFont.systemFont(ofSize: 20.0)  , NSAttributedString.Key.foregroundColor: UIColor.white]
        searchBar.delegate = self
        viewModel.callApi { (success) in
            if success {
                DispatchQueue.main.async {
                    self.tblMovieList.reloadData()
                }
            }
        }
        
        viewModel.didSelectRow = {(obj) in
            
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "MovieDetailViewController") as! MovieDetailViewController
            vc.movieId = obj.id
            vc.movieTitle = obj.title
            self.navigationController?.pushViewController(vc,
                                                          animated: true)
        }
        
        viewModel.reloadTableView? = {() in
            self.tblMovieList.reloadData()
        }
    }
    
    func initialSetup() {
        viewModel = MovieListViewModel()
        showRecent()
        tblMovieList.delegate = viewModel
        tblMovieList.dataSource = viewModel
        tblMovieList.register(UINib(nibName: ViewCell.kMovieListCell.rawValue, bundle: nil), forCellReuseIdentifier: ViewCell.kMovieListCell.rawValue)
        
    }
    
}



