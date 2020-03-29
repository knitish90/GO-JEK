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

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    
    func testImagedownloadFailure() {
        let expectation = self.expectation(description: "testing download image Failur")
        var downloadedImage :   UIImage?
        let testUrl = "https://test.png"
        imageDownloader.downloadImage(imageUrl: testUrl) { (image, error) in
            downloadedImage =   image
            expectation.fulfill()
        }
        waitForExpectations(timeout: 15, handler: nil)
        XCTAssertNil(downloadedImage, "Image not downloaded")
    }
    
    func testImagedownloadSuccess() {
        let expectation = self.expectation(description: "testing download image success")
        var downloadedImage :   UIImage?
        let testUrl = "https://test.png"
        imageDownloader.downloadImage(imageUrl: testUrl) { (image, error) in
            downloadedImage =   image
            expectation.fulfill()
        }
        waitForExpectations(timeout: 15, handler: nil)
        XCTAssertNotNil(downloadedImage, "Image downloaded")
    }
}
