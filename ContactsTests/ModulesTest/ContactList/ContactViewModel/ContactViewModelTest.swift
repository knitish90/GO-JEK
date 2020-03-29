//
//  ContactViewModelTest.swift
//  ContactsTests
//
//  Created by Nitish.kumar on 29/03/20.
//  Copyright © 2020 Nitish.kumar. All rights reserved.
//

import XCTest
@testable import Contacts

class ContactViewModelTest: XCTestCase {

    var expectation : XCTestExpectation!
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        self.expectation = self.expectation(description: "It should fetch contacts fdfsdfsd")
        self.expectation.expectedFulfillmentCount = 2
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    
    func testLoadContacts_Success() {
        
        let contactService = MockedContactService(contactString: testContactsJson)
        let viewModel = ContactListViewModel(service: contactService)
        viewModel.fetchContacts()
        
        viewModel.didContactsLoaded = {
            self.expectation.fulfill()
        }
        
        waitForExpectations(timeout: 10, handler: nil)
        XCTAssert(viewModel.numberOfSections() > 0)
    }
    
    func testLoadContacts_Failure() {
        let contactService = MockedContactService(contactString: nil)
        let viewModel = ContactListViewModel(service: contactService)
        viewModel.fetchContacts()
        
        viewModel.didContactsFailed = { error in
            self.expectation.fulfill()
        }
        
        waitForExpectations(timeout: 10, handler: nil)
        XCTAssert(viewModel.numberOfSections() == 0)
    }
    
    func testPrepareSections_Success() {
        let contactService = MockedContactService(contactString: testContactsJson)
        let viewModel = ContactListViewModel(service: contactService)
        viewModel.fetchContacts()
        
        viewModel.didContactsLoaded = {
            self.expectation.fulfill()
        }
        
        waitForExpectations(timeout: 10, handler: nil)
        XCTAssert(viewModel.numberOfSections() > 0)
    }
    
    func testContactViewModelProperties() {
        let contactService = MockedContactService(contactString: testContactsJson)
        let viewModel = ContactListViewModel(service: contactService)
        
        viewModel.fetchContacts()
        expectation.fulfill()
        waitForExpectations(timeout: 15, handler: nil)
        
        XCTAssert(viewModel.numberOfSections() == 0)
    }
}
