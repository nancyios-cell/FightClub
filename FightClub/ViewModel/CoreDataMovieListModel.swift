//
//  CoreDataMovieListModel.swift
//  FightClub
//
//  Created by APPLE on 24/09/20.
//  Copyright © 2020 APPLE. All rights reserved.
//

import UIKit
import CoreData

protocol CoreDataMovieListModelProtocol : UITableViewDelegate, UITableViewDataSource {
    func getListEntity(_ data: [NSManagedObject])
}

class CoreDataMovieListModel: NSObject, CoreDataMovieListModelProtocol {
    
    var data = [NSManagedObject]()
    func getListEntity(_ data: [NSManagedObject]) {
        self.data = data
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListDataCell", for:indexPath) as? ListDataCell
        let object = self.data[indexPath.row] as! MovieList
        cell?.lblTitle.text = object.title
        return cell ?? UITableViewCell()
    }
    

}

