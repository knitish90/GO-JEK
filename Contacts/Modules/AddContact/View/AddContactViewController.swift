//
//  AddContactViewController.swift
//  Contacts
//
//  Created by Nitish.kumar on 28/03/20.
//  Copyright © 2020 Nitish.kumar. All rights reserved.
//

import UIKit

class AddContactViewController: BaseViewController {

    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var mobileTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var profileImageView: UIImageView!
    
    weak var delegate : AddCoordinatorProtocol?
    var tapperGesture : UITapGestureRecognizer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tapperGesture   =   UITapGestureRecognizer(target: self, action: #selector(handlerOnScreenTouch))
        self.view.addGestureRecognizer(tapperGesture)
        configureUI()
        bindViewModel()
    }
    
    func bindViewModel() {
        
    }
    
    func configureUI() {
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelButtonTapped))
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneButtonTapped))
        
    }
    
    func addObserver() {
        
    }
    
    @objc func handlerOnScreenTouch() {
        self.view.endEditing(true)
    }
    
    @objc func cancelButtonTapped() {
        delegate?.navigateToPreviousPage()
    }
    
    @objc func doneButtonTapped() {
        let validator = Validator()
        if validator.validate(text: firstNameTextField.text, with: [.notEmpty]) != nil {
            self.showAlert(Constants.ValidationError.firstNameEmptyError)
        }else if validator.validate(text: lastNameTextField.text, with: [.notEmpty]) != nil {
            self.showAlert(Constants.ValidationError.lastNameEmptyError)
        }else if let message = validator.validate(text: mobileTextField.text, with: [.validPhone]) {
            self.showAlert(message)
        }else if let message = validator.validate(text: emailTextField.text, with: [.validEmail]) {
            self.showAlert(message)
        }else {
            
        }
    }
    
    
    @IBAction func uploadImageButtonTapped(_ sender: Any) {
        ImagePicker(controller: self).intializePicker()
    }
    

    deinit {
        
    }
}
