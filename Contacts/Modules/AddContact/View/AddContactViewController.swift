//
//  AddContactViewController.swift
//  Contacts
//
//  Created by Nitish.kumar on 28/03/20.
//  Copyright © 2020 Nitish.kumar. All rights reserved.
//

import UIKit

class AddContactViewController: BaseViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var mobileTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var profileImageView: UIImageView!
    
    weak var delegate : AddCoordinatorProtocol?
    var tapperGesture : UITapGestureRecognizer!
    
    var viewModel : AddContactViewModelProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tapperGesture   =   UITapGestureRecognizer(target: self, action: #selector(handlerOnScreenTouch))
        self.view.addGestureRecognizer(tapperGesture)
        configureUI()
        addObserver()
    }
    
  
    func configureUI() {
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelButtonTapped))
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneButtonTapped))
        
    }
    
    func addObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name:UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name:UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWillShow(notification:NSNotification){
        //give room at the bottom of the scroll view, so it doesn't cover up anything the user needs to tap
        let userInfo = notification.userInfo!
        var keyboardFrame:CGRect = (userInfo[UIResponder.keyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue
        keyboardFrame = self.view.convert(keyboardFrame, from: nil)

        var contentInset:UIEdgeInsets = self.scrollView.contentInset
        contentInset.bottom = keyboardFrame.size.height + 40
        scrollView.contentInset = contentInset
    }

    @objc func keyboardWillHide(notification:NSNotification){
        let contentInset:UIEdgeInsets = UIEdgeInsets.zero
        scrollView.contentInset = contentInset
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
            addContact()
        }
    }
    
    func addContact() {
        viewModel.addContact()
    }
    
    @IBAction func uploadImageButtonTapped(_ sender: Any) {
        ImagePicker(controller: self).intializePicker()
    }
    

    deinit {
        
    }
}


extension AddContactViewController : UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == mobileTextField {
        
            let currentCharacterCount = textField.text?.count ?? 0
            if (range.length + range.location > currentCharacterCount){
                return false
            }
            let newLength = currentCharacterCount + string.count - range.length
            
            return newLength <= 10
        }
        return true
    }
}
