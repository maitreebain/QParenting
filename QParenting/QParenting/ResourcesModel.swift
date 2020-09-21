//
//  ResourcesModel.swift
//  QParenting
//
//  Created by Maitree Bain on 9/6/20.
//  Copyright © 2020 Maitree Bain. All rights reserved.
//

import UIKit

struct Resource: Decodable {
    var resources: [SiteInfo]

//    static let resources = [Resource(date: Date(), link: "https://www.thetrevorproject.org/resources/"),
//                    Resource(date: Date(), link: "https://www.cdc.gov/lgbthealth/youth-resources.htm"),
//                    Resource(date: Date(), link: "https://thesafezoneproject.com/resources/"),
//                    Resource(date: Date(), link: "https://thesafezoneproject.com/resources/"),
//                    Resource(date: Date(), link: "https://www.hopkinsmedicine.org/health/wellness-and-prevention/tips-for-parents-of-lgbtq-youth"),
//                    Resource(date: Date(), link: "https://www.nasponline.org/resources-and-publications/resources-and-podcasts/diversity-and-social-justice/lgbtq-youth/organizations-supporting-lgbtq-youth"),
//
//    ]
}

struct SiteInfo: Decodable {
        let name: String
        let link: String
        let tags: [String]
}
//keywords

//for forums, create a struct with another struct as the comments

//make data into json

extension Resource {
    static func getResources(from data: Data) -> [SiteInfo]{
        
        var links = [SiteInfo]()
        
        do {
            let resources = try JSONDecoder().decode(Resource.self, from: data)
            links = resources.resources
        } catch {
            fatalError("decoding error: \(error)")
        }
        
        return links
    }
}
