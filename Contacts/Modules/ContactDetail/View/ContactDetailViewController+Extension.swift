//
//  ContactDetailViewController+Extension.swift
//  Contacts
//
//  Created by Nitish.kumar on 28/03/20.
//  Copyright © 2020 Nitish.kumar. All rights reserved.
//

import Foundation
import MessageUI


extension ContactDetailViewController {

    func message(with number : String) {
        let composeVC = MFMessageComposeViewController()
        composeVC.messageComposeDelegate = self
        
        composeVC.recipients = [number]
        composeVC.body = "Hey!, please call me"
        
        if MFMessageComposeViewController.canSendText() {
            self.present(composeVC, animated: true, completion: nil)
        } else {
            self.showAlert(Constants.ErrorMessage.messageSendingError)
        }
    }
    
    func email(with emailId : String) {
        let composeVC = MFMailComposeViewController()
        composeVC.mailComposeDelegate = self
        
        composeVC.setToRecipients(["gm@email.com"])
        composeVC.setSubject("something urgent!")
        composeVC.setMessageBody("Message content.", isHTML: false)
        
        if MFMailComposeViewController.canSendMail() {
            self.present(composeVC, animated: true, completion: nil)
        }else {
            self.showAlert(Constants.ErrorMessage.emailSendingError)
        }
        
    }
    
    func call(with phoneNumer : String) {
        if let url = URL(string: "tel://\(phoneNumer)"), UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url)
        }else {
            self.showAlert(Constants.ErrorMessage.phoneCallingError)
        }
    }
}


extension ContactDetailViewController : MFMessageComposeViewControllerDelegate {
    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
        
    }
}

extension ContactDetailViewController : MFMailComposeViewControllerDelegate  {
    
}
