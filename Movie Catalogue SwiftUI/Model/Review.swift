//
//  Review.swift
//  Movie Catalogue SwiftUI
//
//  Created by Jason Prosia on 28/07/21.
//  Copyright © 2021 Jason Dicoding IOS. All rights reserved.
//

import Foundation

struct Review: Decodable, Identifiable{
    var author: String
    var id: String
    var content: String
}

struct ReviewList: Decodable{
    var results: [Review]
}
