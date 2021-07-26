//
//  GenreRow.swift
//  Movie Catalogue SwiftUI
//
//  Created by Jason Prosia on 26/07/21.
//  Copyright © 2021 Jason Dicoding IOS. All rights reserved.
//

import SwiftUI

struct GenreRow: View {
    var genre: Genre
    @EnvironmentObject var filter: GenreManager
    
    var body: some View {
        
        HStack{
            Button(action: {
                filter.loadGenre(genreId: genre.id)
                filter.filterBool = true
            }, label: {
                Text(genre.name)
            })
        }.padding(10)
        
    }
    }

struct GenreRow_Previews: PreviewProvider {
    static var previews: some View {
        GenreRow(genre: Genre.init(id: 53, name: "Thriller"))
            .previewLayout(.sizeThatFits)
    }
}
