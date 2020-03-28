//
//  ContactListViewModel+Extension.swift
//  Contacts
//
//  Created by Nitish.kumar on 27/03/20.
//  Copyright © 2020 Nitish.kumar. All rights reserved.
//

import Foundation

extension ContactListViewModel {
    func prepareDataSource() {
        for contact in contacts {
            self.tableDataSource.append(ContactListCellViewModel(contact: contact))
        }
    }
    
    func prepareSections()-> [Section] {
        var allSections     =   [Section]()
        let favSection      =   Section(title: "♡", contacts: [] )
        var nonFavSections  =   [Section]()
        var tempSection     :   Section! = nil
        var prevContact     :   Contact?
        
        for contact in contacts {
            if contact.favourite {
                favSection.contacts.append(contact)
            }else if contact.fullName.firstChar != prevContact?.fullName.firstChar {
                let sectionTitle = contact.fullName.firstChar
                tempSection  =  Section(title: sectionTitle, contacts: [])
                tempSection.contacts.append(contact)
                nonFavSections.append(tempSection)
            }else {
                tempSection.contacts.append(contact)
            }
            
            prevContact =   contact
        }
        
        allSections.append(favSection)
        allSections.append(contentsOf: nonFavSections)
        
        return allSections
    }
    
    
    func fetchContacts() {
        service.getContacts { (error, contactList) in
            DispatchQueue.main.async {
                if error == nil {
                    self.contacts   =   contactList
                    self.didContactsLoaded?()
                }else {
                    self.didContactsFailed?(error)
                }
            }
        }
    }
}
