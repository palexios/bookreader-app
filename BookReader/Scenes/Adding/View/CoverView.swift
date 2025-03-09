//
//  NewCoverView.swift
//  BookReader
//
//  Created by Александр Павлицкий on 05.03.2025.
//

import UIKit
final class CoverView: UIView {
    // MARK: - GUI
    lazy var button: UIButton = {
        let button = UIButton()
        
        let imageConfiguration = UIImage.SymbolConfiguration(pointSize: 30, weight: .regular)
        let image = UIImage(systemName: "arrow.down.to.line", withConfiguration: imageConfiguration)
        
        button.setImage(image, for: .normal)
        button.backgroundColor = .systemGray5
        button.layer.cornerRadius = 15
        button.tintColor = .appGray
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    private lazy var title: UILabel = {
        let label = UILabel()
        label.text = "Загрузите обложку"
        label.font = .systemFont(ofSize: 14, weight: .thin)
        label.textColor = .appGray
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    // MARK: - Private Methods
    func configure() {
        self.backgroundColor = .white
        self.layer.cornerRadius = 15
        self.setShadow()
    }
    
    func configureButtonLayout() {
        self.addSubview(button)
        NSLayoutConstraint.activate([
            button.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            button.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            button.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.4),
            button.heightAnchor.constraint(equalTo: button.widthAnchor)
        ])
        
    }
    
    func configureTitleLayout() {
        self.addSubview(title)
        NSLayoutConstraint.activate([
            title.topAnchor.constraint(equalTo: self.button.bottomAnchor, constant: 12),
            title.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        ])
    }
}
