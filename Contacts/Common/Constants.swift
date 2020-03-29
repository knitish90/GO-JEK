//
//  Constants.swift
//  Contacts
//
//  Created by Nitish.kumar on 28/03/20.
//  Copyright © 2020 Nitish.kumar. All rights reserved.
//

import Foundation
import UIKit

struct Constants {
    struct ErrorMessage {
        static let phoneCallingError    =   "Your device is not supported to make a call."
        static let messageSendingError  =   "Couln't send message, please try after some time."
        static let emailSendingError    =   "Couldn't send the mail, please try after some time."
    }
    struct ValidationError {
        static let invalidEmailError    =   "please enter valid email."
        static let invalidPhoneError    =   "please enter valid phone number."
        static let firstNameEmptyError  =   "please enter your first name."
        static let lastNameEmptyError   =   "please enter your last name."
    }
    struct Colors {
        static let appStandardColor     =   UIColor(red: 200.0/255.0, green: 227.0/255.0, blue: 220.0/255.0, alpha: 1.0)
    }
    
    struct NotifificationName {
        static var NewContactAdded  =   "newAccountsAdded"
        static var ContactEdited    =   "ContactEdited"
        
    }
}
