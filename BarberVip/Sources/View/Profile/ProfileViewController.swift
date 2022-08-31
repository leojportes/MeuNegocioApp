//
//  ProfileViewController.swift
//  BarberVip
//
//  Created by Renilson Moreira on 23/08/22.
//

import UIKit

class ProfileViewController: CoordinatedViewController {
    
    var closed: Action?

    // MARK: - Private properties
    private let customView = ProfileView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "perfil"
        closedFlow()
    }
    
    override func loadView() {
        super.loadView()
        self.view = customView
    }
    
    func closedFlow() {
        customView.closed = weakify { $0.closed?() }
    }

}
