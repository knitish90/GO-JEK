//
//  ViewController.swift
//  Contacts
//
//  Created by Nitish.kumar on 27/03/20.
//  Copyright © 2020 Nitish.kumar. All rights reserved.
//

import UIKit

class ContactListViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var viewModel : ContactListViewModelProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        viewModel = ContactListViewModel(service: ContactService(httpClient: HTTPClient()))
        bindViewModel()
    }

    func bindViewModel() {
        viewModel?.viewDidLoad()
        
        viewModel?.didContactsLoaded = {
            self.tableView.reloadData()
        }
        
        viewModel?.didContactsFailed = { (error) in
            print(error?.localizedDescription ?? "")
        }
    }

}


extension ContactListViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}

extension ContactListViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}
