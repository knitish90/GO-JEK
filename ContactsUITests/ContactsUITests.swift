//
//  ContactsUITests.swift
//  ContactsUITests
//
//  Created by Nitish.kumar on 27/03/20.
//  Copyright © 2020 Nitish.kumar. All rights reserved.
//

import XCTest

class ContactsUITests: XCTestCase {

    var app : XCUIApplication!
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
        
        app = XCUIApplication()
        app.launch()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        
        app = nil
    }

    func testLaunchPerformance() {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTOSSignpostMetric.applicationLaunch]) {
                XCUIApplication().launch()
            }
        }
    }
    
    func testContactListCell() {
        let tableView = app.tables["contactsListTableView"]
        XCTAssert(tableView.exists)
        
        let cell = tableView.cells["ContactListCell_0_0"]
        XCTAssertFalse(cell.exists)
    }
    
    func testContactListCell_SubViews() {
        let cell = app.tables["contactsListTableView"].cells["ContactListCell_0_1"]
        XCTAssertFalse(cell.exists)
        
        let nameLabel = cell.staticTexts["ContactListCell_NameLabel"]
        XCTAssertFalse(nameLabel.exists)
        
        let favButton = cell.buttons["ContactListCell_FavButton"]
        XCTAssertFalse(favButton.exists)
        
        let profileImage = cell.images["ContactListCell_profileImage"]
        XCTAssertFalse(profileImage.exists)
    }
    
    func testContactDetail_subViews() {
        app.tables["contactsListTableView"].cells["ContactListCell_0_0"].tap()
                
        let elements = app.scrollViews.otherElements
        XCTAssertTrue(elements.buttons["ContactDetail_ChatButton"].exists)
        XCTAssertTrue(elements.buttons["ContactDetail_CallButton"].exists)
        XCTAssertTrue(elements.buttons["ContactDetail_EmailButton"].exists)
        XCTAssertTrue(elements.buttons["ContactDetail_FavButton"].exists)
        XCTAssertTrue(elements.images["ContactDetail_ProfileImage"].exists)
        
        let favButton = elements.buttons["ContactDetail_FavButton"]
        favButton.tap()
        
        let editContactButton = XCUIApplication().navigationBars.buttons["contactDetailEditButton"]
        XCTAssert(editContactButton.exists)
        
    }
    
    func testAddContact() {
        app.buttons["AddContactButton"].tap()
        
        let firstNameTextField = app.textFields["AddContact_FirstName"]
        firstNameTextField.tap()
        firstNameTextField.typeText("Bipin")
        
        let lastNameTextField = app.textFields["AddContact_LastName"]
        lastNameTextField.tap()
        lastNameTextField.typeText("kumar")
        
        let mobileTextField = app.textFields["AddContact_Mobile"]
        mobileTextField.tap()
        mobileTextField.typeText("4794597855")
        
        let emailTextField = app.textFields["AddContact_Email"]
        emailTextField.tap()
        emailTextField.typeText("nk@gmail.com")
        
        
        let addContactButton = XCUIApplication().navigationBars.buttons["AddContact_Done"]
        addContactButton.tap()
        
    }
    
    
    func testEditContact() {
        app.tables["contactsListTableView"].cells["ContactListCell_0_0"].tap()
        
        let editContactButton = XCUIApplication().navigationBars.buttons["contactDetailEditButton"]
        XCTAssert(editContactButton.exists)
        
        editContactButton.tap()
        
        
        let firstNameTextField = app.textFields["EditContact_FirstName"]
        XCTAssertTrue(firstNameTextField.exists)
        firstNameTextField.tap()
        firstNameTextField.clearAndTypeText(text: "Bipin")
        
        let lastNameTextField = app.textFields["EditContact_LastName"]
        XCTAssertTrue(lastNameTextField.exists)
        lastNameTextField.tap()
        lastNameTextField.clearAndTypeText(text: "kumar")
        
        let mobileTextField = app.textFields["EditContact_Mobile"]
        XCTAssertTrue(mobileTextField.exists)
        mobileTextField.tap()
        mobileTextField.clearAndTypeText(text: "4794597855")
        
        let emailTextField = app.textFields["EditContact_Email"]
        XCTAssertTrue(emailTextField.exists)
        emailTextField.tap()
        emailTextField.clearAndTypeText(text: "nks@gmail.com")
        
        
        let addContactButton = XCUIApplication().navigationBars.buttons["AddContact_Done"]
        XCTAssert(addContactButton.exists)
        addContactButton.tap()
    }
}


extension XCUIElement {
    /**
     Removes any current text in the field before typing in the new value
     - Parameter text: the text to enter into the field
     */
    func clearAndTypeText(text: String) {
        guard let stringValue = self.value as? String else {
            XCTFail("Tried to clear and enter text into a non string value")
            return
        }

        self.tap()

        let deleteString = String(repeating: XCUIKeyboardKey.delete.rawValue, count: stringValue.count)

        self.typeText(deleteString)
        self.typeText(text)
    }
}
