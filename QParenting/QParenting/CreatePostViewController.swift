//
//  CreatePostViewController.swift
//  QParenting
//
//  Created by Maitree Bain on 9/18/20.
//  Copyright © 2020 Maitree Bain. All rights reserved.
//

import UIKit

class CreatePostViewController: UIViewController {

    @IBOutlet var titleTextField: UITextField!
    @IBOutlet var descriptionTextView: UITextView!
    
    private var user = User()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleTextField.delegate = self
    }
    
    
    @IBAction func cancelActionButtonPressed(_ sender: UIBarButtonItem) {
        dismiss(animated: true)
    }
    
    
    @IBAction func postActionButtonPressed(_ sender: UIBarButtonItem) {
        //titlelabel && description text
        guard let text = titleTextField.text, !text.isEmpty, let descrip = descriptionTextView.text, !descrip.isEmpty else {
            showAlert(title: "Error", message: "Missing Fields")
            return
        }
        
//        var post = Post(author: user.username, title: <#T##String#>, content: <#T##String#>, datePosted: <#T##Date#>, comments: <#T##[Comment]#>)
    }
    
    @IBAction func fileSelectPressed(_ sender: UIButton) {
        
    }
    
}

extension CreatePostViewController: UITextFieldDelegate {
    
}
