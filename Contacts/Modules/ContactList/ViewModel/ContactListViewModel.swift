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
    func cellViewModel(for indexPath : IndexPath) -> ContactListCellViewModel
    func viewDidLoad()
}


class ContactListViewModel : ContactListViewModelProtocol {
    
    var didContactsFailed: ((Errors?) -> Void)?
    var didContactsLoaded: (() -> Void)?
    
    var service : ContactServiceProtocol
    var tableDataSource = [ContactListCellViewModel]()
    var sections : [Section] = []
    
    var contacts = [Contact]() {
        didSet {
            self.prepareDataSource()
            sections = self.prepareSections()
        }
    }
    
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
        var indexTitles = [String]()
        for section in sections {
            indexTitles.append(section.title)
        }
        return indexTitles
    }
    
    func numberOfItemIn(Section sectionIndex : Int)-> Int {
        self.sections[sectionIndex].contacts.count
    }
    
   
    func titleForSection(Section SectionIndex : Int)->String {
        self.sections[SectionIndex].title
    }
    
    func cellViewModel(for indexPath : IndexPath) -> ContactListCellViewModel {
        let contact = self.sections[indexPath.section].contacts[indexPath.row]
        let cellModel   =   ContactListCellViewModel(contact: contact)
        return cellModel
    }
}
