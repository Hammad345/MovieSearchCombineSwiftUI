//
//  MovieDetailView.swift
//  MovieSearchCombineSwiftUI
//
//  Created by Hammad on 07/11/2024.
//

import Foundation
import SwiftUI

struct MovieDetailView: View {
    let movie: MovieModel

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                if let posterURL = movie.posterURL {
                    AsyncImage(url: posterURL) { image in
                        image.resizable()
                            .scaledToFit()
                    } placeholder: {
                        Color.gray
                    }
                    .frame(maxWidth: .infinity)
                }

                Text(movie.title)
                    .font(.largeTitle)
                    .fontWeight(.bold)

                Text("Release Date: \(movie.releaseDate ?? "N/A")")
                    .font(.subheadline)
                    .foregroundColor(.secondary)

                Divider()

                Text(movie.overview)
                    .font(.body)
                    .padding(.bottom, 20)

                Spacer()
            }
            .padding()
            .navigationTitle("Movie Details")
        }
    }
}
