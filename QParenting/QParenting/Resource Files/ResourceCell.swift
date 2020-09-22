//
//  ResourceCell.swift
//  QParenting
//
//  Created by Maitree Bain on 9/6/20.
//  Copyright © 2020 Maitree Bain. All rights reserved.
//

import UIKit

class ResourceCell: UICollectionViewCell {
    
    @IBOutlet var resourceLink: UILabel!
    
    func configureCell(_ resource: SiteInfo) {
        resourceLink.text = resource.link
    }
}
