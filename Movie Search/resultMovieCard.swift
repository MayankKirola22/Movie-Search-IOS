import SwiftUI
import Foundation
struct movieCard: View {
    var movie: Movie

    var body: some View {
        HStack{
            VStack(alignment: HorizontalAlignment.leading){
                Text("Title : \(movie.title)")
                Text("Year : \(movie.release_date.count != 0 ? movie.release_date.prefix(4):"Unknown")" )
            }
            Spacer()
            if let realImage = movie.poster_path {
                AsyncImage(url:URL(string: "https://image.tmdb.org/t/p/w500\(realImage)")){
                    result in
                    result.image?
                        .resizable()
                        .scaledToFill()
                }.frame(width: 100,height: 150)
            }
            else{
                AsyncImage(url:URL(string: "https://critics.io/img/movies/poster-placeholder.png")){
                    result in
                    result.image?
                        .resizable()
                        .scaledToFill()
                }.frame(width: 100,height: 150)
            }
        }
    }
    init(_ movie:Movie){
        self.movie = movie
    }
}
