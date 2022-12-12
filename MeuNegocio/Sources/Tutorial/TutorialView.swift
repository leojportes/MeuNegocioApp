//
//  TutorialView.swift
//  MeuNegocio
//
//  Created by Renilson Moreira on 14/11/22.
//

import UIKit

protocol DidTapTutorialButtons: AnyObject {
    func nextPage()
    func previousPage()
}

struct TutorialModel {
    let title: String?
    let image: String?
}

final class TutorialView: UIView {
    
    weak var delegate: DidTapTutorialButtons?
    
    // MARK: - Init
    init() {
        super.init(frame: .zero)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var model: TutorialModel? {
        didSet {
            guard let model = model else { return }
            titleLabel.text = model.title
            tutorialImage.image = UIImage(named: model.image ?? "")
        }
    }
    
    // MARK: - View Code
    lazy var titleLabel: MNLabel = {
        let label = MNLabel(text: "Olá, tudo bem?",
                            font: .boldSystemFont(ofSize: 16),
                            textColor: .black)
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    lazy var containerImage: UIView = {
        let container = UIView()
        container.translatesAutoresizingMaskIntoConstraints = false
        return container
    }()
    
    lazy var tutorialImage: UIImageView = {
        let img = UIImageView()
        img.image = UIImage(named: "tt")
        img.contentMode = .scaleAspectFit
        img.translatesAutoresizingMaskIntoConstraints = false
        return img
    }()
    
    private lazy var stackPages: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private lazy var nextButton: UIButton = {
        let button = UIButton()
        button.setTitle("próximo", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.addTarget(self, action: #selector(didTapNext), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var pageControl: UIPageControl = {
        let page = UIPageControl()
        page.currentPage = 0
        page.numberOfPages = 3
        page.translatesAutoresizingMaskIntoConstraints = false
        page.pageIndicatorTintColor = .gray
        page.currentPageIndicatorTintColor = .MNColors.lightBrown
        return page
    }()
    
    private lazy var previousButton: UIButton = {
        let button = UIButton()
        button.setTitle("voltar", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.addTarget(self, action: #selector(didTapPrevious), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    // MARK: - Actions
    
    @objc func didTapNext() {
        delegate?.nextPage()
    }
    
    @objc func didTapPrevious() {
        delegate?.previousPage()
    }
}

extension TutorialView: ViewCodeContract {
    func setupHierarchy() {
        addSubview(titleLabel)
        addSubview(containerImage)
        addSubview(stackPages)
        containerImage.addSubview(tutorialImage)
        stackPages.addArrangedSubview(previousButton)
        stackPages.addArrangedSubview(pageControl)
        stackPages.addArrangedSubview(nextButton)
    }
    
    func setupConstraints() {
        titleLabel
            .topAnchor(in: self, padding: 80)
            .leftAnchor(in: self, attribute: .left, padding: 16)
            .rightAnchor(in: self, attribute: .right, padding: 16)
        
        containerImage
            .topAnchor(in: titleLabel, attribute: .bottom, padding: 16)
            .leftAnchor(in: self, attribute: .left, padding: 16)
            .rightAnchor(in: self, attribute: .right, padding: 16)
            .bottomAnchor(in: stackPages, attribute: .top, padding: 16)
        
        tutorialImage
            .topAnchor(in: containerImage, padding: 16)
            .leftAnchor(in: containerImage, padding: 16)
            .rightAnchor(in: containerImage, padding: 16)
            .bottomAnchor(in: containerImage, padding: 16)
        
        stackPages
            .leftAnchor(in: self)
            .rightAnchor(in: self)
            .bottomAnchor(in: self, attribute: .bottom, padding: 10, layoutOption: .useMargins)
        
        previousButton.heightAnchor(40)
        nextButton.heightAnchor(40)
    }
    
    func setupConfiguration() {
        backgroundColor = .MNColors.lightGray
    }
}
