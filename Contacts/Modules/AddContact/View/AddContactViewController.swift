//
//  AddContactViewController.swift
//  Contacts
//
//  Created by Nitish.kumar on 28/03/20.
//  Copyright © 2020 Nitish.kumar. All rights reserved.
//

import UIKit

class AddContactViewController: BaseViewController {

    @IBOutlet weak private var scrollView: UIScrollView!
    @IBOutlet weak private var lastNameTextField: UITextField!
    @IBOutlet weak private var firstNameTextField: UITextField!
    @IBOutlet weak private var mobileTextField: UITextField!
    @IBOutlet weak private var emailTextField: UITextField!
    @IBOutlet weak private var profileImageView: UIImageView!
    
    @IBOutlet weak var topBackgroundView: UIView!
    weak var delegate : AddContactsCoordinatorProtocol?
    var tapperGesture : UITapGestureRecognizer!
    
    var viewModel : AddContactViewModelProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tapperGesture   =   UITapGestureRecognizer(target: self, action: #selector(handlerOnScreenTouch))
        self.view.addGestureRecognizer(tapperGesture)
        addObserver()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        self.topBackgroundView.setGradient(with: .white, endColor: Constants.Colors.appStandardColor)
    }
  
    override func configureUI() {
        navigationController?.navigationBar.tintColor   =   Constants.Colors.headerColor        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelButtonTapped))
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneButtonTapped))
        self.navigationItem.leftBarButtonItem?.accessibilityIdentifier  =   "AddContact_Cancel"
        self.navigationItem.rightBarButtonItem?.accessibilityIdentifier =   "AddContact_Done"
        
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
      
        viewModel.firstName     =   firstNameTextField.text ?? ""
        viewModel.lastName      =   lastNameTextField.text ?? ""
        viewModel.phone         =   mobileTextField.text ?? ""
        viewModel.emailId       =   emailTextField.text ?? ""
        viewModel.profileUrl    =   ""
        
        self.view.showLoader()
        viewModel.addContact()
        
        viewModel.didLoadingSuccess = {
            self.view.hideLoader()
            
            NotificationCenter.default.post(name: Notification.Name(rawValue: Constants.NotifificationName.NewContactAdded), object: nil)
            self.delegate?.navigateToPreviousPage()
        }
        
        viewModel.didLoadingFailed = { error in
            self.view.hideLoader()
            self.showAlert(error?.localizedDescription)
        }
    }
    
    @IBAction func uploadImageButtonTapped(_ sender: Any) {
        let imageController         =   UIImagePickerController()
        imageController.delegate    =   self
        ImagePicker(controller: self, pickerController: imageController).intializePicker()
    }
    

    deinit {
        print("AddContactViewController - deinit")
    }
}


extension AddContactViewController : UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    public func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true, completion: nil)
    }
    
    public func imagePickerController(_ picker: UIImagePickerController,
                                      didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        self.dismiss(animated: true, completion: {
            if let image = info[.editedImage] as? UIImage {
                self.profileImageView.image  =   image
            }
        })
    }
}

