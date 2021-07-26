//
//  ContentView.swift
//  Movie Catalogue SwiftUI
//
//  Created by PROSIA on 26/07/21.
//  Copyright © 2020 Jason IOS. All rights reserved.
//

import SwiftUI

struct ContentView : View {
    @ObservedObject var movieManager = MovieManager()
    @ObservedObject var movieGenre = GenreManager()
    var body: some View {
        
        NavigationView {
            VStack {
                ScrollView(.horizontal, showsIndicators: false, content: {
                    HStack(spacing: 15){
                        ForEach(movieGenre.genre.genres, id: \.id){genre in
                            GenreRow(genre: genre).environmentObject(movieGenre)
                        }
                    }
                    .padding(.top, 10)
                })
                .frame(height: 50)
                
                if movieGenre.filterBool == true{
                    List(movieGenre.movies.results) { movie in
                        NavigationLink(destination: MovieDetailGenre(movie: movie)){
                            MovieRowGenre(movie: movie)
                        }
                    }
                }else{
                    List(movieManager)
                    { (movies: MovieListItem) in
                        NavigationLink(destination: MovieDetails(movie: movies)){
                            MovieRow(movie: movies)
                                .onAppear(){
                                    self.movieManager.loadMoreMovies(currentItem: movies)
                                }
                        }
                    }
                }
            }
            .navigationBarTitle(Text("Movies"))
        }
    }
    
    
}

#if DEBUG
struct ContentView_Previews : PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
#endif
