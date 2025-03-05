//
//  UIView+Ext.swift
//  BookReader
//
//  Created by Александр Павлицкий on 05.03.2025.
//

import UIKit

extension UIView {
    func setShadow() {
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.2
        self.layer.shadowOffset = .init(width: 0, height: 5)
    }
}
