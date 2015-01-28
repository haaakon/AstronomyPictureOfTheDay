//
//  PictureImporter.swift
//  AstronomyPictureOfTheDay
//
//  Created by Håkon Bogen on 27/01/15.
//  Copyright (c) 2015 hakonbogen. All rights reserved.
//

import UIKit
import Foundation


class PictureImporter: NSObject {
   
    class var sharedSession: NSURLSession {
        struct Singleton {
            static let session = NSURLSession(configuration: NSURLSessionConfiguration.ephemeralSessionConfiguration(), delegate: nil, delegateQueue: nil)
        }
        return Singleton.session as NSURLSession
    }
    
    class var sharedPictureImporter : PictureImporter {
        struct Singleton {
            static let sharedPictureImporter = PictureImporter()
        }
        return Singleton.sharedPictureImporter
    }
    
    var subscriber : RACSubscriber?
    
    
    class func signalForUrlRequest(url: NSURL, startNow: Bool) -> RACSignal {
        let signal = RACSignal.createSignal { (subscriber) -> RACDisposable! in
            PictureImporter.sharedPictureImporter.subscriber = subscriber
            let fetchAstronomyPageRequest = NSURLRequest(URL: url)
            println("HELO WRODL");
            let task = PictureImporter.sharedSession.dataTaskWithRequest(fetchAstronomyPageRequest, completionHandler: { (data, response, error) -> Void in
                if let actualError = error {
                    subscriber.sendError(actualError)
                } else {
                    subscriber.sendNext(data)
                }
            })
            if (startNow) {
                task.resume()
                println("start task")
            }
            
            return RACDisposable(  {
                task.cancel()
            })
        }
        return signal
    }
    
    class func importAstronomyPhotos(url: NSURL, startNow: Bool) -> RACSignal {
       let signal = signalForUrlRequest(url,startNow: startNow).map { (responseData) -> AnyObject! in
        println(responseData)
        let result = NSString(data: responseData as NSData, encoding: NSASCIIStringEncoding) as String
        
        let pictureURL = result.pictureUrlFromNASAHtmlContent()
        
        
            return result
        }
        
        return signal
    }
    
//    class func startDownloadingFrontPage() -> RACSignal {
//        let signal = getAstronomyHTMLPage(nasaURL).deliverOnMainThread().map { (responseData) -> AnyObject! in
//            let result = NSString(data: responseData as NSData, encoding: NSASCIIStringEncoding)
//            println(result)
//            
//            return result
//            
//        }
//            
//        
//        return signal
//    }
    
}
