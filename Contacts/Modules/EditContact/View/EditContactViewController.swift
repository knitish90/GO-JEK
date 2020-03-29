//
//  EditContactViewController.swift
//  Contacts
//
//  Created by Nitish.kumar on 29/03/20.
//  Copyright © 2020 Nitish.kumar. All rights reserved.
//

import UIKit

class EditContactViewController: AddContactViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func updateUI() {
        
    }
    
    override func doneButtonTapped() {
        print("done")
    }
    
    override func cancelButtonTapped() {
        
    }
    
    deinit {
        print("Editcontactviewcontroller - deinit")
    }

}
