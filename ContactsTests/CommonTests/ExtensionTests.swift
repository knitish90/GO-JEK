//
//  ExtensionTests.swift
//  ContactsTests
//
//  Created by Nitish.kumar on 29/03/20.
//  Copyright © 2020 Nitish.kumar. All rights reserved.
//

import XCTest
@testable import Contacts

class ExtensionTests: XCTestCase {

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

   
    func testFirstCharTestFailed() {
        let name = "Nitish Kumar"
        
        let firstChar = name.firstChar
        
        XCTAssertNotNil(firstChar)
        XCTAssertNotEqual(firstChar, "n")
    }
    
    func testFirstCharTestSuccess() {
        let name = "Nitish Kumar"
        
        let firstChar = name.firstChar
        
        XCTAssertNotNil(firstChar)
        XCTAssertEqual(firstChar, "N")
    }

    func testReplaceStringSuccess() {
        let name = "Nitish Kumar"
        
        let str = name.replace(of: "Nitish", with: "Bipin")
        
        XCTAssertNotNil(str)
        XCTAssertEqual(str, "Bipin Kumar")
    }
    
    func testEncodeSuccess() {
        let contact = Contact()
        let data = contact.encode()
        
        XCTAssertNotNil(data)
    }
    
    func testDateFormatter() {
        let format = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        let formatter = format.dateFormatter()
        
        XCTAssertNotNil(formatter)
    }
    
    func testViewExtension() {
        let dummyView = UIView()
        
        dummyView.corner_Radius =   1.0
        dummyView.border_Width  =   1.0
        dummyView.border_Color  =   .white
        
        XCTAssertEqual(dummyView.corner_Radius, 1.0)
        XCTAssertEqual(dummyView.border_Width, 1.0)
        XCTAssertEqual(dummyView.border_Color, UIColor.white)
    }
}
