//
//  UIAddOns.swift
//  QParenting
//
//  Created by Maitree Bain on 10/20/20.
//  Copyright © 2020 Maitree Bain. All rights reserved.
//

import UIKit

extension UICollectionViewCell {
    func colorShadow(for color: CGColor) {
        let radius: CGFloat = 10
        contentView.layer.cornerRadius = radius
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = UIColor.clear.cgColor
        contentView.layer.masksToBounds = true
        
        layer.shadowColor = color
        layer.shadowOffset = CGSize(width: 1.0, height: 4.0)
        layer.shadowRadius = 4.0
        layer.shadowOpacity = 0.8
        layer.masksToBounds = false
        layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: radius).cgPath
        layer.cornerRadius = radius
    }
    
}

extension UIView {
    
    func viewShadow() {
        layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        layer.shadowOffset = CGSize(width: 1.0, height: 4.0)
        layer.shadowRadius = 4.0
        layer.shadowOpacity = 0.8
    }
}

extension UIImageView {
    func imageShadow() {
        layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        layer.shadowOffset = CGSize(width: 1.0, height: 4.0)
        layer.shadowRadius = 4.0
        layer.shadowOpacity = 0.8
    }
}

extension UIButton {
    func shadowLayer(_ button: UIButton) {
        button.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        button.layer.shadowOffset = CGSize(width: 1.0, height: 4.0)
        button.layer.shadowRadius = 4.0
        button.layer.shadowOpacity = 0.8
    }
}
