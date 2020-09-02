import Foundation
import Combine
import Alamofire

public class NetworkManager: ObservableObject{
    @Published var movies = MovieList(results: [])
    @Published var loading = false
    private let apiKey = "e657f5965939c3f561350f052abbafec"
    private let apiURL = "https://api.themoviedb.org/3/discover/movie?sort_by=popularity.desc&api_key="
    
    init(){
        loading = true
        loadData()
    }
    
    private func loadData(){
  
        AF.request(apiURL+apiKey, method: .get,encoding: JSONEncoding.default).responseJSON{
            response in debugPrint(response)
            switch response.result{
                
            case .success(let data):
                print(data)
                guard let data = response.data else { return }
                let movies = try! JSONDecoder().decode(MovieList.self, from: data)
                DispatchQueue.main.async {
                    self.movies = movies
                    self.loading = false
                }
                
            case .failure(let err):
                print(err)
            }
        }
    }
}
