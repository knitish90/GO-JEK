//
//  ErrorsTests.swift
//  ContactsTests
//
//  Created by Nitish.kumar on 29/03/20.
//  Copyright © 2020 Nitish.kumar. All rights reserved.
//

import XCTest

@testable import Contacts

class ErrorsTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testErrors() {
        let message = Errors(message: Constants.NetworkError.inValidURLError)
        
        XCTAssertNotNil(message)
    }
    
}
