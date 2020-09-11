//
//  PostViewController.swift
//  QParenting
//
//  Created by Maitree Bain on 9/8/20.
//  Copyright © 2020 Maitree Bain. All rights reserved.
//

import UIKit

class PostViewController: UIViewController {

    @IBOutlet var contentLabel: UILabel!
    @IBOutlet var commentTextField: UITextField!
    @IBOutlet var enterButton: UIButton!
    @IBOutlet var commentLabel: UILabel!
    
    var post: Post?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        commentTextField.delegate = self
        guard let post = post else { return }
        navigationItem.title = post.title
        contentLabel.text = post.content
        commentLabel.text = post.comments.first?.comment
    }
    

    @IBAction func enterButtonPressed(_ sender: UIButton) {
        
    }
    
}

extension PostViewController: UITextFieldDelegate {
    
    
}
