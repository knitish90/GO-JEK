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
    func navigateToContactDetailPage(contact : ContactListCellViewModel)
    func navigateToAddContactPage()
}



class ContactListCoordinator : Coordinator {
    var childCoordinators: [Coordinator] = []
    unowned let navigationController:UINavigationController
    
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
        
    }
    
    func navigateToContactDetailPage(contact: ContactListCellViewModel) {
        let coordinator = ContactDetailCoordinator(navigationController: navigationController)
        coordinator.contact =   contact
        childCoordinators.append(coordinator)
        coordinator.childCoordinators   =   childCoordinators
        coordinator.start()
    }
}

