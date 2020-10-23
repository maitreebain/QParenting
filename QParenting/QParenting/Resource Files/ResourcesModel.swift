//
//  ResourcesModel.swift
//  QParenting
//
//  Created by Maitree Bain on 9/6/20.
//  Copyright © 2020 Maitree Bain. All rights reserved.
//

import UIKit

struct Resource: Codable, Hashable {
    var resources: [SiteInfo]
}

struct SiteInfo: Codable, Hashable {
        let name: String
        let link: String
        let tags: [String]
}

enum BundleError: Error {
 case invalidResource(String)
 case noContents(String)
 case decodingError(Error)
}

extension Bundle {
 func parseJSON(with name: String) throws -> [SiteInfo] {
  guard let path = Bundle.main.path(forResource: name, ofType: ".json") else {
   throw BundleError.invalidResource(name)
  }
  guard let data = FileManager.default.contents(atPath: path) else {
   throw BundleError.noContents(path)
  }
  var links: [SiteInfo]
  do {
    let resources = try JSONDecoder().decode(Resource.self, from: data)
    links = resources.resources
  } catch {
   throw BundleError.decodingError(error)
  }
    return links
 }
}
