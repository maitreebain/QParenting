//
//  ViewController.swift
//  QParenting
//
//  Created by Maitree Bain on 9/2/20.
//  Copyright © 2020 Maitree Bain. All rights reserved.
//

import UIKit
import SafariServices

enum Tags: String, CaseIterable {
    case general = "general"
    case gay = "gay"
    case lesbian = "lesbian"
    case bisexual = "bisexual"
    case transgender = "transgender"
}

class ResourcesViewController: UIViewController {
    
    @IBOutlet var resourceSearchBar: UISearchBar!
    @IBOutlet var resourceCollectionView: UICollectionView!
    
    var links = "Links"
    var imageNames = ["prideB", "prideC", "prideD"]
    var imagesArr = [UIImage]()
    
    var resources = [SiteInfo]() {
        didSet {
            resourceCollectionView.reloadData()
        }
    }
    
    //need to add headerView
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        resourceSearchBar.delegate = self
        resourceCollectionView.dataSource = self
        resourceCollectionView.delegate = self
        fetchResources()
        resourceCollectionView.register(UINib(nibName: "ResourceCell", bundle: nil), forCellWithReuseIdentifier: "resourceCell")
        //        resourceSearchBar.showsScopeBar = true
        //        resourceSearchBar.scopeButtonTitles = Tags.allCases.map { $0.rawValue }
        randomImages()
    }
    
    func fetchResources() {
        resources = [SiteInfo]()
        do {
            resources = try Bundle.main.parseJSON(with: links)
        } catch {
            print("error: \(error)")
        }
    }
    
    func fetchArticle(for link: String) {
        
        if let url = URL(string: link) {
            UIApplication.shared.open(url)
        }
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

extension ResourcesViewController: UISearchBarDelegate {
    
}


extension ResourcesViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let maxSize: CGSize = UIScreen.main.bounds.size
        let spacingBetweenItems: CGFloat = 10
        let numberOfItems: CGFloat = 1
        let itemHeight: CGFloat = maxSize.height * 0.20
        let totalSpacing: CGFloat = (2 * spacingBetweenItems) + (numberOfItems - 1) * spacingBetweenItems
        let itemWidth: CGFloat = (maxSize.width - totalSpacing) / numberOfItems
        return CGSize(width: itemWidth, height: itemHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return resources.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "resourceCell", for: indexPath) as? ResourceCell else {
            fatalError("could not dequeue as ResourceCell")
        }
        let resource = resources[indexPath.row]
        if let image = imagesArr.randomElement() {
            cell.resourceImage.image = image
        }
        cell.configureCell(resource)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let resource = resources[indexPath.row]
        fetchArticle(for: resource.link)
        
    }
    
    
    
}
