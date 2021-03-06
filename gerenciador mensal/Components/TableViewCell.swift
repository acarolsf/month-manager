//
//  TableViewCell.swift
//  gerenciador mensal
//
//  Created by Ana Carolina Ferreira on 30/04/22.
//

import Foundation
import UIKit

class TableViewCell: UITableViewCell {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
        setupConstraints()
        selectionStyle = .none
        separatorInset = .zero
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var mainView: UIView = {
        let view = UIView(constraintResizing: false)
        view.backgroundColor = UIColor(hex: "#F2F2F2")
        view.clipsToBounds = true
        view.layer.cornerRadius = 10
        return view
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel(constraintResizing: false)
        label.text = "Título"
        label.textColor = UIColor(hex: "#424242")
        return label
    }()
    
    lazy var subTitleLabel: UILabel = {
        let label = UILabel(constraintResizing: false)
        label.text = "Subtítulo"
        label.textColor = UIColor(hex: "#999999")
        return label
    }()
    
    private func setupUI() {
        addSubview(mainView)
        [
            titleLabel,
            subTitleLabel
        ].forEach({
            mainView.addSubview($0)
        })
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            mainView.topAnchor.constraint(equalTo: topAnchor, constant: 4),
            mainView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            mainView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            mainView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -4),
            
            titleLabel.topAnchor.constraint(equalTo: mainView.topAnchor, constant: 8),
            titleLabel.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: 8),
            titleLabel.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: -8),
            
            subTitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
            subTitleLabel.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: 8),
            subTitleLabel.bottomAnchor.constraint(equalTo: mainView.bottomAnchor, constant: -8),
            subTitleLabel.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: -8)
        ])
    }

    func setupCell(title: String?, subtitle: String?) {
        self.titleLabel.text = title
        self.subTitleLabel.text = subtitle
    }
}
