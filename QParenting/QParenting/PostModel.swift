//
//  PostModel.swift
//  QParenting
//
//  Created by Maitree Bain on 9/8/20.
//  Copyright © 2020 Maitree Bain. All rights reserved.
//

import Foundation

struct Post {
    let author: String
    let title: String
    let content: String
    let datePosted: Date
    let comments: [Comment]
}
