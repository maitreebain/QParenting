//
//  HeaderView.swift
//  QParenting
//
//  Created by Maitree Bain on 9/24/20.
//  Copyright © 2020 Maitree Bain. All rights reserved.
//

import UIKit

protocol HeaderViewDelegate: AnyObject {
    func didSelectTag(_ headerView: HeaderView, _ tag: Tag)
}

enum Tag: String, CaseIterable {
    case general = "general"
    case gay = "gay"
    case lesbian = "lesbian"
    case bisexual = "bisexual"
    case transgender = "transgender"
}

class HeaderView: UICollectionReusableView {
    
    @IBOutlet var stackView: UIStackView!
    
    weak var delegate: HeaderViewDelegate!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func configure() {
        stackView.distribution = .equalSpacing
        for tag in Tag.allCases {
            let button = UIButton(type: .system)
            button.setTitle(tag.rawValue, for: .normal)
            stackView.addArrangedSubview(button)
        }
        //buttons need actions
    }
    
    @objc func tagSelected(sender: UIButton) {
        
    }
    
}
