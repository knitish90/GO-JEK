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
    var viewModel : ContactListViewModelProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        viewModel = ContactListViewModel(service: ContactService(httpClient: HTTPClient()))
        bindViewModel()
    }

    func bindViewModel() {
        viewModel.viewDidLoad()
        
        viewModel?.didContactsLoaded = {
            self.tableView.reloadData()
        }
        
        viewModel?.didContactsFailed = { (error) in
            print(error?.localizedDescription ?? "")
        }
    }

}


extension ContactListViewController : UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.numberOfSections()
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfItemIn(Section: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ContactListCell") as! ContactListCell
        cell.accessibilityIdentifier = "ContactListCell_\(indexPath.section)_\(indexPath.row)"
        cell.configure(cellViewModel: viewModel.cellViewModel(for: indexPath))
           
        return cell
    }
    
    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return viewModel.sectionIndexTitles
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return viewModel.titleForSection(Section: section)
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 28.0
    }
}

extension ContactListViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}
