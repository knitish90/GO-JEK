//
//  ContactListViewModel.swift
//  Contacts
//
//  Created by Nitish.kumar on 27/03/20.
//  Copyright © 2020 Nitish.kumar. All rights reserved.
//

import Foundation


protocol ContactListViewModelProtocol {
    var numberOfSections : Int { get }
    var sectionIndexTitles : [String] {get}
    var didContactsFailed : ((_ error: Errors?)->Void)? { get set }
    var didContactsLoaded : (()->Void)? { get set }
    func numberOfItemIn(Section sectionIndex : Int)-> Int
    func titleForSection(Section SectionIndex : Int)->String
    func cellViewModel(for indexPath : IndexPath) -> ContactListCellViewModelProtocol
    func viewDidLoad()
}

class ContactListViewModel : ContactListViewModelProtocol {
    
    var didContactsFailed: ((Errors?) -> Void)?
    var didContactsLoaded: (() -> Void)?
    var service : ContactServiceProtocol
    var tableDataSource = [ContactListCellViewModel]()
    var sections : [Section] = []
    var contacts = [Contact]()
    
    var numberOfSections : Int {
        self.sections.count
    }
    
    init(service: ContactServiceProtocol) {
        self.service = service
    }
    
    func viewDidLoad() {
        fetchContacts()
    }
    
    var sectionIndexTitles : [String] {
        return sections.map{$0.title}
    }
    
    func numberOfItemIn(Section sectionIndex : Int)-> Int {
        self.sections[sectionIndex].contacts.count
    }
    
    func titleForSection(Section SectionIndex : Int)->String {
        self.sections[SectionIndex].title
    }
    
    func prepareDataSource() {
        self.tableDataSource    =   contacts.map{ContactListCellViewModel(contact: $0)}
    }
    
    func cellViewModel(for indexPath : IndexPath) -> ContactListCellViewModelProtocol {
        let contact = self.sections[indexPath.section].contacts[indexPath.row]
        let cellModel   =   ContactListCellViewModel(contact: contact)
        return cellModel
    }
}


extension ContactListViewModel {
    func fetchContacts() {
        service.getContacts { (error, contactList) in
            DispatchQueue.main.async {
                if error == nil {
                    self.contacts   =   contactList
                    self.prepareDataSource()
                    self.sections = self.prepareSections()
                    
                    self.didContactsLoaded?()
                }else {
                    self.didContactsFailed?(error)
                }
            }
        }
    }
    
    func prepareSections()-> [Section] {
        var sections     =   [Section]()
        var tempSection  :   Section! = nil
        var prevContact  :   Contact?
    
        let sortedContacts  =  self.contacts.sorted(by: {$0.fullName.firstChar < $1.fullName.firstChar})
        
        for contact in sortedContacts {
            if contact.fullName.firstChar != prevContact?.fullName.firstChar {
                let sectionTitle = contact.fullName.firstChar
                tempSection  =  Section(title: sectionTitle, contacts: [])
                tempSection.contacts.append(contact)
                sections.append(tempSection)
            }else {
                tempSection.contacts.append(contact)
            }
            prevContact =   contact
        }
    
        return sections
    }
}
