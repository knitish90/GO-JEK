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
    func numberOfItemIn(Section sectionIndex : Int)-> Int
    func numberOfSections() -> Int
    func titleForSection(Section SectionIndex : Int)->String
    func cellViewModel(for indexPath : IndexPath) -> ContactListCellViewModel
    var sectionIndexTitles : [String] {get}
}


class ContactListViewModel : ContactListViewModelProtocol {
    
    var didContactsFailed: ((Error?) -> Void)?
    var didContactsLoaded: (() -> Void)?
    
    var service : ContactServiceProtocol
    var tableDataSource = [ContactListCellViewModel]()
    var sections : [Section] = []
    
    var contacts = [Contact]() {
        didSet {
            self.prepareDataSource()
            sections = self.prepareSections()
            self.didContactsLoaded?()
           
        }
    }
    
    required init(service: ContactServiceProtocol) {
        self.service = service
    }
    
    func viewDidLoad() {
        fetchContacts()
    }
    
    var sectionIndexTitles : [String] {
        var indexTitles = [String]()
        for section in sections {
            indexTitles.append(section.title)
        }
        return indexTitles
    }
    
    func numberOfItemIn(Section sectionIndex : Int)-> Int {
        return self.sections[sectionIndex].contacts.count
    }
    
    func numberOfSections() -> Int {
        return self.sections.count
    }
    
    func titleForSection(Section SectionIndex : Int)->String {
        return self.sections[SectionIndex].title
    }
    
    func cellViewModel(for indexPath : IndexPath) -> ContactListCellViewModel {
        let contact = self.sections[indexPath.section].contacts[indexPath.row]
        let cellModel   =   ContactListCellViewModel(contact: contact)
        return cellModel
    }
}
