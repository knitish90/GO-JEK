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
    
    @IBOutlet weak private var topBackgroudView: UIView!
    @IBOutlet weak private var mobileLabel: UILabel!
    @IBOutlet weak private var emailLabel: UILabel!
    @IBOutlet weak private var profileImageView: UIImageView!
    @IBOutlet weak private var favouriteButton: UIButton!
    @IBOutlet weak private var nameLabel: UILabel!
    
    weak var delegate : ContactDetailCoordinatorDelegate?
    private var navigationImage : UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addObserver()
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
        self.navigationItem.rightBarButtonItem?.accessibilityIdentifier = "contactDetailEditButton"
    }
    
    private func updateUI() {
        nameLabel.text      =   viewModel.fullName
        mobileLabel.text    =   viewModel.phone
        emailLabel.text     =   viewModel.emailId
        favouriteButton.isSelected  =   viewModel.isFavourite
        profileImageView.setImage(with: viewModel.profileUrl)
    }
    
    private func addObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(didContactEdited), name: NSNotification.Name(Constants.NotifificationName.ContactEdited), object: nil)
    }
    
    @objc func didContactEdited() {
        bindViewModel()
    }
    
    @objc private func editContactButtonTapped() {
        delegate?.moveToContactEdit(detailViewModel: viewModel)
    }
    
    @IBAction private func messageButtonTapped(_ sender: Any) {
        message(with: viewModel.phone)
    }
    
    @IBAction private func callButtonTapped(_ sender: Any) {
        call(with: viewModel.phone)
    }
    
    @IBAction private func emailButtonTapped(_ sender: Any) {
        email(with: viewModel.emailId)
    }
    
    @IBAction private func favouriteButtonTapped(_ sender: Any) {
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
