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
        label.textColor = .black
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
