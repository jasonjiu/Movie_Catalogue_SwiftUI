//
//  ContentView.swift
//  Movie Catalogue SwiftUI
//
//  Created by PROSIA on 02/09/20.
//  Copyright © 2020 Jason Dicoding IOS. All rights reserved.
//

import SwiftUI

struct ContentView : View {
    @ObservedObject var networkManager = NetworkManager()
    var body: some View {
        NavigationView {
            VStack {
                if networkManager.loading {
                    Text("Loading ...")
                } else {
                    List(networkManager.movies.results) { movie in
                        NavigationLink(destination: MovieDetails(movie: movie)){
                            MovieRow(movie: movie)
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
