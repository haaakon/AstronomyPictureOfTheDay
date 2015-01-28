//
//  AstronomyPictureOfTheDayTests.swift
//  AstronomyPictureOfTheDayTests
//
//  Created by Håkon Bogen on 27/01/15.
//  Copyright (c) 2015 hakonbogen. All rights reserved.
//

import UIKit
import XCTest

class AstronomyPictureOfTheDayTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func jsonDictionaryFromFile(filename: String) -> Dictionary<String, AnyObject> {
        let testBundle = NSBundle(forClass: AstronomyPictureOfTheDayTests.self)
        let path = testBundle.pathForResource(filename, ofType: nil)
        XCTAssertNotNil(path, "wrong filename")
        let data = NSData(contentsOfFile: path!)
        XCTAssertNotNil(data, "wrong filename")
        var error : NSError?
        let jsonDictionary = NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.AllowFragments, error: &error) as Dictionary<String,AnyObject>
        XCTAssertNil(error, "could not read json")
        return jsonDictionary
    }
    
    func dataFromFile(filename: String) -> NSData {
        let testBundle = NSBundle(forClass: AstronomyPictureOfTheDayTests.self)
        let path = testBundle.pathForResource(filename, ofType: nil)
        XCTAssertNotNil(path, "wrong filename")
        let data = NSData(contentsOfFile: path!)
        XCTAssertNotNil(data, "wrong filename")
        var error : NSError?
        XCTAssertNil(error, "could not read json")
        return data!
    }
   
    func testParseFrontPage() {
        let date = NSDate()
        let signal = PictureImporter.importAstronomyPhotoMetaData(date: date, startImmediately: true)
        let htmlContent = dataFromFile("exampleFrontPage.html")
        signal.subscribeNext { (response) -> Void in
            let astronomyItem = response as AstronomyItem
            XCTAssertNotNil(astronomyItem, "could not create astronomy item from date and html")
            XCTAssertEqual(date, astronomyItem.date, "dates created and fetched was not equal")
            XCTAssertEqual(astronomyItem.originalImageURL, "http://apod.nasa.gov/apod/image/1501/GalacticMagneticField_planck_3197.jpg", "")
        }
        PictureImporter.sharedPictureImporter.subscriber?.sendNext(htmlContent)
    }
    
}
