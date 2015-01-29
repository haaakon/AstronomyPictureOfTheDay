//
//  AstronomyItemsDataSource.swift
//  AstronomyPictureOfTheDay
//
//  Created by Håkon Bogen on 29/01/15.
//  Copyright (c) 2015 hakonbogen. All rights reserved.
//

import UIKit
import CoreData

class AstronomyItemsDataSource: NSObject, UITableViewDataSource {
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let sections = fetchedResultController.sections as NSArray!
        return sections.count
    }
   
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as UITableViewCell
        configureCell(cell, indexPath: indexPath)
        return cell
    }
    
    func configureCell(cell: UITableViewCell, indexPath: NSIndexPath){
        // do configuration of cells UI
    }
    
    private lazy var fetchedResultController : NSFetchedResultsController = {
        let fetchRequest = NSFetchRequest(entityName: <#entityName#>)
        let sortDescriptor = NSSortDescriptor(key: <#key#>, ascending: <#isAscending#>)
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        var controller = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext:<#managedObjectContext#>, sectionNameKeyPath: nil, cacheName: nil)
        
        return controller
        }()
    
}
