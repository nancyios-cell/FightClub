//
//  MovieDetailViewModel.swift
//  FightClub
//
//  Created by APPLE on 23/09/20.
//  Copyright © 2020 APPLE. All rights reserved.
//

import UIKit
protocol MovieDetailViewProtocol : UITableViewDelegate, UITableViewDataSource {
    func callMovieIDApi(_ completionHandler: @escaping (_ isSuccess: Bool, _ response: MovieIdResponse?)->())
    func movieId(_ id: Int)
    func callMovieReviewApi(_ completionHandler: @escaping (_ isSuccess: Bool)->())
    func callMovieCastApi(_ completionHandler: @escaping (_ isSuccess: Bool)->())
    func callSimilarMovieApi(_ completionHandler: @escaping (_ isSuccess: Bool, _ response: [SimilarMovie]?)->())
}

class MovieDetailViewModel: NSObject, MovieDetailViewProtocol {

    var movieId = 0
    var movieIdObj : MovieIdResponse!
    var movieReviewObj = [Review]()
    var movieCastObj = [Credit]()
    var movieSimilarObj = [SimilarMovie]()
    
    func movieId(_ id: Int) {
        print("MovieId \(id)")
        self.movieId = id
    }
    
    func callMovieIDApi(_ completionHandler: @escaping (Bool, MovieIdResponse?) -> ()) {
        WebServices().getMovieWithId(id: movieId, completionHandler: { (success, response) in
            if success {
                    self.movieIdObj = response
                completionHandler(true, response!)
            } else {
                completionHandler(false,response ?? self.movieIdObj)
            }
        })
    }
    
    func callSimilarMovieApi(_ completionHandler: @escaping (Bool, [SimilarMovie]?) -> ()) {
        WebServices().getSimilarMovie(id: movieId, completionHandler: { (success, response) in
            if success {
                if response?.results.count ?? 0 > 0 {
                    self.movieSimilarObj = response!.results
                    completionHandler(true,response!.results)
                } else {
                    completionHandler(false, response?.results ?? [SimilarMovie]())
                }
            } else {
                completionHandler(false, response?.results ?? [SimilarMovie]())
            }
        })
        
    }
    
    func callMovieCastApi(_ completionHandler: @escaping (Bool) -> ()) {
        WebServices().getMovieCast(id: movieId, completionHandler: { (success, response) in
            if success {
                if (response?.cast.count)! > 0 {
                    self.movieCastObj = response!.cast
                    completionHandler(true)
                } else {
                    completionHandler(false)
                }
            } else {
                completionHandler(false)
            }
        })
        
    }
    
