//
//  ContentView.swift
//  MovieSearchCombineSwiftUI
//
//  Created by Hammad on 07/11/2024.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = MovieSearchViewModel()

    var body: some View {
        NavigationView {
            VStack {
                TextField("Search movies...", text: $viewModel.searchText)
                    .padding()
                    .background(Color(.clear))
                    .cornerRadius(8)
                    .padding(.horizontal)
                
                if viewModel.isLoading {
                    ProgressView()
                        .padding()
                }
                List(viewModel.movies) { movie in
                    NavigationLink(destination: MovieDetailView(movie: movie)) {
                        MovieRow(movie: movie)
                    }
                }
                .navigationTitle("Movie Search")

               }
           }
       }
    
//    var body: some View {
//        VStack {
//            Image(systemName: "globe")
//                .imageScale(.large)
//                .foregroundStyle(.tint)
//            Text("Hello, world!")
//        }
//        .padding()
//    }
}


struct MovieRow: View {
    let movie: MovieModel

    var body: some View {
        HStack {
            if let posterURL = movie.posterURL {
                AsyncImage(url: posterURL) { image in
                    image.resizable()
                } placeholder: {
                    Color.gray
                }
                .frame(width: 50, height: 75)
                .cornerRadius(4)
            }

            VStack(alignment: .leading) {
                Text(movie.title)
                    .font(.headline)
                Text(movie.releaseDate ?? "N/A")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                Text(movie.overview)
                    .font(.body)
                    .lineLimit(2)
                    .foregroundColor(.secondary)
            }
        }
        .padding(.vertical, 5)
    }
}
//
//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}


//#Preview {
//    ContentView()
//}
