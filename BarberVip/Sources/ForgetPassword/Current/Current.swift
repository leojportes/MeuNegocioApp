//
//  Current.swift
//  BarberVip
//
//  Created by Leonardo Portes on 04/09/22.
//

import Foundation
import MessageUI
import SafariServices

public class Current: NSObject, MFMailComposeViewControllerDelegate {

    static let shared = Current()

    // MARK: - Init
    override init() { /* empty init */ }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Public methods
    
    // - Paramiters
    // - sendTo: [String]
    //   Default value = ["mybarbersuport@gmail.com"]
    // - subject: String
    //   Default value = "Tenho uma dúvida"
    // - body: String
    //   Default value = ""
    // - isHTML: Bool
    //   Default value = false
    /// Method that presents the composition of email.
    public func openMailCompose(
        sendTo: [String] = ["mybarbersuport@gmail.com"],
        subject: String = "Tenho uma dúvida",
        body: String = "",
        isHTML: Bool = false
    ) -> MFMailComposeViewController {
        lazy var mailComposeController = MFMailComposeViewController() .. {
            $0.mailComposeDelegate = self
            $0.setToRecipients(["mybarbersuport@gmail.com"])
            $0.setSubject("")
            $0.setMessageBody("", isHTML: false)
        }
        mailComposeController.modalPresentationStyle = .pageSheet
        return mailComposeController
    }

    public func openWhatsapp(title: String, messsage: String) {
        let currentController = UIViewController.findCurrentController()
        let alert = UIAlertController(title: title, message: messsage, preferredStyle: .alert)
        let cancel = UIAlertAction(title: "Cancelar", style: .cancel)
        let goWpp = UIAlertAction(title: "Ir", style: .default) { _ in
            let phoneNumber =  "48998308191"
            let appURL = URL(string: "https://api.whatsapp.com/send?phone=\(phoneNumber)")!
            if UIApplication.shared.canOpenURL(appURL) {
                if #available(iOS 10.0, *) {
                    UIApplication.shared.open(appURL, options: [:], completionHandler: nil)
                }
                else {
                    UIApplication.shared.openURL(appURL)
                }
            }
        }
        alert.addAction(goWpp)
        alert.addAction(cancel)
        currentController?.present(alert, animated: true, completion: nil)
    }

}
