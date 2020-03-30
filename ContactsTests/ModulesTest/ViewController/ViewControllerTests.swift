//
//  ViewControllerTests.swift
//  ContactsTests
//
//  Created by Nitish.kumar on 30/03/20.
//  Copyright © 2020 Nitish.kumar. All rights reserved.
//

import XCTest
@testable import Contacts

class ViewControllerTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testContactListViewControllerInstance_Success() {
        let controller = ContactListViewController.instance()
        
        XCTAssertNotNil(controller)
    }
    
    func testContactDetailControllerInstance_Success() {
        let controller = ContactDetailViewController.instance()
        
        XCTAssertNotNil(controller)
    }
    
    func testEditContactControllerInstance_Success() {
        let controller = EditContactViewController.instance()
        
        XCTAssertNotNil(controller)
    }
}
