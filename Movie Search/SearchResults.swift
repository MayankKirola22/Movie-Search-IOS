import Foundation

struct MoviesResponse: Decodable{
    let results : [Movie]
}

struct Movie: Decodable,Hashable,Identifiable{
    let id : Int
    let title : String
    let overview : String
    let release_date : String
    let poster_path : String?
}
let apiKey = "094f612c0685c1276a483c23fc2b9735"
func fetchMoviesFromAPI(_ name:String) async throws->[Movie]{
    let url = URL(string: "https://api.themoviedb.org/3/search/movie?query=\(name)&api_key=\(apiKey)")!
    let (data, _) = try await URLSession.shared.data(from: url)
    let decoded = try JSONDecoder().decode(MoviesResponse.self, from: data)
    return decoded.results
}


