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
    
    
    class func signalForUrlRequest(url: NSURL, startImmediately: Bool) -> RACSignal {
        let signal = RACSignal.createSignal { (subscriber) -> RACDisposable! in
            PictureImporter.sharedPictureImporter.subscriber = subscriber
            let fetchAstronomyPageRequest = NSURLRequest(URL: url)
            let task = PictureImporter.sharedSession.dataTaskWithRequest(fetchAstronomyPageRequest, completionHandler: { (data, response, error) -> Void in
                if let actualError = error {
                    subscriber.sendError(actualError)
                } else {
                    subscriber.sendNext(data)
                }
            })
            if (startImmediately) {
                task.resume()
            }
            
            return RACDisposable(  {
                task.cancel()
            })
        }
        return signal
    }
    
    /**
    parses HTML and creates models based on the data
    
    :param: url              url to fetch html from
    :param: startImmediately whether to do task.resume right away
    
    :returns: signal with models
    */
    class func importAstronomyPhotoMetaData(url: NSURL, startImmediately: Bool) -> RACSignal {
       let signal = signalForUrlRequest(url,startImmediately: startImmediately).map { (responseData) -> AnyObject! in
        let result = NSString(data: responseData as NSData, encoding: NSASCIIStringEncoding) as String
        
        let pictureURL = result.pictureUrlFromNASAHtmlContent()
            return result
        }
        
        return signal
    }
}
