//
//  AddingTextField.swift
//  BookReader
//
//  Created by Александр Павлицкий on 09.03.2025.
//

import UIKit

// MARK: - AddingTextField
final class AddingTextField: UITextField {
    // MARK: - Init
    init(placeholder: String) {
        super.init(frame: .zero)
        
        configure(placeholder: placeholder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private Methods
    private func configure(placeholder: String) {
        self.layer.cornerRadius = 10
        self.backgroundColor = .white
        self.placeholder = placeholder
        self.tag = tag
        self.setShadow()
        self.textColor = UIColor.black
        
        self.setLeftPadding(12)
        
        // setting placeholder
        let font = UIFont.systemFont(ofSize: 16, weight: .thin)
        let color = UIColor.appGray
        let attributes = [NSAttributedString.Key.font: font,
                          NSAttributedString.Key.foregroundColor: color
        ]
        let attributedString = NSAttributedString(string: placeholder, attributes: attributes)
        self.attributedPlaceholder = attributedString
    }
}
