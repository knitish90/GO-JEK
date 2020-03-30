//
//  ViewController.swift
//  Contacts
//
//  Created by Nitish.kumar on 27/03/20.
//  Copyright © 2020 Nitish.kumar. All rights reserved.
//

import UIKit


class ContactListViewController: BaseViewController {

    @IBOutlet weak private var tableView: UITableView!
    var viewModel       :   ContactListViewModelProtocol!
    weak var delegate   :   ContactListCoordinatorDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        addObserver()
    }

    override func bindViewModel() {
        viewModel.viewDidLoad()
        self.view.showLoader()
        
        viewModel?.didContactsLoaded = {
            self.view.hideLoader()
            self.tableView.reloadData()
        }
        
        viewModel?.didContactsFailed = { (error) in
            self.view.hideLoader()
            self.showAlert(error?.localizedDescription)
        }
    }

    override func configureUI() {
        self.tableView.accessibilityIdentifier  =   "contactsListTableView"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addContactTapped))
        self.navigationItem.rightBarButtonItem?.accessibilityIdentifier =   "AddContactButton"
        setHeaderTitle()
    }
    
    private func setHeaderTitle() {
        self.title =   "Contacts"
    }
    
    @objc private func addContactTapped() {
        delegate?.navigateToAddContactPage()
    }
    
    private func addObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(didContactEdited), name: NSNotification.Name(Constants.NotifificationName.ContactEdited), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(newContactAdded), name: NSNotification.Name(Constants.NotifificationName.NewContactAdded), object: nil)
    }
    
    @objc private func didContactEdited() {
        bindViewModel()
    }
    
    @objc private func newContactAdded() {
        bindViewModel()
    }
}


extension ContactListViewController : UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.numberOfSections
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfItemIn(Section: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ContactListCell") as! ContactListCell
        cell.accessibilityLabel = "ContactListCell_\(indexPath.section)_\(indexPath.row)"
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
        self.tableView.deselectRow(at: indexPath, animated: true)
        let cellModel =  viewModel.cellViewModel(for: indexPath)
        delegate?.navigateToContactDetailPage(contact: cellModel)
    }
}
