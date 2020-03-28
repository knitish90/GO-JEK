//
//  Validator.swift
//  Contacts
//
//  Created by Nitish.kumar on 28/03/20.
//  Copyright © 2020 Nitish.kumar. All rights reserved.
//

import Foundation

class Validator {
    func validate(text: String?, with rules: [Rule]) -> String? {
        rules.compactMap({ $0.check(text ?? "") }).first
    }
}

struct Rule {
    // Return nil if Rules matches, else returns error message
    let check: (String) -> String?

    static let notEmpty = Rule(check: {
        $0.isEmpty ? "Must not be empty" : nil
    })

    static let validEmail = Rule(check: {
        let regex = #"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,64}"#

        let predicate = NSPredicate(format: "SELF MATCHES %@", regex)
        return predicate.evaluate(with: $0) ? nil : Constants.ValidationError.invalidEmailError
    })

    static let validPhone = Rule(check: {
        let regex = "^\\d{10}$"

        let predicate = NSPredicate(format: "SELF MATCHES %@", regex)
        return predicate.evaluate(with: $0) ? nil : Constants.ValidationError.invalidPhoneError
    })
}
