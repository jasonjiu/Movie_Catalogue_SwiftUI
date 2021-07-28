//
//  GenreNetworkManager.swift
//  Movie Catalogue SwiftUI
//
//  Created by Jason Prosia on 26/07/21.
//  Copyright © 2021 Jason IOS. All rights reserved.
//

import Foundation
import Combine
import Alamofire

public class GenreManager: ObservableObject{
    @Published var genre = GenreList(genres: [])
    @Published var movies = MovieList(results: [])
    @Published var trailers = TrailerList(results: [])
    @Published var review = ReviewList(results: [])
    @Published var filterBool  = false
    private let apiKey = "e657f5965939c3f561350f052abbafec"
    private let apiURL = "https://api.themoviedb.org/3/genre/movie/list?api_key="
    private let apiURLGenreFilter = "https://api.themoviedb.org/3/discover/movie?api_key=e657f5965939c3f561350f052abbafec&with_genres="
    private let movieURL = "https://api.themoviedb.org/3/movie/"
    private let trailerKey = "/videos?api_key="
    private let reviewKey = "/reviews?api_key="
    
    init(){
        loadData()
    }
    
    func loadReview(videoId: Int){
        AF.request(movieURL + String(videoId) + reviewKey + apiKey, method: .get,encoding: JSONEncoding.default).responseJSON{
            response in debugPrint(response)
            switch response.result{
            
            case .success(let data):
                print(data)
                guard let data = response.data else { return }
                let review = try! JSONDecoder().decode(ReviewList.self, from: data)
                DispatchQueue.main.async {
                    self.review = review
                }
                
            case .failure(let err):
                print(err)
            }
        }
    }
    
    func loadTrailer(videoId: Int){
        AF.request(movieURL + String(videoId) + trailerKey + apiKey, method: .get,encoding: JSONEncoding.default).responseJSON{
            response in debugPrint(response)
            switch response.result{
            
            case .success(let data):
                print(data)
                guard let data = response.data else { return }
                let trailer = try! JSONDecoder().decode(TrailerList.self, from: data)
                DispatchQueue.main.async {
                    self.trailers = trailer
                }
                
            case .failure(let err):
                print(err)
            }
        }
    }
    
    func loadGenre(genreId: Int){
        AF.request(apiURLGenreFilter + String(genreId), method: .get,encoding: JSONEncoding.default).responseJSON{
            response in debugPrint(response)
            switch response.result{
            
            case .success(let data):
                print(data)
                guard let data = response.data else { return }
                let movies = try! JSONDecoder().decode(MovieList.self, from: data)
                DispatchQueue.main.async {
                    self.movies = movies
                }
                
            case .failure(let err):
                print(err)
            }
        }
    }
    
    private func loadData(){
        
        AF.request(apiURL+apiKey, method: .get,encoding: JSONEncoding.default).responseJSON{
            response in debugPrint(response)
            switch response.result{
            
            case .success(let data):
                print(data)
                guard let data = response.data else { return }
                let genres = try! JSONDecoder().decode(GenreList.self, from: data)
                DispatchQueue.main.async {
                    self.genre = genres
                }
                
            case .failure(let err):
                print(err)
            }
        }
    }
}
