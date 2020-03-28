//
//  Constants.swift
//  Contacts
//
//  Created by Nitish.kumar on 28/03/20.
//  Copyright © 2020 Nitish.kumar. All rights reserved.
//

import Foundation

struct Constants {
    struct ErrorMessage {
        static let phoneCallingError    =   "Your device is not supported to make a call."
        static let messageSendingError  =   "Couln't send message, please try after some time."
        static let emailSendingError    =   "Couldn't send the mail, please try after some time."
    }
    struct ValidationError {
        static let invalidEmailError    =   "Entered email is not valid, please enter correctly."
        static let invalidPhoneError    =   "Entered Phone is not Correct, please enter correctly."
        static let firstNameEmptyError  =   "First Name can't be empty, please enter correct name."
        static let lastNameEmptyError   =   "Last Name can't be empty, please enter correct name."
        
    }
}
