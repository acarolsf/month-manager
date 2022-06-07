//
//  LoginViewController.swift
//  gerenciador mensal
//
//  Created by Ana Carolina Ferreira on 29/04/22.
//

import UIKit

class LoginViewController: UIViewController {
    
    lazy var presenter = LoginPresenter(view: self)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupConstraints()
        self.presenter.checkIfUserIsLogged()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        view.backgroundColor = .white
        ensureMainThread {
            self.navigationController?.setNavigationBarHidden(true, animated: true)
        }
    }

    // MARK: - Layout Components
    
    lazy var mainView: UIView = UIView(constraintResizing: false)
    
    lazy var imageView: UIImageView = {
        let imageView = UIImageView(constraintResizing: false)
        imageView.image = .logo
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    lazy var titleLogo: UILabel = {
        let label = UILabel(constraintResizing: false)
        label.textColor = UIColor(hex: "#054F77")
        label.text = "Gerenciador Mensal"
        label.textAlignment = .center
        return label
    }()
    
    lazy var nameTextField: TextField = {
        let textField = TextField(constraintResizing: false)
        textField.placeholder = "Digite o seu nome"
        return textField
    }()
    
    lazy var passwordTextField: TextField = {
        let textField = TextField(constraintResizing: false)
        textField.placeholder = "Digite uma senha"
        textField.isSecureTextEntry = true
        return textField
    }()
    
    lazy var enterButton: UIButton = {
        let button = UIButton(constraintResizing: false)
        button.setTitle("Entrar", for: .normal)
        button.backgroundColor = UIColor(hex: "#054F77")
        button.clipsToBounds = true
        button.layer.cornerRadius = 4
        button.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(openHome)))
        return button
    }()
    
    // MARK: - Setup Layout
    private func setupUI() {
        view.addSubview(mainView)
        mainView.addSubview(imageView)
        mainView.addSubview(titleLogo)
        mainView.addSubview(nameTextField)
        mainView.addSubview(passwordTextField)
        mainView.addSubview(enterButton)
        
        mainView.backgroundColor = .white
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            mainView.topAnchor.constraint(equalTo: view.topAnchor),
            mainView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mainView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mainView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            imageView.topAnchor.constraint(equalTo: mainView.topAnchor, constant: 24),
            imageView.centerXAnchor.constraint(equalTo: mainView.centerXAnchor),
            imageView.heightAnchor.constraint(equalTo: mainView.heightAnchor, multiplier: 0.3),
            
            titleLogo.topAnchor.constraint(equalTo: imageView.bottomAnchor),
            titleLogo.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: 24),
            titleLogo.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: -24),
            titleLogo.heightAnchor.constraint(equalToConstant: 48),
            
            nameTextField.topAnchor.constraint(equalTo: titleLogo.bottomAnchor, constant: 24),
            nameTextField.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: 24),
            nameTextField.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: -24),
            nameTextField.heightAnchor.constraint(equalToConstant: 48),
            
            passwordTextField.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 24),
            passwordTextField.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: 24),
            passwordTextField.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: -24),
            passwordTextField.heightAnchor.constraint(equalToConstant: 48),
            
            enterButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 24),
            enterButton.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: 24),
            enterButton.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: -24),
            enterButton.heightAnchor.constraint(equalToConstant: 48),
        ])
    }
    
    // MARK: - Actions
    @objc func openHome() {
        self.presenter.login(userName: self.nameTextField.text)
    }
}

extension LoginViewController: LoginViewProtocol {
    func goToHome(name: String) {
        let viewController = HomeViewController()
        viewController.userName = name
        navigationController?.pushViewController(viewController, animated: true)
    }
}
