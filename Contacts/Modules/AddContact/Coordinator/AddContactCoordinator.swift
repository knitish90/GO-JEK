//
//  AddContactCoordinator.swift
//  Contacts
//
//  Created by Nitish.kumar on 28/03/20.
//  Copyright © 2020 Nitish.kumar. All rights reserved.
//

import Foundation
import UIKit

protocol AddContactsCoordinatorProtocol: class {
    func navigateToPreviousPage()
    
}

class AddContactsCoordinator : Coordinator {
    var childCoordinators: [Coordinator] = []
    weak var navigationController:UINavigationController?
    
    weak var delegate : AddContactsCoordinatorProtocol?
    
    required init(navigationController: UINavigationController) {
        self.navigationController   =   navigationController
    }
    
    func start() {
        let controller = AddContactViewController.instance()
        let viewModel = AddContactViewModel(service: ContactService(httpClient: HTTPClient()))
        controller.viewModel    =   viewModel
        controller.delegate =   self
        self.navigationController?.present(UINavigationController(rootViewController: controller), animated: true, completion: nil)
    }
}

extension AddContactsCoordinator :  AddContactsCoordinatorProtocol {
    func navigateToPreviousPage() {
        self.navigationController?.dismiss(animated: true, completion: {
            self.childCoordinators.removeLast()
        })
    }
}
