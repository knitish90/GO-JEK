//
//  ContactDetailViewController.swift
//  Contacts
//
//  Created by Nitish.kumar on 28/03/20.
//  Copyright © 2020 Nitish.kumar. All rights reserved.
//

import UIKit

class ContactDetailViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        bindViewModel()
        
    }
    
    func bindViewModel() {
        
    }

    func configureUI() {
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(editContactButtonTapped))
    }
    
    @objc func editContactButtonTapped() {
        
    }
    
    @IBAction func messageButtonTapped(_ sender: Any) {
    }
    
    @IBAction func callButtonTapped(_ sender: Any) {
    }
    
    @IBAction func emailButtonTapped(_ sender: Any) {
    }
    
    @IBAction func favouriteButtonTapped(_ sender: Any) {
        
    }
    
    
    
    
    
    
    
    
    
}
