//
//  EditContactViewModelTest.swift
//  ContactsTests
//
//  Created by Nitish.kumar on 29/03/20.
//  Copyright © 2020 Nitish.kumar. All rights reserved.
//

import XCTest
@testable import Contacts

class EditContactViewModelTest: XCTestCase {

    var expectation : XCTestExpectation?
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        self.expectation = self.expectation(description: "It should edit contacts")
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

 
    func testUpdateContact_Success() {
        let service     =   MockedContactService(contactString: nil)
        let viewModel   =   EditContactViewModel(service: service)
        
        viewModel.firstName     =   "Nitish"
        viewModel.lastName      =   "Kumar"
        viewModel.isFavourite   =   true
        
        viewModel.editContact()
        self.expectation?.fulfill()
        waitForExpectations(timeout: 15, handler: nil)
        
    
        XCTAssertEqual(viewModel.firstName, "Nitish")
        XCTAssertEqual(viewModel.lastName, "Kumar")
        XCTAssertEqual(viewModel.isFavourite, true)
    }
    
    func testUpdateContact_Error() {
        let service     =   MockedContactService(contactString: nil)
        let viewModel   =   EditContactViewModel(service: service)
        
        viewModel.firstName     =   "Nitish"
        viewModel.lastName      =   "Kumar"
        viewModel.isFavourite   =   true
        
        viewModel.editContact()
        self.expectation?.fulfill()
        waitForExpectations(timeout: 15, handler: nil)
        
    
        XCTAssertNotEqual(viewModel.firstName, "Bipin")
        XCTAssertNotEqual(viewModel.lastName, "Sinha")
        XCTAssertNotEqual(viewModel.isFavourite, false)
    }
}
