//
//  StartView.swift
//  MeuNegocio
//
//  Created by Renilson Moreira on 27/10/22.
//

import Foundation
import UIKit

class StartView: UIView {
    
    // MARK: - Init
     init() {
         super.init(frame: .zero)
         setupView()
     }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    lazy var container: UIImageView = {
        let container = UIImageView()
        container.image = UIImage(named: "launchScreen")
        container.translatesAutoresizingMaskIntoConstraints = false
        return container
    }()
}

extension StartView: ViewCodeContract {
    func setupHierarchy() {
        addSubview(container)
    }
    
    func setupConstraints() {
        container
            .centerY(in: self, layoutOption: .useSafeArea)
            .centerX(in: self)
            .heightAnchor(130)
            .widthAnchor(130)
    }
    
    func setupConfiguration() {
        self.backgroundColor = .MNColors.lightBrown
    }
}
