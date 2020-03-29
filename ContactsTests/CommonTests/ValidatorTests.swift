//
//  ValidatorTests.swift
//  ContactsTests
//
//  Created by Nitish.kumar on 28/03/20.
//  Copyright © 2020 Nitish.kumar. All rights reserved.
//

import XCTest
@testable import Contacts
class ValidatorTests: XCTestCase {

    var validator : Validator!
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        validator   =   Validator()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

 
    func testValidEmail() {
        XCTAssertNil(validator.validate(text: "nitish@gmail.com", with: [.validEmail]))
    }

    func testInvalidEmail() {
        XCTAssertNotNil(validator.validate(text: "nitish@gmail", with: [.validEmail]))
        XCTAssertNotNil(validator.validate(text: "nitish.com", with: [.validEmail]))
        XCTAssertNotNil(validator.validate(text: "", with: [.validEmail]))
    }
    
    func testValidPhone() {
        XCTAssertNil(validator.validate(text: "7022259352", with: [.validPhone]))
    }
    
    func testInValidPhone() {
        XCTAssertNotNil(validator.validate(text: "702259352", with: [.validPhone]))
    }
}
