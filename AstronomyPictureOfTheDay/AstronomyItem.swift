//
//  AstronomyItem.swift
//  AstronomyPictureOfTheDay
//
//  Created by Håkon Bogen on 28/01/15.
//  Copyright (c) 2015 hakonbogen. All rights reserved.
//

import Foundation
import CoreData

class AstronomyItem: NSManagedObject {

    @NSManaged var copyright: String
    @NSManaged var identifier: String
    @NSManaged var url: String
    @NSManaged var descriptionText: String
    @NSManaged var date: NSDate
    @NSManaged var originalImage: NSData
    @NSManaged var originalImageURL : String
    
    convenience init(date: NSDate, sourceHTML: String, managedObjectContext: NSManagedObjectContext) {
        self.init(date:date, managedObjectContext: managedObjectContext)
        originalImageURL = sourceHTML.pictureUrlFromNASAHtmlContent()!.absoluteString!
        self.descriptionText = sourceHTML.descriptionFromNASAHTMLContent()
        
    }
    
    convenience init(date: NSDate, managedObjectContext: NSManagedObjectContext) {
        let entityDescription = NSEntityDescription.entityForName("AstronomyItem", inManagedObjectContext: managedObjectContext)
        let fetchRequest = NSFetchRequest()
        fetchRequest.predicate = NSPredicate(format: "date >= %@ and date <= %@", date.startOfDay(),date.endOfDay())
        fetchRequest.entity = entityDescription
        
        fetchRequest.entity = entityDescription
        var error : NSError?
        
        let results : NSArray = managedObjectContext.executeFetchRequest(fetchRequest, error: &error)!
        
        if (error != nil) {
            
        }
        
        var astronomyItem: AstronomyItem?
        
        if (results.count == 0) {
            self.init(entity: entityDescription!, insertIntoManagedObjectContext:managedObjectContext)
            self.date = date
        } else {
            self.init()
            astronomyItem = results.firstObject as AstronomyItem!
            self.date = astronomyItem!.date
        }
        
    }
}
