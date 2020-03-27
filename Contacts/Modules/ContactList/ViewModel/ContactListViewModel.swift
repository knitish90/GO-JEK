//
//  ContactListViewModel.swift
//  Contacts
//
//  Created by Nitish.kumar on 27/03/20.
//  Copyright © 2020 Nitish.kumar. All rights reserved.
//

import Foundation


protocol ContactListViewModelProtocol {
    init(service : ContactServiceProtocol)
    func viewDidLoad()
    var didContactsLoaded : (()->Void)? { get set }
    var didContactsFailed : ((_ error: Error?)->Void)? { get set }
    
}


struct ContactListViewModel : ContactListViewModelProtocol {
    var didContactsFailed: ((Error?) -> Void)?
    var didContactsLoaded: (() -> Void)?
    
    var service : ContactServiceProtocol
    var tableDataSource = [ContactListCellViewModel]()
    
    
    init(service: ContactServiceProtocol) {
        self.service = service
    }
    
    func viewDidLoad() {
        fetchContacts()
    }
    
    func fetchContacts() {
        self.service.getContacts { (error, contactList) in
            if error == nil {
                self.didContactsLoaded?()
            }else {
                self.didContactsFailed?(error)
            }
        }
    }
    
    
}
