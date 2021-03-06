//
//  ViewController.swift
//  QParenting
//
//  Created by Maitree Bain on 9/2/20.
//  Copyright © 2020 Maitree Bain. All rights reserved.
//

import UIKit
import SafariServices
import DataPersistence

enum Tag: String, CaseIterable {
    case all = "All"
    case general = "General"
    case gay = "Gay"
    case lesbian = "Lesbian"
    case bisexual = "Bisexual"
    case transgender = "Transgender"
}

enum SectionKind: Int, CaseIterable {
    case tag, article
    
    var orthogonalBehaviour: UICollectionLayoutSectionOrthogonalScrollingBehavior {
        switch self {
        case .tag:
            return .continuous
        case .article:
            return .none        }
    }
    
}

class ResourcesViewController: UIViewController, UICollectionViewDelegate {
    
    private var resourceCollectionView: UICollectionView!
    
    private var searchController: UISearchController!
    
    typealias DataSource = UICollectionViewDiffableDataSource<SectionKind, AnyHashable>
    var snapshot = NSDiffableDataSourceSnapshot<SectionKind, AnyHashable>()
    private var dataSource: DataSource!
    private var dataPersistence = DataPersistence<SiteInfo>(filename: "savedArticles")
    
    var links = "Links"
    var imageNames = ["prideB", "prideC", "prideD", "prideE", "prideF"]
    var imagesArr = [UIImage]()
    
