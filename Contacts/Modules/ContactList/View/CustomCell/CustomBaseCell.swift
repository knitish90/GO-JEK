//
//  CellHelper.swift
//  Contacts
//
//  Created by Nitish.kumar on 27/03/20.
//  Copyright © 2020 Nitish.kumar. All rights reserved.
//

import Foundation
import UIKit


protocol CellBaseProtocol {
    associatedtype T
    func configure(cellViewModel : T)
}

typealias CustomBaseCell = UITableViewCell & CellBaseProtocol
