//
//  ViewController.swift
//  QParenting
//
//  Created by Maitree Bain on 9/2/20.
//  Copyright © 2020 Maitree Bain. All rights reserved.
//

import UIKit

class ResourcesViewController: UIViewController {
    
    @IBOutlet var resourceSearchBar: UISearchBar!
    @IBOutlet var resourceCollectionView: UICollectionView!
    
    var resources = [SiteInfo](){
        didSet {
            resourceCollectionView.reloadData()
        }
    }
//empty array rn
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        resourceSearchBar.delegate = self
        resourceCollectionView.dataSource = self
        resourceCollectionView.delegate = self
    }

}

extension ResourcesViewController: UISearchBarDelegate {
    
}


extension ResourcesViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return resources.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "resourceCell", for: indexPath) as? ResourceCell else {
            fatalError("could not dequeue as ResourceCell")
        }
        let resource = resources[indexPath.row]
        
        cell.configureCell(resource)
        
        return cell
    }
    
    
}
