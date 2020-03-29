//
//  ContactDetailCoordinator.swift
//  Contacts
//
//  Created by Nitish.kumar on 28/03/20.
//  Copyright © 2020 Nitish.kumar. All rights reserved.
//

import Foundation
import UIKit

protocol ContactDetailCoordinatorDelegate : class{
    func moveToContactEdit()
}


class ContactDetailCoordinator : Coordinator {
    var childCoordinators: [Coordinator] = []
    weak var navigationController : UINavigationController?
    var contact : ContactDataBaseProtocol!
    
    required init(navigationController: UINavigationController) {
        self.navigationController   =   navigationController
    }
    
    func start() {
        let controller = ContactDetailViewController.instance()
        let viewModel = ContactDetailViewModel(contactId: contact.id, service: ContactService(httpClient: HTTPClient()))
        controller.viewModel    =   viewModel
        controller.delegate     =   self
        self.navigationController?.pushViewController(controller, animated: true)
    }    
}

extension ContactDetailCoordinator : ContactDetailCoordinatorDelegate {
    func moveToContactEdit() {
        let coordinator = EditContactsCoordinator(navigationController: navigationController!)
        coordinator.childCoordinators.append(coordinator)
        coordinator.start()
    }    
}
