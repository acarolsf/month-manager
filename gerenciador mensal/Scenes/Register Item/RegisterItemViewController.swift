//
//  RegisterItemViewController.swift
//  gerenciador mensal
//
//  Created by Ana Carolina Ferreira on 30/04/22.
//

import UIKit

class RegisterItemViewController: UIViewController {
    
    private let accountTypeList = ["Água", "Luz", "Internet"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Cadastrar nova conta"
        setupUI()
        setupConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        ensureMainThread {
            self.navigationController?.navigationBar.backgroundColor = UIColor(hex: "#054F77")
            self.navigationController?.setNavigationBarHidden(false, animated: animated)
        }
    }
    
    lazy var mainView = UIView(constraintResizing: false)
    
    lazy var accountTypeLabel: UILabel = {
        let label = UILabel(constraintResizing: false)
        label.text = "Tipo de conta"
        return label
    }()
    
    lazy var accountTypeTextField: TextField = {
        let textField = TextField(constraintResizing: false)
        textField.placeholder = "Selecione o tipo de conta"
        textField.addToolbar()
        textField.setiConInRightSide(.expandMore)
        return textField
    }()
    
    lazy var descriptionLabel: UILabel = {
        let label = UILabel(constraintResizing: false)
        label.text = "Descrição"
        return label
    }()
    
    lazy var descriptionTextField: TextField = {
        let textField = TextField(constraintResizing: false)
        textField.placeholder = "Digite a descrição"
        textField.addToolbar()
        return textField
    }()
    
    lazy var priceLabel: UILabel = {
        let label = UILabel(constraintResizing: false)
        label.text = "Preço"
        return label
    }()
    
    lazy var priceTextField: TextField = {
        let textField = TextField(constraintResizing: false)
        textField.placeholder = "Digite o preço"
        textField.addToolbar()
        textField.keyboardType = .numberPad
        return textField
    }()
    
    lazy var monthLabel: UILabel = {
        let label = UILabel(constraintResizing: false)
        label.text = "Mês"
        return label
    }()
    
    lazy var monthTextField: TextField = {
        let textField = TextField(constraintResizing: false)
        textField.placeholder = "Selecione o mês"
        textField.addToolbar()
        return textField
    }()
    
    private func setupUI() {
        view.addSubview(mainView)
        [
            accountTypeLabel,
            accountTypeTextField,
            descriptionLabel,
            descriptionTextField,
            priceLabel,
            priceTextField,
            monthLabel,
            monthTextField
            
        ].forEach({
            mainView.addSubview($0)
        })
        
        mainView.backgroundColor = .white
        createProfilePicker()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            mainView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            mainView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mainView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mainView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            accountTypeLabel.topAnchor.constraint(equalTo: mainView.topAnchor, constant: 24),
            accountTypeLabel.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: 24),
            accountTypeLabel.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: -24),
            
            accountTypeTextField.topAnchor.constraint(equalTo: accountTypeLabel.bottomAnchor, constant: 4),
            accountTypeTextField.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: 24),
            accountTypeTextField.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: -24),
            accountTypeTextField.heightAnchor.constraint(equalToConstant: 48),
            
            descriptionLabel.topAnchor.constraint(equalTo: accountTypeTextField.bottomAnchor, constant: 24),
            descriptionLabel.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: 24),
            descriptionLabel.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: -24),
            
            descriptionTextField.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 4),
            descriptionTextField.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: 24),
            descriptionTextField.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: -24),
            descriptionTextField.heightAnchor.constraint(equalToConstant: 48),
            
            priceLabel.topAnchor.constraint(equalTo: descriptionTextField.bottomAnchor, constant: 24),
            priceLabel.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: 24),
            priceLabel.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: -24),
            
            priceTextField.topAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: 4),
            priceTextField.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: 24),
            priceTextField.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: -24),
            priceTextField.heightAnchor.constraint(equalToConstant: 48),
            
            monthLabel.topAnchor.constraint(equalTo: priceTextField.bottomAnchor, constant: 24),
            monthLabel.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: 24),
            monthLabel.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: -24),
            
            monthTextField.topAnchor.constraint(equalTo: monthLabel.bottomAnchor, constant: 4),
            monthTextField.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: 24),
            monthTextField.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: -24),
            monthTextField.heightAnchor.constraint(equalToConstant: 48)
        ])
    }
    
    func createProfilePicker() {
        let profilePickerView = UIPickerView()
        profilePickerView.delegate = self
        profilePickerView.backgroundColor = UIColor.white
        accountTypeTextField.inputView = profilePickerView
    }
}

extension RegisterItemViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.accountTypeList.count + 1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return row == 0 ? "" : accountTypeList[row-1]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        accountTypeTextField.text = row == 0 ? "" : accountTypeList[row-1]
    }
}
