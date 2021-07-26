//
//  MovieNetworkManager.swift
//  Movie Catalogue SwiftUI
//
//  Created by Jason Prosia on 26/07/21.
//  Copyright © 2021 Jason IOS. All rights reserved.
//

import Foundation

class MovieManager: ObservableObject, RandomAccessCollection{
    typealias Element = MovieListItem
    @Published  var movieListItems = [MovieListItem]()
    var startIndex: Int {movieListItems.startIndex}
    var endIndex: Int {movieListItems.endIndex}
    var loadStatus = LoadStatus.ready(nextPage: 1)
    
    var apiURL = "https://api.themoviedb.org/3/discover/movie?sort_by=popularity.desc&api_key=e657f5965939c3f561350f052abbafec&page="
    
    init() {
        loadMoreMovies()
    }
    
    subscript(position: Int) -> MovieListItem {
        return movieListItems[position]
    }
    
    func loadMoreMovies(currentItem: MovieListItem? = nil){
        if !shouldLoadMoreData(currentItem: currentItem) {
            return
        }
        guard case let .ready(page) = loadStatus else {
            return
        }
        loadStatus = .loading(page: page)
        let urlString = "\(apiURL)\(page)"
        let url = URL(string: urlString)!
        let task = URLSession.shared.dataTask(with: url, completionHandler: parseMovieFromResponses(data:responses:error:))
        task.resume()
    }
    
    func shouldLoadMoreData(currentItem: MovieListItem? = nil) -> Bool{
        guard let currentItem = currentItem else {
            return true
        }
        
        for n in (movieListItems.count - 4)...(movieListItems.count-1) {
            if n >= 0 && currentItem.uuid == movieListItems[n].uuid {
                return true
            }
        }
        return false
    }
    
    func parseMovieFromResponses(data: Data?, responses: URLResponse?, error: Error?){
        guard error == nil else{
            print("Error: \(error)")
            loadStatus = .parseError
            return
        }
        
        guard let data = data else{
            print("Tidak ada data")
            loadStatus = .parseError
            return
        }
        
        let newMovies = parseMovieFromData(data: data)
        DispatchQueue.main.async {
            self.movieListItems.append(contentsOf: newMovies)
            if newMovies.count == 0 {
                self.loadStatus = .done
            } else {
                guard case let .loading(page) = self.loadStatus else {
                    fatalError("Bad state load")
                }
                self.loadStatus = .ready(nextPage: page + 2)
            }
        }
        
    }
    
    func parseMovieFromData(data: Data) -> [MovieListItem]{
        var response: MovieAPIResponse
        do {
            response = try JSONDecoder().decode(MovieAPIResponse.self, from: data)
        } catch {
            print("Error parsing the JSON: \(error)")
            return []
        }
        
        return response.results ?? []
    }
    
    enum LoadStatus {
        case ready (nextPage: Int)
        case loading (page: Int)
        case parseError
        case done
    }
}

class MovieAPIResponse: Codable {
    var results: [MovieListItem]?
}

class MovieListItem: Identifiable, Codable {
    var uuid = UUID()
    
    var popularity: Float
    var vote_count: Int
    var id: Int
    var vote_average: Float
    var title: String
    var poster_path: String
    var original_language: String
    var original_title: String
    var adult: Bool
    var overview: String
    var release_date: String
    
    enum CodingKeys: String, CodingKey {
        case popularity, vote_count, id, vote_average, title, poster_path, original_language, original_title, adult, overview, release_date
    }
}
