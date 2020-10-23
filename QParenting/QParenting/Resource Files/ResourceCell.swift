//
//  ResourceCell.swift
//  QParenting
//
//  Created by Maitree Bain on 9/6/20.
//  Copyright © 2020 Maitree Bain. All rights reserved.
//

import UIKit
import DataPersistence

protocol SavedArticleDelegate: AnyObject {
    func didSaveArticle(_ cell: UICollectionViewCell, article: SiteInfo)
}

class ResourceCell: UICollectionViewCell {
    
    @IBOutlet var resourceImage: UIImageView!
    @IBOutlet var resourceLink: UILabel!
    @IBOutlet var tags: UILabel!
    @IBOutlet var saveButton: UIButton!
    
    static let reuseIdentifier = "resourceCell"
    var dp = DataPersistence<SiteInfo>(filename: "savedArticles")
    
    var article: SiteInfo! //refactor to initialier
    weak var delegate: SavedArticleDelegate?
    
    var saveArticle = false {
        didSet {
            if saveArticle {
                saveButton.setImage(UIImage(systemName: "star.fill"), for: .normal)
            } else {
                saveButton.setImage(UIImage(systemName: "star"), for: .normal)
            }
        }
    }
    
    func configureCell(_ resource: SiteInfo) {
        resourceLink.text = resource.name.capitalized
        tags.text = resource.tags.joined(separator: ", ")
        article = resource
    }
    
    @IBAction func didSaveArticle(_ sender: UIButton) {
        delegate?.didSaveArticle(self, article: article)
        saveArticle = true
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        resourceImage.layer.cornerRadius = 14
        saveButton.layer.cornerRadius = 20
    }
}
