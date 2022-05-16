//
//  HomeHeader.swift
//  gerenciador mensal
//
//  Created by Ana Carolina Ferreira on 30/04/22.
//

import Foundation
import UIKit

class HomeHeader: UIView {
    
    var name: String? {
        didSet {
            self.welcomeLabel.text = "Olá, \(name ?? "")!"
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var mainView: UIView = UIView(constraintResizing: false)
    
    lazy var welcomeLabel: UILabel = {
        let label = UILabel(constraintResizing: false)
        label.textAlignment = .center
        label.font = .boldSystemFont(ofSize: 24)
        return label
    }()
    
    lazy var cardView: UIStackView = {
        let stackView = UIStackView(constraintResizing: false)
        stackView.backgroundColor = UIColor(hex: "#F2F2F2")
        stackView.spacing = 2
        stackView.axis = .vertical
        stackView.layoutMargins = UIEdgeInsets(top: 16, left: 0, bottom: 16, right: 0)
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.clipsToBounds = true
        stackView.layer.cornerRadius = 10
        return stackView
    }()
    
    lazy var cardTitle: UILabel = {
        let label = UILabel(constraintResizing: false)
        label.text = "Seus gastos esse mês"
        label.textColor = UIColor(hex: "#054F77")
        label.font = .systemFont(ofSize: 12, weight: .light)
        label.textAlignment = .center
        return label
    }()
    
    lazy var cardPrice: UILabel = {
        let label = UILabel(constraintResizing: false)
        label.text = "R$ 1000,00"
        label.textColor = UIColor(hex: "#054F77")
        label.font = .boldSystemFont(ofSize: 32)
        label.textAlignment = .center
        return label
    }()
    
    private func setupUI() {
        mainView.backgroundColor = .white
        addSubview(mainView)
        mainView.addSubview(welcomeLabel)
        mainView.addSubview(cardView)
        
        cardView.addArrangedSubview(cardTitle)
        cardView.addArrangedSubview(cardPrice)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            
            mainView.topAnchor.constraint(equalTo: topAnchor),
            mainView.leadingAnchor.constraint(equalTo: leadingAnchor),
            mainView.trailingAnchor.constraint(equalTo: trailingAnchor),
            mainView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            welcomeLabel.topAnchor.constraint(equalTo: mainView.topAnchor, constant: 24),
            welcomeLabel.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: 24),
            welcomeLabel.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: -24),
            
            cardView.topAnchor.constraint(equalTo: welcomeLabel.bottomAnchor, constant: 24),
            cardView.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: 24),
            cardView.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: -24),
            cardView.bottomAnchor.constraint(equalTo: mainView.bottomAnchor, constant: -16)
            
//            cardTitle.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 4),
//            cardTitle.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 8),
//            cardTitle.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -8),
//
//            cardPrice.topAnchor.constraint(equalTo: cardTitle.topAnchor, constant: 4),
//            cardPrice.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 8),
//            cardPrice.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -8),
//            cardPrice.bottomAnchor.constraint(equalTo: cardView.bottomAnchor, constant: -4)
        ])
    }
}
