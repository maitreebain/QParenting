//
//  ResourceCell.swift
//  QParenting
//
//  Created by Maitree Bain on 9/6/20.
//  Copyright © 2020 Maitree Bain. All rights reserved.
//

import UIKit

class ResourceCell: UICollectionViewCell {
    
    @IBOutlet var resourceImage: UIImageView!
    @IBOutlet var resourceLink: UILabel!
    @IBOutlet var tags: UILabel!
    
    static let reuseIdentifier = "resourceCell"
    
    func configureCell(_ resource: SiteInfo) {
        resourceLink.text = resource.name.capitalized
        //make network call
        tags.text = resource.tags.joined(separator: ", ")
    }
}
