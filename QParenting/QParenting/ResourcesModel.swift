//
//  ResourcesModel.swift
//  QParenting
//
//  Created by Maitree Bain on 9/6/20.
//  Copyright © 2020 Maitree Bain. All rights reserved.
//

import UIKit

struct Resources {
    let date: Date
    let link: String

    static let resources = [Resources(date: Date(), link: "https://www.thetrevorproject.org/resources/"),
                    Resources(date: Date(), link: "https://www.cdc.gov/lgbthealth/youth-resources.htm"),
                    Resources(date: Date(), link: "https://thesafezoneproject.com/resources/"),
                    Resources(date: Date(), link: "https://thesafezoneproject.com/resources/"),
                    Resources(date: Date(), link: "https://www.hopkinsmedicine.org/health/wellness-and-prevention/tips-for-parents-of-lgbtq-youth"),
                    Resources(date: Date(), link: "https://www.nasponline.org/resources-and-publications/resources-and-podcasts/diversity-and-social-justice/lgbtq-youth/organizations-supporting-lgbtq-youth"),
                    
    ]
}

//for forums, create a struct with another struct as the comments
