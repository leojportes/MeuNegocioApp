//
//  CreateAccountViewController.swift
//  BarberVip
//
//  Created by Renilson Moreira on 15/08/22.
//

import UIKit


class CreateAccountViewController: CoordinatedViewController {
    
    var contentView: CreateAccountView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func loadView() {
        super.loadView()
        contentView = CreateAccountView()
        self.view = contentView
    }
}
