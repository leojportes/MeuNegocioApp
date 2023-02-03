//
//  UITextField+Extensions.swift
//  MeuNegocio
//
//  Created by Renilson Moreira on 13/08/22.
//

import Foundation
import UIKit

extension UITextField {
    
    func setPaddingLeft() {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: self.frame.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
    
    func addDoneButtonToKeyboard() {
        let doneButton = UIButton(type: .system)
        doneButton.setTitle("Fechar", for: .normal)
        doneButton.addTarget(self, action: #selector(doneButtonTapped), for: .touchUpInside)
        doneButton.sizeToFit()

        let toolBar = UIToolbar()
        toolBar.barStyle = .default
        toolBar.isTranslucent = true
        toolBar.tintColor = .black
        toolBar.sizeToFit()

        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneButtonItem = UIBarButtonItem(customView: doneButton)
        toolBar.setItems([flexibleSpace, doneButtonItem], animated: false)

        self.inputAccessoryView = toolBar
    }

    @objc func doneButtonTapped() {
        self.resignFirstResponder()
    }
}
