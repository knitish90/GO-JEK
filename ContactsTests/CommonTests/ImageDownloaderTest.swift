//
//  ImageDownloaderTest.swift
//  ContactsTests
//
//  Created by Nitish.kumar on 29/03/20.
//  Copyright © 2020 Nitish.kumar. All rights reserved.
//

import XCTest
@testable import Contacts

class ImageDownloaderTest: XCTestCase {

    var expectation : XCTestExpectation?
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        expectation = self.expectation(description: "testing download image")
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testImagedownloadFailure_withInvalidImageURL() {
        var downloadedImage :   UIImage?
        let testUrl = "https://test.png"
        imageDownloader.downloadImage(imageURL: testUrl) { (image, error) in
            downloadedImage =   image
            self.expectation?.fulfill()
        }
        waitForExpectations(timeout: 10, handler: nil)
        XCTAssertNil(downloadedImage)
    }
    
    func testImagedownloadFailure_WithEmptyImageURL() {
        var downloadedImage :   UIImage?
        let testUrl = ""
        imageDownloader.downloadImage(imageURL: testUrl) { (image, error) in
            downloadedImage =   image
            self.expectation?.fulfill()
        }
        waitForExpectations(timeout: 10, handler: nil)
        XCTAssertNil(downloadedImage)
    }
    
    func testImageDownloadSuccess_WithValidImageURl() {
        var downloadedImage :   UIImage?
        let testUrl = "http://gojek-contacts-app.herokuapp.com/images/missing.png"
        imageDownloader.downloadImage(imageURL: testUrl) { (image, error) in
            downloadedImage =   image
            self.expectation?.fulfill()
        }
        
        waitForExpectations(timeout: 10, handler: nil)
        XCTAssertNotNil(downloadedImage)
    }
}
