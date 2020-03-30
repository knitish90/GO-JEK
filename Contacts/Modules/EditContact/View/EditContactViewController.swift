//
//  EditContactViewController.swift
//  Contacts
//
//  Created by Nitish.kumar on 29/03/20.
//  Copyright © 2020 Nitish.kumar. All rights reserved.
//

import UIKit

class EditContactViewController: AddContactViewController {

    @IBOutlet weak private var firstNameField: UITextField!
    @IBOutlet weak private var profileImgView: UIImageView!
    @IBOutlet weak private var lastNameField: UITextField!
    @IBOutlet weak private var mobileNameField: UITextField!
    @IBOutlet weak private var emailField: UITextField!
    
    
    var editViewModel : EditContactVieModelProtocol!
    var contactDetailViewModel : ContactDetailViewModelProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        updateUI()
    }
    
    private func updateUI() {
        firstNameField.text     =   contactDetailViewModel.firstName
        lastNameField.text      =   contactDetailViewModel.lastName
        mobileNameField.text    =   contactDetailViewModel.phone
        emailField.text         =   contactDetailViewModel.emailId
        profileImgView.setImage(with: contactDetailViewModel.profileUrl)
    }
    
    override func doneButtonTapped() {
        
        let validator = Validator()
        if validator.validate(text: firstNameField.text, with: [.notEmpty]) != nil {
            self.showAlert(Constants.ValidationError.firstNameEmptyError)
        }else if validator.validate(text: lastNameField.text, with: [.notEmpty]) != nil {
            self.showAlert(Constants.ValidationError.lastNameEmptyError)
        }else if let message = validator.validate(text: mobileNameField.text, with: [.validPhone]) {
            self.showAlert(message)
        }else if let message = validator.validate(text: emailField.text, with: [.validEmail]) {
            self.showAlert(message)
        }else {
            addContact()
        }        
    }
    
    override func addContact() {
        editViewModel.id            =   contactDetailViewModel.id
        editViewModel.firstName     =   firstNameField.text ?? ""
        editViewModel.lastName      =   lastNameField.text ?? ""
        editViewModel.phone         =   mobileNameField.text ?? ""
        editViewModel.emailId       =   emailField.text ?? ""
        editViewModel.isFavourite   =   contactDetailViewModel.isFavourite
        editViewModel.profileUrl    =   ""
        
        self.view.showLoader()
        editViewModel.editContact()
        
        editViewModel.didLoadingSuccess = {
            self.view.hideLoader()
            
            NotificationCenter.default.post(name: Notification.Name(rawValue: Constants.NotifificationName.ContactEdited), object: nil)
            self.delegate?.navigateToPreviousPage()
        }
        
        editViewModel.didLoadingFailed = { error in
            self.view.hideLoader()
            self.showAlert(error?.localizedDescription)
        }
    }
    deinit {
        print("Editcontactviewcontroller - deinit")
    }

}
