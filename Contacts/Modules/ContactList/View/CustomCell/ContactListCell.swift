//
//  ContactListCell.swift
//  Contacts
//
//  Created by Nitish.kumar on 27/03/20.
//  Copyright © 2020 Nitish.kumar. All rights reserved.
//

import UIKit

class ContactListCell: CustomBaseCell {
    
    @IBOutlet weak private var profileImageView: UIImageView!
    @IBOutlet weak private var nameLabel: UILabel!
    @IBOutlet weak private var favouriteButton: UIButton!
    
    typealias T = ContactListCellViewModelProtocol
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configure(cellViewModel: ContactListCellViewModelProtocol) {
        nameLabel.text  =   cellViewModel.fullName
        favouriteButton.isSelected  =   cellViewModel.isFavourite
        profileImageView.setImage(with: cellViewModel.profileUrl)
    }
    
}
