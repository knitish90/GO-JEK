//
//  ContactDetailViewController.swift
//  Contacts
//
//  Created by Nitish.kumar on 28/03/20.
//  Copyright © 2020 Nitish.kumar. All rights reserved.
//

import UIKit

class ContactDetailViewController: BaseViewController {

    var viewModel : ContactDetailViewModelProtocol!
    
    @IBOutlet weak var topBackgroudView: UIView!
    @IBOutlet weak var mobileLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var favouriteButton: UIButton!
    @IBOutlet weak var nameLabel: UILabel!
    
    var navigationImage : UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        navigationImage = self.navigationController?.navigationBar.shadowImage
        self.navigationController?.navigationBar.shadowImage = UIImage()
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        self.navigationController?.navigationBar.shadowImage = navigationImage
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
         topBackgroudView.setGradient(with: .white, endColor: Constants.Colors.appStandardColor)
    }
    
    override func bindViewModel() {
        viewModel.viewDidLoad()
        self.view.showLoader()
        viewModel.didLoadingSuccess = {
            self.view.hideLoader()
            self.updateUI()
        }
        
        viewModel.didLoadingFailed = { error in
            self.view.hideLoader()
            self.showAlert(error?.localizedDescription)
        }
    }

    override func configureUI() {
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(editContactButtonTapped))
    }
    
    func updateUI() {
        nameLabel.text      =   viewModel.fullName
        mobileLabel.text    =   viewModel.phone
        emailLabel.text     =   viewModel.emailId
        favouriteButton.isSelected  =   viewModel.isFavourite
        profileImageView.setImage(with: viewModel.profileUrl)
    }
    
    @objc func editContactButtonTapped() {
        
    }
    
    @IBAction func messageButtonTapped(_ sender: Any) {
        message(with: viewModel.phone)
    }
    
    @IBAction func callButtonTapped(_ sender: Any) {
        call(with: viewModel.phone)
    }
    
    @IBAction func emailButtonTapped(_ sender: Any) {
        email(with: viewModel.emailId)
    }
    
    @IBAction func favouriteButtonTapped(_ sender: Any) {
        viewModel.isFavourite   =   !viewModel.isFavourite
        viewModel.makeFavourite()
        
        self.view.showLoader()
        viewModel.didLoadingSuccess = {
            self.view.hideLoader()
            self.updateUI()
        }
        
        viewModel.didLoadingFailed = { error in
            self.view.hideLoader()
            self.showAlert(error?.localizedDescription)
        }
    }
}
