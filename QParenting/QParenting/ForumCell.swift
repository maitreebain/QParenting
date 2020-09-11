//
//  ForumCell.swift
//  QParenting
//
//  Created by Maitree Bain on 9/8/20.
//  Copyright © 2020 Maitree Bain. All rights reserved.
//

import UIKit

class ForumCell: UICollectionViewCell {
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var authorLabel: UILabel!
    
    func configureCell(_ post: Post) {
        titleLabel.text = post.title
        authorLabel.text = post.author
    }
}
