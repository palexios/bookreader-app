//
//  UITextField+Ext.swift
//  BookReader
//
//  Created by Александр Павлицкий on 05.03.2025.
//

import UIKit

extension UITextField {
    func setLeftPadding(_ amount: CGFloat) {
        let view = UIView(frame: .init(x: 0, y: 0, width: amount, height: self.frame.height))
        self.leftView = view
        self.leftViewMode = .always
    }
}
