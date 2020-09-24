//
//  CoreDataMovieListViewController.swift
//  FightClub
//
//  Created by APPLE on 24/09/20.
//  Copyright © 2020 APPLE. All rights reserved.
//

import UIKit
import CoreData

class ListDataCell : UITableViewCell {
    
    @IBOutlet weak var lblTitle: UILabel!
    
}

class CoreDataMovieListViewController: UIViewController {

    //MARK: - Declaration -
    
    @IBOutlet weak var tblView: UITableView!
    var viewModel : CoreDataMovieListModelProtocol!
    var objLists: [NSManagedObject] = []

    //MARK: - LifeCycle -
    override func viewDidLoad() {
        super.viewDidLoad()
         initialSetup()
        // Do any additional setup after loading the view.
    }
    
    
    func initialSetup() {
        viewModel = CoreDataMovieListModel()
        tblView.delegate = viewModel
        tblView.dataSource = viewModel
        backPurpleButton(_title: "")
        title =  "Recently Visited"
        guard let appDelegate =
          UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let managedContext =
          appDelegate.persistentContainer.viewContext
        
        let fetchRequest =
          NSFetchRequest<NSManagedObject>(entityName: "MovieList")
        
        do {
          objLists = try managedContext.fetch(fetchRequest)
        } catch let error as NSError {
          print("Could not fetch. \(error), \(error.userInfo)")
        }

        viewModel.getListEntity(objLists)
        tblView.reloadData()
    }


}
