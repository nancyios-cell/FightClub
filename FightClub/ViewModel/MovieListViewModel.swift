//
//  MovieListViewModel.swift
//  FightClub
//
//  Created by APPLE on 22/09/20.
//  Copyright © 2020 APPLE. All rights reserved.
//

import UIKit
import CoreData

protocol MovieListViewProtocol: UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    var didSelectRow: ((_ obj: Movie)->())? {get set}
    var reloadTableView:(()->())? {get set}
    func callApi(_ completionHandler: @escaping (_ isSuccess: Bool)->())
    var reloadData: (()->())? {get set}
}

class MovieListViewModel: NSObject, MovieListViewProtocol {
    var reloadData: (() -> ())?
    var didSelectRow: ((Movie) -> ())?
    var reloadTableView: (() -> ())?
    var showLoader: ((Bool) -> ())?
    var objMovieLists = [Movie]()
    let queue = OperationQueue()
    var searchedText = ""
    var letters = NSMutableArray()
    var objMovieData: [NSManagedObject] = []
    
    
    override init() {
        super.init()
        searchedText = ""
    }
    
    func callApi(_ completionHandler: @escaping (Bool) -> ()) {
        WebServices().getMovieList { (success, response) in
            if success {
                self.objMovieLists = response!.results
                completionHandler(true)
            }
        }
    }
    
    
    //MARK: - UITableView DataSource Methods -
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return objMovieLists.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ViewCell.kMovieListCell.rawValue, for: indexPath) as? MovieListCell else { return UITableViewCell() }
        cell.setData(object: objMovieLists[indexPath.row])
        cell.selectionStyle = .none
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    //MARK: - UITableView Delegate Methods -
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        DispatchQueue.main.async {
            self.save(name: self.objMovieLists[indexPath.row].title)
        }
        self.didSelectRow?(objMovieLists[indexPath.row])
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchedText = searchText
        //          if self.searchedText.isEmpty {
        //           // self.showLoader?(true)
        //             self.queue.addOperation {
        //                  DispatchQueue.main.async {
        //                  self.showLoader?(false)
        //               }
        //             }
        //         }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        //        if !self.searchedText.isEmpty {
        //            self.showLoader?(true)
        //            self.queue.addOperation {
        //                sortObject()
        //            }
        //        }
    }
    
    
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        true
    }
    
}


extension MovieListViewModel {
    
    /* Search Bar functionality logic*/
    func sortObject() {
        letters = NSMutableArray()
        objMovieLists = [Movie]()
        var tempObjectList = [Movie]()
        var character = [Character]()
        let _ = objMovieLists.map { (object) -> Bool in
            if object.title != "" {
                character.append((object.title).first!)
            }
            return true
        }
        
        character = character.sorted()
        
        for char in character {
            if letters.contains(String(char)) {
            } else {
                letters.add(String(char))
            }
        }
        
        _ = letters.map { (strLetter) -> Bool in
            _ = objMovieLists.map({ (object) -> Bool in
                if object.title != "" {
                    let char = (object.title).first!
                    if strLetter as! String == String(char) {
                        tempObjectList.append(object)
                    }
                }
                return true
            })
            objMovieLists = tempObjectList
            self.reloadData?()
            return true
        }
        
    }
    
    
    func save(name: String) {
        
        guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {
                return
        }
        
        let managedContext =
            appDelegate.persistentContainer.viewContext
        
        let entity =
            NSEntityDescription.entity(forEntityName: "MovieList",
                                       in: managedContext)!
        
        let list = NSManagedObject(entity: entity,
                                   insertInto: managedContext)
        
        list.setValue(name, forKeyPath: "title")
        
        do {
            try managedContext.save()
            objMovieData.append(list)
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
}
