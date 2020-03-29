//
//  EditContactViewController.swift
//  Contacts
//
//  Created by Nitish.kumar on 29/03/20.
//  Copyright © 2020 Nitish.kumar. All rights reserved.
//

import UIKit

class EditContactViewController: AddContactViewController {

    var editViewModel : EditContactVieModelProtocol!
    var contactDetailViewModel : ContactDetailViewModelProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        updateUI()
    }
    
    func updateUI() {
        firstNameTextField.text =   contactDetailViewModel.firstName
        lastNameTextField.text  =   contactDetailViewModel.lastName
        mobileTextField.text    =   contactDetailViewModel.phone
        emailTextField.text     =   contactDetailViewModel.emailId
        profileImageView.setImage(with: contactDetailViewModel.profileUrl)
    }
    
    override func doneButtonTapped() {
        
        editViewModel.id            =   contactDetailViewModel.id
        editViewModel.firstName     =   firstNameTextField.text ?? ""
        editViewModel.lastName      =   lastNameTextField.text ?? ""
        editViewModel.phone         =   mobileTextField.text ?? ""
        editViewModel.emailId       =   emailTextField.text ?? ""
        editViewModel.profileUrl    =   ""
        
        self.view.showLoader()
        editViewModel.editContact()
        
        editViewModel.didLoadingSuccess = {
            self.view.hideLoader()
            
            NotificationCenter.default.post(name: Notification.Name(rawValue: Constants.NotifificationName.NewContactAdded), object: nil)
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
