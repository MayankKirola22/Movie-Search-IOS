//
//  ContentView.swift
//  Movie Search
//
//  Created by May 2003 on 17/06/24.
//

import SwiftUI

struct ContentView: View {
    @State private var searchString: String = ""
    @State private var results : [Movie]?
    @State private var selectedMovie: Movie?
    
    var body: some View {
        NavigationStack(){
            VStack(){
                HStack(){
                    TextField(
                        "Search",
                        text: $searchString
                    ).textFieldStyle(.roundedBorder)
                        .onSubmit {
                            search()
                        }
                        .textInputAutocapitalization(.never)
                        .disableAutocorrection(true)
                    
                    Button(action: search) {
                        Text("Search")
                    }.buttonStyle(.bordered)
                }.padding(30)
                Divider().background(Color.black).padding(.horizontal,30)
                List{
                    if let realResults = results {
                        ForEach(realResults,id:\.self){ movie in
                            movieCard(movie).onTapGesture {
                                selectedMovie = movie
                            }
                        }
                    }
                }
                Spacer()
            }.navigationTitle("Movie Search").navigationBarTitleDisplayMode(.inline).sheet(item: $selectedMovie) { movie in
                NavigationStack(){
                    WebView(url: URL(string: "https://www.themoviedb.org/movie/\(movie.id)")!)
                        .ignoresSafeArea()
                        .navigationTitle(movie.title)
                        .navigationBarTitleDisplayMode(.inline)
                }
            }
        }

    }
    func search() {
        Task {
            do {
                let movies = try await fetchMoviesFromAPI(searchString)
                results = movies
            } catch {
                print(error)
            }
        }
    }
}

#Preview {
    ContentView()
}
