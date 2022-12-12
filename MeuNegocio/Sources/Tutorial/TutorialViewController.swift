//
//  TutorialViewController.swift
//  MeuNegocio
//
//  Created by Renilson Moreira on 14/11/22.
//

import UIKit

class TutorialViewController: UIViewController {

    let customView = TutorialView()
    var model = [
        TutorialModel(title: "Aqui você pode acompanhar os procedimentos e demais informações do app",
                      image: "tt"),
        TutorialModel(title: "Relatorio",
                      image: "report_daily"),
        TutorialModel(title: "Leo",
                      image: "report_daily")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        customView.delegate = self
        updateView(index: customView.pageControl.currentPage)
    }
    
    override func loadView() {
        super.loadView()
        self.view = customView
    }
    
    private func updateView(index: Int) {
        customView.model = model[index]
    }
}

extension TutorialViewController: DidTapTutorialButtons {
    func nextPage() {
        customView.pageControl.currentPage += 1
        updateView(index: customView.pageControl.currentPage)
    }
    
    func previousPage() {
        customView.pageControl.currentPage -= 1
        updateView(index: customView.pageControl.currentPage)
    }
    
    
}
