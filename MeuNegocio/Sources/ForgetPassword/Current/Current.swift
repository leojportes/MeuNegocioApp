//
//  Current.swift
//  MeuNegocio
//
//  Created by Leonardo Portes on 04/09/22.
//

import Foundation
import FirebaseAuth
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

    public func formatterAmounts(amounts: [GetProcedureModel], reduce: Bool = false ) -> [String] {
        let proceduresAmounts: [Double] = amounts.map({ Double($0.valueLiquid ?? $0.value) ?? 00.00 })
        let values = proceduresAmounts.map({ $0.plata })
        let amounts = values.map { $0.rawValue.plata.string(currency: .br) }
        return amounts
    }
    
    public func formatterAmountsReport(amounts: String, reduce: Bool = false ) -> String {
        let proceduresAmounts: Double = Double(amounts) ?? 00.00
        let values = proceduresAmounts.plata
        let amounts = values.rawValue.plata.string(currency: .br)
        return amounts
    }
    
    var isEmailVerified: Bool {
        Auth.auth().currentUser?.isEmailVerified ?? false
    }

}
