//
//  ViewController.swift
//  AstronomyPictureOfTheDay
//
//  Created by Håkon Bogen on 27/01/15.
//  Copyright (c) 2015 hakonbogen. All rights reserved.
//

import UIKit

class AstronomyItemsViewController: UIViewController {

    private let astronomyItemsViewModel = AstronomyItemsViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        PictureImporter.importAstronomyPhotosMetaData(fromDate: NSDate(), toDate: NSDate().dateBySubtractingDays(10), startImmediately: true)
        
        }
    }
