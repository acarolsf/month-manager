//
//  HomeViewController.swift
//  gerenciador mensal
//
//  Created by Ana Carolina Ferreira on 30/04/22.
//

import UIKit
import CoreData

class HomeViewController: UIViewController {
    
    var userName: String = "" {
        didSet {
            self.homeHeader.name = userName
        }
    }
    
    lazy var presenter = HomePresenter(view: self)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupConstraints()
        setupNavigationBar()
        self.presenter.fetcher.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.tableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        view.backgroundColor = .white
        self.presenter.fetchItems()
        ensureMainThread {
            self.navigationController?.navigationBar.tintColor = .black
            self.navigationController?.setNavigationBarHidden(true, animated: false)
        }
    }
    
    lazy var logoutButton: UIButton = {
        let button = UIButton(constraintResizing: false)
        button.setImage(.logout, for: .normal)
        button.tintColor = UIColor(hex: "#054F77")
        button.addTarget(self, action: #selector(logout), for: .touchUpInside)
        return button
    }()
    
    lazy var homeHeader: HomeHeader = {
        let view = HomeHeader(constraintResizing: true)
        return view
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView(constraintResizing: false)
        tableView.backgroundColor = .white
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.register(TableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.sectionHeaderHeight = UITableView.automaticDimension
        return tableView
    }()
    
    lazy var lastItensSectionLabel: UILabel = {
        let label = UILabel(constraintResizing: false)
        label.text = "??ltimas contas"
        label.font.withSize(24)
        return label
    }()
    
    lazy var floatingButton: UIButton = {
        let button = UIButton(constraintResizing: false)
        button.setImage(.add, for: .normal)
        button.backgroundColor = UIColor(hex: "#054F77")
        button.tintColor = .white
        button.clipsToBounds = true
        button.layer.cornerRadius = 30
        button.contentMode = .scaleAspectFill
        button.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(openRegisterNewItem)))
        return button
    }()
    
    private func setupUI() {
        view.addSubview(tableView)
        view.addSubview(logoutButton)
        view.addSubview(floatingButton)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            logoutButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 16),
            logoutButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            logoutButton.heightAnchor.constraint(equalToConstant: 48),
            
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            floatingButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            floatingButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
            floatingButton.heightAnchor.constraint(equalToConstant: 60),
            floatingButton.widthAnchor.constraint(equalToConstant: 60)
        ])
    }
    
    @objc func openRegisterNewItem() {
        let viewController = RegisterItemViewController()
        viewController.modalPresentationCapturesStatusBarAppearance = true
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    @objc func logout() {
        presenter.logout()
        navigationController?.pushViewController(LoginViewController(), animated: true)
    }
    
    @objc func goToEditPage(_ conta: Contas) {
        let viewController = RegisterItemViewController()
        viewController.origin = .edit
        viewController.conta = conta
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    func goToDetailPage(conta: Contas) {
        let viewController = AccountDetailsViewController()
        viewController.conta = conta
        navigationController?.pushViewController(viewController, animated: true)
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 1 {
            return self.presenter.fetcher.fetchedObjects?.count ?? 0
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? TableViewCell, let conta = self.presenter.fetcher.fetchedObjects?[indexPath.row] else { return UITableViewCell() }
        
        print(conta.id)
        cell.setupCell(title: conta.descricao, subtitle: conta.tipoConta)
        return cell

    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 1 {
            return "??ltimas contas"
        }
        return ""
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {
            let header = self.homeHeader
            header.total = self.presenter.getTotal()
            return header
        }
        return nil
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let conta = self.presenter.fetcher.fetchedObjects?[indexPath.row] else { return }
        
        self.goToDetailPage(conta: conta)
    }
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        guard let conta = self.presenter.fetcher.fetchedObjects?[indexPath.row] else { return nil }
        
        let completeAction = UIContextualAction(style: .normal, title: "Editar") { (_, _, completionHandler) in
            // delete the item here
            
            self.goToEditPage(conta)
            completionHandler(true)
        }
        completeAction.image = .edit
        completeAction.title = "Editar"
        completeAction.backgroundColor = .systemBlue
        let configuration = UISwipeActionsConfiguration(actions: [completeAction])
        return configuration
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let completeAction = UIContextualAction(style: .normal, title: "Excluir") { (_, _, completionHandler) in
            // delete the item her
            self.deleteAlert(indexPath)
            completionHandler(true)
        }
        completeAction.image = .remove
        completeAction.title = "Excluir"
        completeAction.backgroundColor = .systemRed
        let configuration = UISwipeActionsConfiguration(actions: [completeAction])
        return configuration
    }
    
    func deleteAlert(_ index: IndexPath) {
        
        guard let item = presenter.fetcher.fetchedObjects?[index.row] else { return }
        
        let delete = UIAlertController(title: "Excluir conta", message: "Deseja realmente excluir \(item.descricao)?", preferredStyle: .alert)
        
            
        let deleteAction = UIAlertAction(title: "Sim", style: .destructive) { _ in
            print("Excluir")
            self.presenter.deleteConta(index)
        }
        
        let cancelAction = UIAlertAction(title: "N??o", style: .cancel) { _ in
            print("Cancel")
        }
        
        delete.addAction(deleteAction)
        delete.addAction(cancelAction)
        
        present(delete, animated: true, completion: nil)
    }
}

extension HomeViewController: HomeViewProtocol {
    func removeItem(at index: IndexPath) {
        ensureMainThread {
            self.tableView.deleteRows(at: [IndexPath(item: index.row, section: 1)], with: .fade)
            self.tableView.reloadData()
        }
    }
    
    func reloadData() {
        ensureMainThread {
            self.tableView.reloadData()
        }
    }
}

extension HomeViewController: NSFetchedResultsControllerDelegate {
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type {
        case .delete:
            if let indexPath = indexPath {
                self.removeItem(at: indexPath)
            }
        default:
            self.reloadData()
        }
    }
}
