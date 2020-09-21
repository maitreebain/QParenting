//
//  CreatePostViewController.swift
//  QParenting
//
//  Created by Maitree Bain on 9/18/20.
//  Copyright © 2020 Maitree Bain. All rights reserved.
//

import UIKit

class CreatePostViewController: UIViewController {

    @IBOutlet var titleLabel: UITextField!
    @IBOutlet var descriptionTextView: UITextView!
    
    private var user = User()
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    
    @IBAction func cancelActionButtonPressed(_ sender: UIBarButtonItem) {
        dismiss(animated: true)
    }
    
    
    @IBAction func postActionButtonPressed(_ sender: UIBarButtonItem) {
        //titlelabel && description text
        
//        var post = Post(author: user.username, title: <#T##String#>, content: <#T##String#>, datePosted: <#T##Date#>, comments: <#T##[Comment]#>)
    }
    
    
}
