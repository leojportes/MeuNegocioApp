//
//  LoginView.swift
//  BarberVip
//
//  Created by Renilson Moreira on 02/08/22.
//

import Foundation
import UIKit

class LoginView: UIView {
    
    // MARK: - Properties
    var navigateToHome: Action?
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var loginButton: UIButton = {
        let button = UIButton()
        button.setTitle("Login", for: .normal)
        button.setTitleColor(UIColor.blue, for: .normal)
        button.addTarget(self, action: #selector(handleLoginButton), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    @objc
    func handleLoginButton() {
        self.navigateToHome?()
    }
    
    // MARK: - Methods
    func setupHomeView(navigateToHome: @escaping Action) {
        self.navigateToHome = navigateToHome
    }
    
}

extension LoginView: ViewCodeContract {
    func setupHierarchy() {
        addSubview(loginButton)
    }
    
    func setupConstraints() {
        loginButton
            .topAnchor(in: self, attribute: .top)
            .leftAnchor(in: self)
            .rightAnchor(in: self)
    }
}
