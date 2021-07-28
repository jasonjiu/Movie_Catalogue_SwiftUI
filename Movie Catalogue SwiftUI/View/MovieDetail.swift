//
//  MovieDetail.swift
//  Movie Catalogue SwiftUI
//
//  Created by PROSIA on 26/07/21.
//  Copyright © 2020 Jason IOS. All rights reserved.
//

import SwiftUI
import URLImage
let BASE_IMAGE_URL = "https://image.tmdb.org/t/p/original/"

extension Color{
    static let ui = Color.UI()
    struct UI {
        let blue = Color("ColorBlueberryDark")
        let yellow = Color("ColorGrapefruitDark")
    }
}

struct MovieDetails : View {
    var movie: MovieListItem
    @ObservedObject var movieGenre = GenreManager()
    
    var body: some View {
        VStack {
            ScrollView(showsIndicators: false){
                URLImage(URL(string:"\(BASE_IMAGE_URL)\(movie.poster_path)")!, delay: 0.25) {proxy in
                    proxy.image.resizable()
                        
                        .frame(width: UIScreen.main.bounds.height/8*3, height: UIScreen.main.bounds.height/2)
                }.onAppear(){
                    movieGenre.loadTrailer(videoId: movie.id)
                    movieGenre.loadReview(videoId: movie.id)
                }
                
                ForEach(movieGenre.trailers.results.prefix(3)){ trailer in
                    VideoView(videoID: trailer.key)
                        .frame(width: UIScreen.main.bounds.height/8*3, height: 250, alignment: .center)
                        .cornerRadius(10)
                        .padding(.horizontal, 20)
                }
                
                HStack {
                    Text("Description")
                        .foregroundColor(Color.ui.blue)
                        .fontWeight(.bold)
                    Spacer()
                }.padding(20)
                
                GroupBox{
                    Text(movie.overview).lineLimit(nil)
                }
                Spacer()
                
                
                HStack{
                    Text("Review")
                        .foregroundColor(Color.ui.blue)
                        .fontWeight(.bold)
                    Spacer()
                }.padding(20)
                
                
                ForEach(movieGenre.review.results){ review in
                    VStack(alignment: .leading, spacing: 5){
                        GroupBox{
                            Text("Author: " + review.author).padding(.bottom, 20).foregroundColor(Color.ui.yellow)
                            Text(review.content).lineLimit(nil)
                        }
                    }
                }
                
            }
        }.navigationBarTitle(Text(movie.title), displayMode: .inline)
        .padding()
        
    }
}
