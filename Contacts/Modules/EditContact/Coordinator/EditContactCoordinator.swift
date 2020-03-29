//
//  EditCoordinator.swift
//  Contacts
//
//  Created by Nitish.kumar on 28/03/20.
//  Copyright © 2020 Nitish.kumar. All rights reserved.
//

import Foundation
import UIKit


class EditContactsCoordinator : Coordinator {
    var childCoordinators: [Coordinator] = []
    weak var navigationController:UINavigationController?
    
    weak var delegate : AddContactsCoordinatorProtocol?
    var detailViewModel : ContactDetailViewModelProtocol!
    
    required init(navigationController: UINavigationController) {
        self.navigationController   =   navigationController
    }
    
    func start() {
        let controller = EditContactViewController.instance()
        let viewModel = EditContactViewModel(service: ContactService(httpClient: HTTPClient()))
        controller.contactDetailViewModel   =   detailViewModel
        controller.editViewModel    =   viewModel
        controller.delegate =   self
        self.navigationController?.present(UINavigationController(rootViewController: controller), animated: true, completion: nil)
    }
}

extension EditContactsCoordinator :  AddContactsCoordinatorProtocol {
    func navigateToPreviousPage() {
        self.navigationController?.dismiss(animated: true, completion: {
            self.childCoordinators.removeLast()
        })
    }
}
