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
    @NSManaged var descriptionText: String
    @NSManaged var date: NSDate
    @NSManaged var originalImage: NSData

}
