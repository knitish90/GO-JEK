//
//  CoordinatorTest.swift
//  ContactsTests
//
//  Created by Nitish.kumar on 30/03/20.
//  Copyright © 2020 Nitish.kumar. All rights reserved.
//

import XCTest
@testable import Contacts

class CoordinatorTest: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

  
    func testContactListCoordinator() {
        let coordinator = ContactListCoordinator(navigationController: UINavigationController())
        coordinator.start()
        
        XCTAssertNotNil(coordinator)
    }
    
    func testContactDetailCoordinator() {
        let coordinator = ContactDetailCoordinator(navigationController: UINavigationController())
        coordinator.start()
        
        XCTAssertNotNil(coordinator)
    }
    
    func testAddContactCoordinator() {
        let coordinator = AddContactsCoordinator(navigationController: UINavigationController())
        coordinator.start()
        
        XCTAssertNotNil(coordinator)
    }
    
    func testEditContactCoordinator() {
        let coordinator = EditContactsCoordinator(navigationController: UINavigationController())
        coordinator.start()
        
        XCTAssertNotNil(coordinator)
    }
}
