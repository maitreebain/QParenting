//
//  TagCell.swift
//  QParenting
//
//  Created by Maitree Bain on 9/24/20.
//  Copyright © 2020 Maitree Bain. All rights reserved.
//

import UIKit

class TagCell: UICollectionViewCell {
    
    @IBOutlet var tagLabel: UILabel!
    
    func configureTag(tag: Tag) {
        tagLabel.text = tag.rawValue
    }
}
