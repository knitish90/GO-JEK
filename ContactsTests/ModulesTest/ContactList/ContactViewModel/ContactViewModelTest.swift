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

    //var expectation : XCTestExpectation!
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        //expectation = self.expectation(description: "It should fetch contacts")
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    
    func testLoadContacts() {
        let expectation = self.expectation(description: "It should fetch contacts")
        let contactService = MockedContactService(contactString: testContactsJson)
        let viewModel = ContactListViewModel(service: contactService)
        viewModel.fetchContacts()
        expectation.fulfill()
        waitForExpectations(timeout: 15, handler: nil)
        XCTAssert(viewModel.numberOfSections() == 0)
    }
    
    func testLoadContactsError() {
        let expectation = self.expectation(description: "It should fetch contacts")
        let contactService = MockedContactService(contactString: nil)
        let viewModel = ContactListViewModel(service: contactService)
        viewModel.fetchContacts()
        expectation.fulfill()
        waitForExpectations(timeout: 15, handler: nil)

        XCTAssert(viewModel.numberOfSections() == 0)
    }
    
    func testPrepareSections() {
        let expectation = self.expectation(description: "It should fetch contacts")
        let contactService = MockedContactService(contactString: testContactsJson)
        let viewModel = ContactListViewModel(service: contactService)
        viewModel.fetchContacts()
        expectation.fulfill()
        waitForExpectations(timeout: 15, handler: nil)

        XCTAssert(viewModel.numberOfSections() == 0)
    }
    
    func testContactViewModelProperties() {
        let expectation = self.expectation(description: "It should fetch contacts")
        let contactService = MockedContactService(contactString: testContactsJson)
        let viewModel = ContactListViewModel(service: contactService)
        
        viewModel.fetchContacts()
        expectation.fulfill()
        waitForExpectations(timeout: 15, handler: nil)
        
        XCTAssert(viewModel.numberOfSections() == 0)
    }
}
