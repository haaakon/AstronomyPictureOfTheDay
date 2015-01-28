//
//  AstronomyItem+Methods.swift
//  AstronomyPictureOfTheDay
//
//  Created by Håkon Bogen on 28/01/15.
//  Copyright (c) 2015 hakonbogen. All rights reserved.
//

import UIKit
import CoreData

extension AstronomyItem {
    

    
    func astronomyPageURL() -> String{
        //http://apod.nasa.gov/apod/ap140827.html
        let dateformatter = NSDateFormatter()
        dateformatter.dateFormat = "yyMMdd"
        let dateString = dateformatter.stringFromDate(self.date)
        let fullstring = String(format: "http://apod.nasa.gov/apod/ap%@.html", dateString)
        return fullstring
    }
}
