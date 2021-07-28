//
//  Trailer.swift
//  Movie Catalogue SwiftUI
//
//  Created by Jason Prosia on 28/07/21.
//  Copyright © 2021 Jason Dicoding IOS. All rights reserved.
//

import Foundation

struct Trailer: Decodable, Identifiable{
    var id: String
    var key: String
}

struct TrailerList: Decodable{
    var results: [Trailer]
}
