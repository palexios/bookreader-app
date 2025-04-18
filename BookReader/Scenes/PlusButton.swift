//
//  PlusButton.swift
//  BookReader
//
//  Created by Александр Павлицкий on 19.04.2025.
//

import UIKit

// MARK: - PlusButton
final class PlusButton: UIButton {
    // MARK: - Properties
    var buttonTapped: (() -> Void)?
    
    // MARK: - Init
    init(buttonTapped: @escaping () -> Void) {
        self.buttonTapped = buttonTapped
        super.init(frame: .zero)
        
        setupUI()
    }
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - LifeCycle
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.cornerRadius = self.frame.width / 2
    }
    
    // MARK: - Private Methods
    private func setupUI() {
        self.setDefaultBorder()
        self.backgroundColor = .white
        self.addTarget(self, action: #selector(buttonTappedAction), for: .touchUpInside)
        
        let symbolConfiguration = Resources.SymbolConfigurations.TabBar.plus
        let symbolImage = Resources.Images.TabBar.plus.withConfiguration(symbolConfiguration)
        self.setImage(symbolImage, for: .normal)
        self.tintColor = .appGray
    }
    
    // MARK: - @OBJC Methods
    @objc private func buttonTappedAction() {
        buttonTapped?()
    }
}
