//
//  SavedArticlesController.swift
//  QParenting
//
//  Created by Maitree Bain on 10/20/20.
//  Copyright © 2020 Maitree Bain. All rights reserved.
//

import UIKit
import DataPersistence

protocol UpdateDelegate: AnyObject {
    func updateUI(_ viewController: SavedArticlesController)
}

class SavedArticlesController: UIViewController {
    
    private var searchController: UISearchController!
    @IBOutlet var savedArticlesCollection: UICollectionView!
    
    private var dataPer = DataPersistence<SiteInfo>(filename: "savedArticles")
    private var imageNames = ["prideB", "prideC", "prideD", "prideE", "prideF"]
    private var imagesArr = [UIImage]()
    
    private var data = [SiteInfo]() {
        didSet {
            DispatchQueue.main.async {
                self.savedArticlesCollection.reloadData()
                
                if self.data.isEmpty {
                    if !self.searchController.isActive {
                    self.savedArticlesCollection.backgroundView = EmptyView(title: "No articles saved", message: "Take a look at resources to save an article")
                    }
                } else {
                    self.savedArticlesCollection.backgroundView = nil
                }
                
            }
        }
        
    }
    
    weak var delegate: UpdateDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        delegate?.updateUI(self)
        data = getData()
        randomImages()
        initSearchController()
        savedArticlesCollection.delegate = self
        savedArticlesCollection.dataSource = self
        savedArticlesCollection.register(UINib(nibName: "ResourceCell", bundle: nil), forCellWithReuseIdentifier: ResourceCell.reuseIdentifier)
    }
    
    private func initSearchController() {
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.placeholder = "Search article by name"
        navigationItem.searchController = searchController
        searchController.searchBar.tintColor = .label
        searchController.searchResultsUpdater = self
        searchController.searchBar.autocapitalizationType = .none
        searchController.delegate = self
    }
    
    private func getData() -> [SiteInfo] {
        do {
            return try dataPer.loadItems()
        } catch {
            print("couldnt load data \(error)")
        }
        return []
    }
    
    private func randomImages() {
        for name in imageNames {
            let img = UIImage(named: name)
            if let image = img {
                imagesArr.append(image)
            }
        }
    }
    
    private func fetchArticle(for link: String) {
        
        if let url = URL(string: link) {
            UIApplication.shared.open(url)
        }
    }
    
    private func searchSavedArticles(_ text: String?) {
        if let text = text, !text.isEmpty {
            data = data.filter {$0.name.lowercased().contains(text)}
        }
        else {
            data = getData()
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
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ResourceCell.reuseIdentifier, for: indexPath) as? ResourceCell else {
            fatalError("could not dequeue a LabelCell")
        }
        cell.resourceImage.image = self.imagesArr[indexPath.row % self.imagesArr.count]
        let resource = data[indexPath.row]
        cell.configureCell(resource)
        cell.delegate = self
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let article = data[indexPath.row]
        fetchArticle(for: article.link)
    }
    
}

extension SavedArticlesController: UISearchResultsUpdating, UISearchBarDelegate {
    
    func updateSearchResults(for searchController: UISearchController) {
        searchSavedArticles(searchController.searchBar.text)
    }
}

extension SavedArticlesController: UISearchControllerDelegate {
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        return true
    }
    
    func willDismissSearchController(_ searchController: UISearchController) {
        searchSavedArticles(searchController.searchBar.text)
    }
    
}

extension SavedArticlesController: SavedArticleDelegate {
    
    func didSaveArticle(_ cell: UICollectionViewCell, article: SiteInfo) {
        
        if dataPer.hasItemBeenSaved(article) {
            print("del")
            guard let index = getData().firstIndex(of: article) else {
                print("could not find article to delete")
                return
            }
            do {
                try dataPer.deleteItem(at: index)
            } catch {
                showAlert(title: "Error deleting", message: "Could not unsave article from saved articles")
            }
        }
        self.delegate?.updateUI(self)
    }
    
    
}

