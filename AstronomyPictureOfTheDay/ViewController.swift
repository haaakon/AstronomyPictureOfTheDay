//
//  ViewController.swift
//  AstronomyPictureOfTheDay
//
//  Created by Håkon Bogen on 27/01/15.
//  Copyright (c) 2015 hakonbogen. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        PictureImporter.importAstronomyPhotos(Constants.API.nasaBaseURL, startNow: true).subscribeNext { (stuff) -> Void in
            println(stuff)
        }
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

