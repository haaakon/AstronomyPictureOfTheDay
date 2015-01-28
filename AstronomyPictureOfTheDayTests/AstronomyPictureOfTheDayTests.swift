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
        
        let asignal = PictureImporter.importAstronomyPhotoMetaData(Constants.API.nasaBaseURL, startImmediately: true)
        NSFileManager.defaultManager()
        
        let htmlContent = dataFromFile("exampleFrontPage.html")
        
        asignal.subscribeNext { (response) -> Void in
            println(response)
        }
        
        PictureImporter.sharedPictureImporter.subscriber?.sendNext(htmlContent)
        
    }
    
}
