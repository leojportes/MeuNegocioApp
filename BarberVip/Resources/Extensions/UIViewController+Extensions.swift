//
//  UIViewController+Extensions.swift
//  BarberVip
//
//  Created by Renilson Moreira on 24/08/22.
//

import UIKit

extension UIViewController {
     func showAlert(title: String = "Funcionalidade não disponível!", messsage: String = "Estamos trabalhando nisso.") {
        let alert = UIAlertController(title: title, message: messsage, preferredStyle: .alert)
        let cancel = UIAlertAction(title: "Ok", style: .cancel)
        alert.addAction(cancel)
        self.present(alert, animated: true, completion: nil)
    }
    
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