    func callMovieReviewApi(_ completionHandler: @escaping (Bool) -> ()) {
        WebServices().getMovieReview(id: movieId, completionHandler: { (success, response) in
            if success {
                if response?.results.count ?? 0 > 0 {
                    self.movieReviewObj = response!.results
                    completionHandler(true)
                } else {
                    completionHandler(false)
                }
            } else {
                completionHandler(false)
            }
        })
        
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 1 {
            return movieReviewObj.count
        }
        return 1
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 && indexPath.section == 0 {
            if let cell = tableView.dequeueReusableCell(withIdentifier: ViewCell.kMovieCastTCell.rawValue, for: indexPath) as? MovieCastTableViewCell {
                cell.collectionViewMovieCast.delegate = self
                cell.collectionViewMovieCast.tag = 0
                cell.collectionViewMovieCast.dataSource = self
                cell.collectionViewMovieCast.layoutIfNeeded()
                let contentOffset = cell.collectionViewMovieCast.contentOffset
                cell.collectionViewMovieCast.setContentOffset(contentOffset, animated: false)
                let layout = UICollectionViewFlowLayout()
                layout.scrollDirection = .horizontal
                cell.collectionViewMovieCast.collectionViewLayout.invalidateLayout()
                cell.collectionViewMovieCast.collectionViewLayout = layout
                cell.collectionViewMovieCast.reloadData()
                
                return cell }
            else { return UITableViewCell() }  }
        
        if indexPath.section == 1 {
            if let cell = tableView.dequeueReusableCell(withIdentifier: ViewCell.kMovieReviewCell.rawValue, for: indexPath) as? MovieReviewCell {
                cell.setUpData(object: movieReviewObj[indexPath.row])
                return cell }  else { return UITableViewCell() }  }
        
        if indexPath.section == 2 {
            if let cell = tableView.dequeueReusableCell(withIdentifier: ViewCell.kSimilarMovieTCell.rawValue, for: indexPath) as? SimilarMovieTableViewCell {
                cell.collectionViewSimilarMovie.delegate = self
                cell.collectionViewSimilarMovie.dataSource = self
                cell.collectionViewSimilarMovie.tag = 1
                let layout = UICollectionViewFlowLayout()
                layout.scrollDirection = .horizontal
                cell.collectionViewSimilarMovie.collectionViewLayout.invalidateLayout()
                cell.collectionViewSimilarMovie.collectionViewLayout = layout
                let contentOffset = cell.collectionViewSimilarMovie.contentOffset
                cell.collectionViewSimilarMovie.setContentOffset(contentOffset, animated: false)
                cell.collectionViewSimilarMovie.reloadData()
                
                return cell } else {return UITableViewCell()}  }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 && indexPath.section == 0 {
            return 90
        } else if indexPath.section == 1 {
            return UITableView.automaticDimension
        } else if indexPath.section == 2 && indexPath.row == 0  {
            return 220
        }
        return 0.0
    }
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 && indexPath.section == 0 {
            return UITableView.automaticDimension
        } else if indexPath.row == 1 && indexPath.section == 1 {
            return UITableView.automaticDimension
        } else {
            return UITableView.automaticDimension
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 35
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0
    }
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: "HeaderView") as? HeaderView {
            if section == 0 {
                view.lbltext.text = "Cast"
            } else if section == 1 {
                view.lbltext.text = "Reviews"
            } else {
                view.lbltext.text = "Similar Movies"
            }
            view.lbltext.textColor = .white
            view.lbltext.font = UIFont.boldSystemFont(ofSize: 14.0)
            // view.backgroundColor = UIColor.white
            return view
        }  else { return UIView() }
    }        

    
}

//MARK: - UICollectionView Method -
extension MovieDetailViewModel: UICollectionViewDelegateFlowLayout, UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView.tag == 0 { // MovieCast
            return movieCastObj.count
        } else { // Similar Movies
            return movieSimilarObj.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView.tag == 0 {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ViewCell.kMovieCastCell.rawValue, for: indexPath) as? MovieCastCell else {return UICollectionViewCell()}
            cell.setUpData(object: movieCastObj[indexPath.item])
            return cell
        } else {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ViewCell.kSimilarMovieCell.rawValue, for: indexPath) as? SimilarMovieCell else {return UICollectionViewCell()}
            cell.setUpData(object: movieSimilarObj[indexPath.item])
            return cell
            
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let minimumInteritemSpacing:CGFloat = 8
        let minimumLineSpacing:CGFloat = 10
        //let width = securityHoldings.count == 1 ? (1,15) : (0.92,0.0)
        let width = (1,20)
        var itemWidth : CGFloat = 0.0; var itemHeight : CGFloat = 0.0
        
        if collectionView.tag == 0 {
            itemWidth = ((collectionView.bounds.width/2 * CGFloat(width.0)) - CGFloat(width.1)) - (minimumLineSpacing + minimumInteritemSpacing)
            itemHeight = collectionView.bounds.height
        } else {
            itemWidth = ((collectionView.bounds.width * CGFloat(width.0)) - CGFloat(width.1)) - (minimumLineSpacing + minimumInteritemSpacing)
            itemHeight = collectionView.bounds.height
            
        }
        return CGSize(width: itemWidth, height: itemHeight)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: 0, height: 0)
    }
}
