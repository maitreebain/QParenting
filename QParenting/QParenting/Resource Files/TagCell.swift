//
//  TagCell.swift
//  QParenting
//
//  Created by Maitree Bain on 10/8/20.
//  Copyright © 2020 Maitree Bain. All rights reserved.
//

import UIKit

class TagCell: UICollectionViewCell {
    
    static let reuseIdentifier = "tagCell"
    
    public lazy var tagLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15.0)
        label.textColor = .white
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()

        backgroundColor = UIColor(displayP3Red: .random(in: 0...1), green: .random(in: 0...1), blue: .random(in: 0...1), alpha: 1.0)
        layer.cornerRadius = 16
        
        clipsToBounds = false
        layer.masksToBounds = false
        layer.shadowRadius = 5;
        layer.shadowOpacity = 0.5;
        layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
        layer.shadowPath =  UIBezierPath(roundedRect: bounds, cornerRadius: 4).cgPath
    }
    
    private func commonInit() {
        setUpTagLabelConstraints()
    }
    
    private func setUpTagLabelConstraints() {
        addSubview(tagLabel)
        
        tagLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tagLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            tagLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            tagLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
        ])
    }
    
}
