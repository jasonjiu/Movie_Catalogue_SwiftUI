//
//  MovieGenre.swift
//  Movie Catalogue SwiftUI
//
//  Created by Jason Prosia on 26/07/21.
//  Copyright © 2021 Jason IOS. All rights reserved.
//

import Foundation
import Combine
import Alamofire

struct Genre: Decodable, Identifiable {
    var id: Int
    var name: String
}

struct GenreList: Decodable {
    var genres: [Genre]
}
