//
//  ContactDetailTests.swift
//  ContactsTests
//
//  Created by Nitish.kumar on 29/03/20.
//  Copyright © 2020 Nitish.kumar. All rights reserved.
//

import XCTest
@testable import Contacts

class ContactDetailTests: XCTestCase {

    var expectation : XCTestExpectation!
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        expectation = self.expectation(description: "It should contacts details")
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

   
    func testLoadContactDetails_Success() {
        
        let contactService = MockedContactService(contactString: testContactsDetailJson)
        let viewModel = ContactDetailViewModel(contactId: 1, service: contactService)
        
        viewModel.getContactDetails()
        
        viewModel.didLoadingSuccess = {
            self.expectation.fulfill()
        }
        
        waitForExpectations(timeout: 10, handler: nil)
        XCTAssertEqual(viewModel.firstName, "Nitish")
        XCTAssertEqual(viewModel.lastName, "Kumar")
        XCTAssertEqual(viewModel.isFavourite, true)
    }
    
    func testLoadContactDetails_Failure() {
        
        let contactService = MockedContactService(contactString: nil)
        let viewModel = ContactDetailViewModel(contactId: 1, service: contactService)
        
        viewModel.getContactDetails()
        
        viewModel.didLoadingFailed = { error in
            self.expectation.fulfill()
        }
        waitForExpectations(timeout: 10, handler: nil)
        XCTAssertNotEqual(viewModel.firstName, "Nitish")
        XCTAssertNotEqual(viewModel.lastName, "Kumar")
        XCTAssertNotEqual(viewModel.isFavourite, true)
    }
}
