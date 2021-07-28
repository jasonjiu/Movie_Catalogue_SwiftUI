//
//  MovieDetailGenre.swift
//  Movie Catalogue SwiftUI
//
//  Created by Jason Prosia on 26/07/21.
//  Copyright © 2021 Jason Dicoding IOS. All rights reserved.
//

import SwiftUI
import URLImage
let BASE_IMAGE_URL2 = "https://image.tmdb.org/t/p/original/"
struct MovieDetailGenre : View {
    var movie: Movie
    @ObservedObject var movieGenre = GenreManager()
  
    var body: some View {
        
        VStack {
            ScrollView(showsIndicators: false){
                URLImage(URL(string:  "\(BASE_IMAGE_URL2)\(movie.poster_path)")!, delay: 0.25) {proxy in
                    proxy.image.resizable()
                        .frame(width: UIScreen.main.bounds.height/8*3, height: UIScreen.main.bounds.height/2)
                    
                }.onAppear(){
                    movieGenre.loadTrailer(videoId: movie.id)
                }
                
                ForEach(movieGenre.trailers.results.prefix(3)){ trailer in
                    VideoView(videoID: trailer.key)
                        .frame(width: UIScreen.main.bounds.height/8*3, height: 250, alignment: .center)
                        .cornerRadius(10)
                        .padding(.horizontal, 20)
                }
                
                HStack {
                    Text("Description").foregroundColor(.gray)
                    Spacer()
                }
                Text(movie.overview).lineLimit(nil)
                Spacer()
            }
        }.navigationBarTitle(Text(movie.title), displayMode: .inline)
        .padding()
    }
}