    var resources = [SiteInfo]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        randomImages()
        resources = fetchResources()
        configureCollectionView()
        configureDataSource()
        initSearchController()
    }
    
    private func configureCollectionView() {
        resourceCollectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createLayout())
        resourceCollectionView.register(TagCell.self, forCellWithReuseIdentifier: TagCell.reuseIdentifier)
        resourceCollectionView.register(UINib(nibName: "ResourceCell", bundle: nil), forCellWithReuseIdentifier: ResourceCell.reuseIdentifier)
        resourceCollectionView.backgroundColor = .systemBackground
        resourceCollectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        resourceCollectionView.delegate = self
        view.addSubview(resourceCollectionView)
    }
    
    private func initSearchController() {
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.placeholder = "Search article by name"
        navigationItem.searchController = searchController
        searchController.searchBar.tintColor = .label
        searchController.searchResultsUpdater = self
        searchController.searchBar.autocapitalizationType = .none
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.delegate = self
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let navController = segue.destination as? UINavigationController, let savedArticleVC = navController.viewControllers.first as? SavedArticlesController else { return }
        savedArticleVC.delegate = self
    }
    
    private func createLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { (sectionIndex, layoutEnvironment) -> NSCollectionLayoutSection? in
            
            guard let sectionType = SectionKind(rawValue: sectionIndex) else {
                fatalError("could not get a section")
            }
            
            let itemWidth: NSCollectionLayoutDimension = sectionIndex == 0 ? .estimated(80) : .fractionalWidth(1.0)
            let itemSize = NSCollectionLayoutSize(widthDimension: itemWidth, heightDimension: .fractionalHeight(1.0))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            if sectionType == .tag {
                item.edgeSpacing = NSCollectionLayoutEdgeSpacing(leading: .fixed(8), top: .fixed(12), trailing: .fixed(8), bottom: .fixed(8))
            } else {
                let spacing: CGFloat = 10
                item.contentInsets = NSDirectionalEdgeInsets(top: spacing, leading: spacing, bottom: spacing, trailing: spacing)
            }
            
            let groupWidth: NSCollectionLayoutDimension = sectionIndex == 0 ? .estimated(100) : .fractionalWidth(1.0)
            let groupHeight = sectionIndex == 0 ? NSCollectionLayoutDimension.absolute(44) : NSCollectionLayoutDimension.fractionalWidth(0.50)
            
            let groupSize = NSCollectionLayoutSize(widthDimension: groupWidth, heightDimension: groupHeight)
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
            
            let section = NSCollectionLayoutSection(group: group)
            section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 5, bottom: 5, trailing: 5)
            
            section.orthogonalScrollingBehavior = sectionType.orthogonalBehaviour
            
            return section
        }
        return layout
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.section == 1 {
            cell.colorShadow(for: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1))
        }
    }
    
    private func configureDataSource() {
        dataSource = DataSource(collectionView: resourceCollectionView, cellProvider: { [weak self] (collectionView, indexPath, article) -> UICollectionViewCell? in
            guard let self = self else { return nil}
            if indexPath.section == 0 {
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TagCell.reuseIdentifier, for: indexPath) as? TagCell else {
                    fatalError("could not dequeue a TagCell")
                }
                cell.tagLabel.text = "\(article)".capitalized
                return cell
            } else {
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ResourceCell.reuseIdentifier, for: indexPath) as? ResourceCell else {
                    fatalError("could not dequeue a LabelCell")
                }
                cell.resourceImage.image = self.imagesArr[indexPath.row % self.imagesArr.count]
                cell.configureCell(article as! SiteInfo)
                cell.delegate = self
                
                return cell
            }
        })
        snapshot.deleteAllItems()
        snapshot.appendSections([.tag, .article])
        
        let tags: [Tag] = Tag.allCases
        
        let articles: [SiteInfo] = fetchResources()
        snapshot.appendItems(tags, toSection: .tag)
        snapshot.appendItems(articles, toSection: .article)
        dataSource.apply(snapshot, animatingDifferences: false)
        
        
        //        dataSource.supplementaryViewProvider = { (collectionView, kind, indexPath) in
        //          guard let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: HeaderView.reuseIdentifier, for: indexPath) as? HeaderView else {
        //            fatalError()
        //          }
        //          return headerView
        //        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if indexPath.section == 0 {
            let tags = Tag.allCases
            search(searchText: nil, searchTag: tags[indexPath.row].rawValue)
        } else {
            let resource = resources[indexPath.row]
            fetchArticle(for: resource.link)
        }
        
    }
    
    
    func fetchResources() -> [SiteInfo]{
        resources = [SiteInfo]()
        do {
            resources = try Bundle.main.parseJSON(with: links)
            return resources
        } catch {
            print("error: \(error)")
        }
        return resources
    }
    
    func fetchArticle(for link: String) {
        
        if let url = URL(string: link) {
            UIApplication.shared.open(url)
        }
    }
    
    func search(searchText text: String?,searchTag tag: String?) {
        var articles = [SiteInfo]()
        
        
        if let searchText = text {
            guard !searchText.isEmpty else { return }
            articles = resources.filter { $0.name.lowercased().contains(searchText)}
        } else if let tag = tag {
            if tag == "All" { articles = fetchResources() }
            else {
                articles = Array(Set(resources.filter { $0.tags.contains(tag) }))
            }
        } else {
            articles = fetchResources()
        }
        
        snapshot.deleteAllItems()
        snapshot.appendSections([.tag, .article])
        let tags: [Tag] = Tag.allCases
        snapshot.appendItems(tags, toSection: .tag)
        snapshot.appendItems(articles, toSection: .article)
        dataSource.apply(snapshot, animatingDifferences: false)
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
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        return true
    }
    
    func willDismissSearchController(_ searchController: UISearchController) {
        search(searchText: nil, searchTag: nil)
    }
    
}

extension ResourcesViewController: SavedArticleDelegate {
    
    func didSaveArticle(_ cell: UICollectionViewCell, article: SiteInfo) {
        
        if dataPersistence.hasItemBeenSaved(article) {
            guard let index = try? dataPersistence.loadItems().firstIndex(of: article) else {
                print("could not find article to delete")
                return
            }
            do {
                try dataPersistence.deleteItem(at: index)
            } catch {
                showAlert(title: "Error deleting", message: "Could not unsave article from saved articles")
            }
        } else {
            do {
                try dataPersistence.createItem(article)
            } catch {
                showAlert(title: "Error saving", message: "Could not save article")
            }
        }
    }
    
}

extension ResourcesViewController: UpdateDelegate {
    
    func updateUI(_ viewController: SavedArticlesController) {
        snapshot.reloadSections([.article])
        dataSource.apply(snapshot)
    }
    
}


//
//    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
//        guard let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "resourceHeader", for: indexPath) as? HeaderView else {
//            fatalError("could not dequeue a HeaderView")
//        }
//        headerView.configure()
//        headerView.delegate = self
//        return headerView
//    }
//
//}
