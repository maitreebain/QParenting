//
//  ForumViewController.swift
//  QParenting
//
//  Created by Maitree Bain on 9/2/20.
//  Copyright © 2020 Maitree Bain. All rights reserved.
//

import UIKit

class ForumViewController: UIViewController {

    @IBOutlet var collectionView: UICollectionView!
    
    var articlePost = [Post]() {
        didSet {
            collectionView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        collectionView.delegate = self
       // articlePost = [Post(author: "random", title: "Title here", content: "content", datePosted: Date(), comments: [])]
        //create posting
    }
    
}

extension ForumViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return articlePost.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "forumCell", for: indexPath) as? ForumCell else {
            fatalError("could not dequeue as forumCell")
        }
        let post = articlePost[indexPath.row]
        cell.configureCell(post)
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let postVC = storyboard?.instantiateViewController(identifier: "PostViewController") as? PostViewController else {
            fatalError("could not segue")
        }
        
        let post = articlePost[indexPath.row]
        postVC.post = post
//        postVC.navigationItem.title = post.title
        navigationController?.pushViewController(postVC, animated: true)
        /*
         let storyBoard = UIStoryboard(name: "MainView", bundle:  nil)
         guard let profVC = storyBoard.instantiateViewController(identifier: "ProfileViewController") as? ProfileViewController else {
             fatalError("could not load ProfileViewController")
         }
         let artist = artists[indexPath.row]
         profVC.expArtist = artist
         profVC.state = .explore
         profVC.navigationItem.title = nil
         profVC.navigationItem.backBarButtonItem?.tintColor = .label
         navigationController?.pushViewController(profVC, animated: true)
         */
    }
    
}
