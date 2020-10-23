//
//  SavedArticlesController.swift
//  QParenting
//
//  Created by Maitree Bain on 10/20/20.
//  Copyright © 2020 Maitree Bain. All rights reserved.
//

import UIKit
import DataPersistence

class SavedArticlesController: UIViewController {
    
    @IBOutlet var savedArticlesCollection: UICollectionView!
    
    private var dataPer = DataPersistence<SiteInfo>(filename: "savedArticles")
    var imageNames = ["prideB", "prideC", "prideD", "prideE", "prideF"]
    var imagesArr = [UIImage]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        randomImages()
        savedArticlesCollection.delegate = self
        savedArticlesCollection.dataSource = self
        savedArticlesCollection.register(UINib(nibName: "ResourceCell", bundle: nil), forCellWithReuseIdentifier: ResourceCell.reuseIdentifier)
    }
    
    func getData() -> [SiteInfo] {
        do {
            return try dataPer.loadItems()
        } catch {
            print("couldnt load data \(error)")
        }
        return []
    }
    
    func randomImages() {
        for name in imageNames {
            let img = UIImage(named: name)
            if let image = img {
                imagesArr.append(image)
            }
        }
    }
    
}

extension SavedArticlesController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        cell.colorShadow(for: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1))
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let maxSize: CGSize = UIScreen.main.bounds.size
        let itemWidth: CGFloat = maxSize.width * 0.9
        let itemHeight: CGFloat = maxSize.height * 0.2
        return CGSize(width: itemWidth, height: itemHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 8, left: 0, bottom: 8, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return getData().count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ResourceCell.reuseIdentifier, for: indexPath) as? ResourceCell else {
            fatalError("could not dequeue a LabelCell")
        }
        cell.resourceImage.image = self.imagesArr[indexPath.row % self.imagesArr.count]
        let resource = getData()[indexPath.row]
        cell.configureCell(resource)
        cell.delegate = self
        
        return cell
    }
    
    
}

extension SavedArticlesController: SavedArticleDelegate {
    
    func didSaveArticle(_ cell: UICollectionViewCell, article: SiteInfo) {
    }
    
    
}
