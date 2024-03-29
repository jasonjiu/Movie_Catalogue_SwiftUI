//
//  MovieRow.swift
//  Movie Catalogue SwiftUI
//
//  Created by PROSIA on 26/07/21.
//  Copyright © 2020 Jason IOS. All rights reserved.
//
import URLImage
import SwiftUI

struct MovieRow : View {
    var movie: MovieListItem
    
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
                    Text(movie.release_date).foregroundColor(.gray)
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

//extension Float {
//    func format() -> String {
//        return String(format: "%.2f",self)
//    }
//}

