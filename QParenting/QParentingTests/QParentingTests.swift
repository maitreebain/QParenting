//
//  QParentingTests.swift
//  QParentingTests
//
//  Created by Maitree Bain on 9/2/20.
//  Copyright © 2020 Maitree Bain. All rights reserved.
//

import XCTest
import DataPersistence
@testable import QParenting

class QParentingTests: XCTestCase {
    
    //test json data
    //test data persistence article count
    //test resource model?
    
    func testJSONDataCount() {
        //count test
        let jsonData = """
{
    "resources": [{
            "name": "A GUIDE TO BEING AN ALLY TO TRANSGENDER AND NONBINARY YOUTH",
            "link": "https://www.thetrevorproject.org/resources/trevor-support-center/a-guide-to-being-an-ally-to-transgender-and-nonbinary-youth/",
            "tags": ["Transgender", "Non-Binary"]
        },
        {
            "name": "HOW TO SUPPORT BISEXUAL YOUTH",
            "link": "https://www.thetrevorproject.org/resources/how-to-support-bisexual-youth/",
            "tags": ["Bisexual"]

        }
    ]
}
""".data(using: .utf8)!
        
        let expectedItems = 2
        
        do {
            let results = try JSONDecoder().decode(Resource.self, from: jsonData)
            let items = results.resources
            XCTAssertEqual(items.count, expectedItems)
        } catch {
            XCTFail("decoding error: \(error)")
        }
        
    }
    
    func testURL() {
        
        do {
            let data = try Bundle.main.parseJSON(with: "Links")
            let firstLink = data.first?.link
            if let link = firstLink, let url = URL(string: link) {
                //testing if url can be opened
                XCTAssert(UIApplication.shared.canOpenURL(url))
            }
        } catch {
            XCTFail("failed to open link: \(error)")
        }
    }
    
    func testLink() {
        let expectedLink = "https://www.thetrevorproject.org/resources/trevor-support-center/a-guide-to-being-an-ally-to-transgender-and-nonbinary-youth/"
        
        do {
            let data = try Bundle.main.parseJSON(with: "Links")
            let firstLink = data.first?.link
            if let link = firstLink {
                XCTAssertEqual(link, expectedLink)
            }
        } catch {
            XCTFail("links are not the same: \(error)")
        }
    }
    
//    func testSavedArticles() {
//        let dataPer = DataPersistence<SiteInfo>(filename: "savedArticles")
//
//        do {
//            let data = try Bundle.main.parseJSON(with: "Links")
//            if let first = data.first {
//            try dataPer.createItem(first)
//            }
//        } catch {
//            XCTFail("failed to open link: \(error)")
//        }
//    }


}
