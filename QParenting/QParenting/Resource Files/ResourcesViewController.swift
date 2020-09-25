//
//  ViewController.swift
//  QParenting
//
//  Created by Maitree Bain on 9/2/20.
//  Copyright © 2020 Maitree Bain. All rights reserved.
//

import UIKit
import SafariServices

class ResourcesViewController: UIViewController {
    
    @IBOutlet var resourceCollectionView: UICollectionView!
    
    private var searchController: UISearchController!
    
    var links = "Links"
    var imageNames = ["prideB", "prideC", "prideD"]
    var imagesArr = [UIImage]()
    
    var resources = [SiteInfo]()
    
    var dataSource = [SiteInfo]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        resourceCollectionView.dataSource = self
        resourceCollectionView.delegate = self
        initSearchController()
        fetchResources()
        dataSource = resources
        resourceCollectionView.register(UINib(nibName: "ResourceCell", bundle: nil), forCellWithReuseIdentifier: "resourceCell")
        randomImages()
    }
    
    private func initSearchController() {
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.placeholder = "Search article by name"
        navigationItem.searchController = searchController
        searchController.searchResultsUpdater = self
        searchController.searchBar.autocapitalizationType = .none
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.delegate = self
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
    
    func search(searchText text: String?,searchTag tag: String?) {
        var searchText = text
        if let text = text {
            if text.isEmpty {
                searchText = nil
            }
        }
        dataSource = resources.filter {
            var isMatch = true
            if let text = searchText {
                isMatch = isMatch && $0.name.lowercased().contains(text.lowercased())
            }
            if let tag = tag {
               isMatch = isMatch && $0.tags.contains(tag)
            }
            return isMatch
        }
        
        resourceCollectionView.reloadData()
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

extension ResourcesViewController: UISearchResultsUpdating, UISearchBarDelegate {
    func updateSearchResults(for searchController: UISearchController) {
        
        search(searchText: searchController.searchBar.text, searchTag: nil)
    }
}

extension ResourcesViewController: UISearchControllerDelegate {
    func willDismissSearchController(_ searchController: UISearchController) {
        search(searchText: nil, searchTag: nil)
    }
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
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        
        return CGSize(width: collectionView.bounds.width, height: collectionView.bounds.height * 0.10)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "resourceCell", for: indexPath) as? ResourceCell else {
            fatalError("could not dequeue as ResourceCell")
        }
        let resource = dataSource[indexPath.row]
        if let image = imagesArr.randomElement() {
            cell.resourceImage.image = image
        }
        cell.configureCell(resource)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let resource = dataSource[indexPath.row]
        fetchArticle(for: resource.link)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "resourceHeader", for: indexPath) as? HeaderView else {
            fatalError("could not dequeue a HeaderView")
        }
        
        headerView.configure()
        headerView.delegate = self
        return headerView
    }
    
}

extension ResourcesViewController: HeaderViewDelegate {
    
    func didSelectTag(_ headerView: HeaderView, _ tag: Tag) {
        
    }
    
    
}
