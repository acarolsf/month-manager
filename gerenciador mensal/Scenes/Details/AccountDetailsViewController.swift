//
//  AccountDetailsViewController.swift
//  gerenciador mensal
//
//  Created by Ana Carolina Ferreira on 17/05/22.
//

import UIKit

class AccountDetailsViewController: UIViewController {
    
    var conta: Contas? {
        didSet {
            setupData()
        }
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNeedsStatusBarAppearanceUpdate()
        title = "Detalhe da conta"
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavigationBar()
        ensureMainThread {
            self.navigationController?.setNavigationBarHidden(false, animated: animated)
        }
    }
    
    lazy var mainView: UIView = UIView(constraintResizing: false)
    
    lazy var descriptionLabel: UILabel = {
        let label = UILabel(constraintResizing: false)
        label.font = .boldSystemFont(ofSize: 18)
        label.textColor = UIColor(hex: "#424242") // UIColor(hex: "#054F77")
        label.textAlignment = .center
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    lazy var priceLabel: UILabel = {
        let label = UILabel(constraintResizing: false)
        label.font = .boldSystemFont(ofSize: 32)
        label.textColor = UIColor(hex: "#054F77")
        label.textAlignment = .center
        return label
    }()
    
    lazy var typeLabel: UILabel = {
        let label = UILabel(constraintResizing: false)
        label.textColor = UIColor(hex: "#424242")
        return label
    }()
    
    lazy var monthLabel: UILabel = {
        let label = UILabel(constraintResizing: false)
        label.textColor = UIColor(hex: "#424242")
        return label
    }()
    
    lazy var stackView: UIStackView = {
        let stackView = UIStackView(constraintResizing: false)
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 8
        return stackView
    }()
    
    lazy var deleteButton: UIButton = {
        let button = UIButton(constraintResizing: false)
        button.setTitle("Excluir", for: .normal)
        button.setTitleColor(.red, for: .normal)
        button.setImage(.remove, for: .normal)
        button.clipsToBounds = true
        button.layer.cornerRadius = 4
        button.tintColor = .red
        return button
    }()
    
    lazy var editButton: UIButton = {
        let button = UIButton(constraintResizing: false)
        button.setTitle("Editar", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.setImage(.edit, for: .normal)
        button.tintColor = .white
        button.clipsToBounds = true
        button.layer.cornerRadius = 4
        button.backgroundColor = UIColor(hex: "#054F77")
        return button
    }()
    
    func setupUI() {
        view.addSubview(mainView)
        [
            descriptionLabel,
            priceLabel,
            typeLabel,
            monthLabel,
            stackView
        ].forEach({
            mainView.addSubview($0)
        })
        stackView.addArrangedSubview(deleteButton)
        stackView.addArrangedSubview(editButton)
        mainView.backgroundColor = .white
        setupConstraints()
        deleteButton.isHidden = true
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            mainView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            mainView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mainView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mainView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            descriptionLabel.topAnchor.constraint(equalTo: mainView.topAnchor, constant: 24),
            descriptionLabel.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: 16),
            descriptionLabel.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: -16),
            
            priceLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 16),
            priceLabel.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: 16),
            priceLabel.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: -16),
            
            typeLabel.topAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: 24),
            typeLabel.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: 16),
            typeLabel.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: -16),
            
            monthLabel.topAnchor.constraint(equalTo: typeLabel.bottomAnchor, constant: 24),
            monthLabel.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: 16),
            monthLabel.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: -16),
            
            stackView.topAnchor.constraint(equalTo: monthLabel.bottomAnchor, constant: 32),
            stackView.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: -16),
            
            deleteButton.heightAnchor.constraint(equalToConstant: 48),
            editButton.heightAnchor.constraint(equalToConstant: 48)
        ])
    }
    
    func setupData() {
        guard let conta = conta else { return }
        descriptionLabel.text = conta.descricao
        priceLabel.text = Validation.shared.convertPriceToString(conta.preco)
        monthLabel.setAtributtedTextBoldAndRegular(bold: "Mês: ", regular: Validation.shared.convertDateToString(date: conta.mes))
        typeLabel.setAtributtedTextBoldAndRegular(bold: "Tipo: ", regular: conta.tipoConta)
    }
    
    @objc func goToEditPage() {
        let viewController = RegisterItemViewController()
        viewController.origin = .edit
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    @objc func deleteAlert() {
        
    }
}
