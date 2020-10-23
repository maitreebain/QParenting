//
//  SavedArticlesController.swift
//  QParenting
//
//  Created by Maitree Bain on 10/20/20.
//  Copyright © 2020 Maitree Bain. All rights reserved.
//

import UIKit

class SavedArticlesController: UIViewController {
    
    @IBOutlet var savedArticlesCollection: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        savedArticlesCollection.delegate = self
//        savedArticlesCollection.dataSource = self
    }
    
    
}

//extension SavedArticlesController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//    
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//    
//    }
//    
//    
//}
