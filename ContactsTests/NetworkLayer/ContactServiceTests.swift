//
//  ContactServiceTests.swift
//  ContactsTests
//
//  Created by Nitish.kumar on 30/03/20.
//  Copyright © 2020 Nitish.kumar. All rights reserved.
//

import XCTest
@testable import Contacts

class ContactServiceTests: XCTestCase {

    var expectation : XCTestExpectation!
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        expectation = self.expectation(description: "It should load contacts")
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }


    func testContactList_Success() {
        let client = MockedHTTPClient(mockedData: testContactsJson, error: nil)
        let contactService = ContactService(httpClient: client)
        
        var contacts  = [Contact]()
        contactService.getContacts(completion: { (error, list) in
            contacts = list
            self.expectation.fulfill()
        })
        
        waitForExpectations(timeout: 10, handler: nil)
        XCTAssertTrue(contacts.count > 0)
    }
    
    func testLoadContacts_Failure() {
        let client = MockedHTTPClient(mockedData: nil, error: nil)
        let contactService = ContactService(httpClient: client)
        
        var contacts  = [Contact]()
        contactService.getContacts { (error, list) in
            contacts    =   list
            self.expectation.fulfill()
        }
        waitForExpectations(timeout: 10, handler: nil)
        XCTAssertTrue(contacts.count == 0)
    }
    
    func testloadContactDetail_Success() {
        let client = MockedHTTPClient(mockedData: testContactsDetailJson, error: nil)
        let contactService = ContactService(httpClient: client)
        
        var contact : Contact?
        
        contactService.contactDetails(contactId: 1) { (error, value) in
            contact =   value
            self.expectation.fulfill()
        }
        
        waitForExpectations(timeout: 10, handler: nil)
        XCTAssertTrue(contact != nil)
        XCTAssertTrue(contact?.firstName != nil)
        XCTAssertTrue(contact?.lastName != nil)
        
        XCTAssertEqual(contact!.firstName, "Nitish")
        XCTAssertEqual(contact!.lastName, "Kumar")
        XCTAssertEqual(contact!.favourite, true)
    }
    
    func testloadContactDetail_Failure() {
        let client = MockedHTTPClient(mockedData: nil, error: nil)
        let contactService = ContactService(httpClient: client)
        
        var contact : Contact?
        
        contactService.contactDetails(contactId: 1) { (error, value) in
            contact =   value
            self.expectation.fulfill()
        }
        
        waitForExpectations(timeout: 10, handler: nil)
        XCTAssertTrue(contact == nil)
        XCTAssertTrue(contact?.firstName == nil)
        XCTAssertTrue(contact?.lastName == nil)       
    }
}
