//
//  ContactListCell.swift
//  Contacts
//
//  Created by Nitish.kumar on 27/03/20.
//  Copyright © 2020 Nitish.kumar. All rights reserved.
//

import UIKit

class ContactListCell: CustomBaseCell {
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var favouriteButton: UIButton!
    
    typealias T = ContactListCellViewModel
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configure(cellViewModel: ContactListCellViewModel) {
        nameLabel.text  =   cellViewModel.fullName
        favouriteButton.isSelected  =   cellViewModel.isFavourite
        profileImageView.setImage(with: cellViewModel.profileUrl)
    }
    
}
