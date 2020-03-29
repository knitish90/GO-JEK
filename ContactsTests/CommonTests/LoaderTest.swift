//
//  LoaderTest.swift
//  ContactsTests
//
//  Created by Nitish.kumar on 29/03/20.
//  Copyright © 2020 Nitish.kumar. All rights reserved.
//

import XCTest
@testable import Contacts

class LoaderTest: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }


    func testShowLoader() {
        let controller = UIViewController()
        controller.view.showLoader()
        let loaderView = controller.view.viewWithTag(kLoaderTagValue)
        
        XCTAssertNotNil(loaderView)
        XCTAssertNotNil(loaderView?.superview)
        XCTAssertEqual(controller.view, loaderView?.superview)
        controller.view.hideLoader()
        XCTAssertNil(loaderView?.superview)
        
    }
    
    func testHideLoader() {
        let controller = UIViewController()
        controller.view.showLoader()
        let loaderView = controller.view.viewWithTag(kLoaderTagValue)
        XCTAssertNotNil(loaderView)
        controller.view.hideLoader()
        let testLoaderView = controller.view.viewWithTag(kLoaderTagValue)
        XCTAssertNil(testLoaderView)
    }
    
}
