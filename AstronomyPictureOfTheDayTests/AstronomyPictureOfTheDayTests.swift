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
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
//    
//    it(@"logins successfully", ^{
//    __block id success = @0;
//    void (^theBlock)(NSInvocation *) = ^(NSInvocation *invocation) {
//    void (^passedBlock)( BOOL );
//    [invocation getArgument:&passedBlock atIndex:4];
//    passedBlock(YES);
//    };
//    [[[mock stub] andDo:theBlock] authenticateWithUserName:[OCMArg any] password:[OCMArg any] completion:[OCMArg any]];
//    
//    [[FRPPhotoImporter logInWithUsername:@"username" password:@"password"] subscribeCompleted:^{
//    success = @1;
//    }];
//    expect(success).to.equal(@1);
//    });
    
    
    
//    describe(@"FRPPhotoImporter_ImportPhotos", ^{
//    it(@"requests popular photo data", ^{
//    id mock = [OCMockObject mockForClass:[NSURLConnection class]];
//    __block id resultData;
//    RACSignal *stubAsyn = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
//    [subscriber sendNext:RACTuplePack(nil, [NSData data])];
//    return nil;
//    }];
//    [[[mock stub] andReturn:stubAsyn] rac_sendAsynchronousRequest:[OCMArg any]];
//    
//    [[FRPPhotoImporter requestPhotoData] subscribeNext:^(id x) {
//    resultData = x;
//    }];
//    expect(resultData).to.equal([NSData data]);
//    });
//    });
    
    func testParseFrontPage() {
        
        let asignal = PictureImporter.importAstronomyPhotos(Constants.API.nasaBaseURL, startNow: false)
        NSFileManager.defaultManager()
        
        let htmlContent = dataFromFile("exampleFrontPage.html")
        
        asignal.subscribeNext { (response) -> Void in
            println(response)
        }
        
        PictureImporter.sharedPictureImporter.subscriber?.sendNext(htmlContent)
//        waitForExpectationsWithTimeout(40, nil)
        
    }
    
}
