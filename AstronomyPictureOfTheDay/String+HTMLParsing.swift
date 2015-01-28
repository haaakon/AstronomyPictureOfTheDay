//
//  String+HTMLParsing.swift
//  AstronomyPictureOfTheDay
//
//  Created by Håkon Bogen on 27/01/15.
//  Copyright (c) 2015 hakonbogen. All rights reserved.
//

import UIKit

extension String {
    
    func pictureUrlFromNASAHtmlContent()-> NSURL? {
        var error : NSError? = nil
        let regex = NSRegularExpression(pattern: "\"(.*.jpg|png|gif|jpeg)\\b", options: .CaseInsensitive, error: &error)!
        let matches: NSArray! = regex.matchesInString(self, options: nil, range: NSMakeRange(0, self.utf16Count))
        var url: NSURL?
        regex.enumerateMatchesInString(self, options: nil, range: NSMakeRange(0, self.utf16Count)) { (result : NSTextCheckingResult! , flags: NSMatchingFlags, pointer: UnsafeMutablePointer) -> Void in
            let nsStringContent: NSString = self;
            let matchString: String? = nsStringContent.substringWithRange(NSMakeRange(result.range.location + 1, result.range.length - 1))
            if (matchString != nil){
                let urlString = "http://apod.nasa.gov/apod/" + matchString!
                url = NSURL(string:urlString)!
                var shouldStop: ObjCBool = true
                pointer.initialize(shouldStop)
            }
        }
        
        if let urlstring = url {
            return urlstring
        } else {
            return nil
        }
    }
    
    func descriptionFromNASAHTMLContent() -> String {
        let regex = NSRegularExpression(pattern: "ion:\\s((?:[^;])+)Tomorrow's", options: .CaseInsensitive, error: nil)
        let matches: NSArray! = regex!.matchesInString(self, options: nil, range: NSMakeRange(0, self.utf16Count))
        var description = ""
        regex!.enumerateMatchesInString(self, options: nil, range: NSMakeRange(0, self.utf16Count)) { (result : NSTextCheckingResult! , flags: NSMatchingFlags, pointer: UnsafeMutablePointer) -> Void in
            let nsStringContent: NSString = self;
            let matchString: String? = nsStringContent.substringWithRange(NSMakeRange(result.range.location + 1, result.range.length - 1))
            var shouldStop: ObjCBool = true
            description = matchString!
            pointer.initialize(shouldStop)
        }
        return description
    }
 
}
