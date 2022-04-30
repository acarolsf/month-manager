//
//  HomeViewController.swift
//  gerenciador mensal
//
//  Created by Ana Carolina Ferreira on 30/04/22.
//

import UIKit

class HomeViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupConstraints()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        DispatchQueue.main.async {
            self.navigationController?.setNavigationBarHidden(true, animated: false)
        }
    }
    
    lazy var mainView: UIView = {
        let view = UIView(constraintResizing: false)
        view.backgroundColor = .white
        return view
    }()
    
    lazy var welcomeLabel: UILabel = {
        let label = UILabel(constraintResizing: false)
        label.text = "Olá, Carol"
        label.font.withSize(24)
        return label
    }()
    
    lazy var cardView: UIView = {
        let view = UIView(constraintResizing: false)
        view.backgroundColor = UIColor(hex: "#F2F2F2")
        return view
    }()
    
    lazy var floatingButton: UIButton = {
        let button = UIButton(constraintResizing: false)
        button.setImage(.add, for: .normal)
        button.backgroundColor = UIColor(hex: "#054F77")
        button.tintColor = .clear
        button.clipsToBounds = true
        button.layer.cornerRadius = 30
        button.contentMode = .scaleAspectFill
        button.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(openRegisterNewItem)))
        return button
    }()
    
    private func setupUI() {
        view.addSubview(mainView)
        mainView.addSubview(welcomeLabel)
        mainView.addSubview(cardView)
        
        view.addSubview(floatingButton)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            mainView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            mainView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mainView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mainView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            welcomeLabel.topAnchor.constraint(equalTo: mainView.topAnchor, constant: 24),
            welcomeLabel.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: 24),
            welcomeLabel.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: -24),
            
            cardView.topAnchor.constraint(equalTo: welcomeLabel.bottomAnchor, constant: 24),
            cardView.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: 24),
            cardView.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: -24),
            cardView.heightAnchor.constraint(equalToConstant: 150),
            
            floatingButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            floatingButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
            floatingButton.heightAnchor.constraint(equalToConstant: 60),
            floatingButton.widthAnchor.constraint(equalToConstant: 60)
        ])
    }
    
    @objc func openRegisterNewItem() {
        self.navigationController?.pushViewController(RegisterItemViewController(), animated: true)
    }
}
