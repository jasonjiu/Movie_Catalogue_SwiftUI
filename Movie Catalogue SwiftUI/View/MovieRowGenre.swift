//
//  MovieRowGenre.swift
//  Movie Catalogue SwiftUI
//
//  Created by Jason Prosia on 26/07/21.
//  Copyright © 2021 Jason Dicoding IOS. All rights reserved.
//

import URLImage
import SwiftUI

struct MovieRowGenre : View {
    var movie: Movie
    
    var body: some View {
        HStack {
            URLImage(URL(string:  "\(BASE_IMAGE_URL)\(movie.poster_path)")!, delay: 0.25) { proxy in
                proxy.image.resizable()
                    .frame(width: 90, height: 120)
                
            }
            
            VStack {
                Spacer()
                HStack {
                    Text(movie.title)
                        .foregroundColor(.blue)
                        .lineLimit(nil)
                    Spacer()
                }
                HStack {
                    Text(movie.release_date ?? "Null").foregroundColor(.gray)
                    Spacer()
                    Text("Rate: \(movie.vote_average.format())")
                }
                HStack {
                    Text("Vote count: \(movie.vote_count)")
                        .foregroundColor(.gray)
                        .lineLimit(nil)
                    Spacer()
                }
                HStack {
                    Text("Popularity: \(movie.popularity)")
                        .foregroundColor(.gray)
                        .lineLimit(nil)
                    Spacer()
                }
                Spacer()
            }
        }.frame(height: 130)
    }
}

extension Float {
    func format() -> String {
        return String(format: "%.2f",self)
    }
}


