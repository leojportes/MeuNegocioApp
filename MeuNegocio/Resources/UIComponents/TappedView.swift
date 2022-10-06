//
//  TappedView.swift
//  MeuNegocio
//
//  Created by Leonardo Portes on 28/09/22.
//

import UIKit

class TappedView: UIView {
    
    // MARK: - Private properties
    private var actionButton: Action?
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        tapGestureRecognizer()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func setup(
        action: @escaping Action = { () }
    ) {
        self.translatesAutoresizingMaskIntoConstraints = false
        actionButton = action
    }
        
    @objc private func tappedView(sender: UITapGestureRecognizer) {
        if sender.state == .ended {
            self.actionButton?()
        }
    }
    
    private func tapGestureRecognizer() {
        let tapGR = UITapGestureRecognizer(target: self, action: #selector(self.tappedView))
        self.addGestureRecognizer(tapGR)
        self.isUserInteractionEnabled = true
    }
    
}
