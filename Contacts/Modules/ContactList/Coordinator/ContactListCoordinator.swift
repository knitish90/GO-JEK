//
//  ContactListCoordinator.swift
//  Contacts
//
//  Created by Nitish.kumar on 27/03/20.
//  Copyright © 2020 Nitish.kumar. All rights reserved.
//

import Foundation
import UIKit


protocol Coordinator : class {
    var childCoordinators : [Coordinator] { get set }
    init(navigationController : UINavigationController)
    func start()
}

protocol ContactListCoordinatorDelegate: class {
    func navigateToContactDetailPage(contact : ContactListCellViewModelProtocol)
    func navigateToAddContactPage()
}



class ContactListCoordinator : Coordinator {
    var childCoordinators: [Coordinator] = []
    let navigationController:UINavigationController
    
    required init(navigationController: UINavigationController) {
        self.navigationController   =   navigationController
    }
    
    func start() {
        let controller = ContactListViewController.instance()
        controller.delegate =   self
        controller.viewModel    =  ContactListViewModel(service: ContactService(httpClient: HTTPClient()))
        self.navigationController.viewControllers   =   [controller]
    }
}



extension ContactListCoordinator : ContactListCoordinatorDelegate {
    func navigateToAddContactPage() {
        let coordinator = AddContactsCoordinator(navigationController: navigationController)
        coordinator.childCoordinators.append(coordinator)
        coordinator.start()
    }
    
    func navigateToContactDetailPage(contact: ContactListCellViewModelProtocol) {
        let coordinator = ContactDetailCoordinator(navigationController: navigationController)
        coordinator.contact =   contact
        childCoordinators.append(coordinator)
        coordinator.childCoordinators   =   childCoordinators
        coordinator.start()
    }
}

