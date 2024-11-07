//
//  MovieModel.swift
//  MovieSearchCombineSwiftUI
//
//  Created by Hammad on 07/11/2024.
//

import Foundation

struct MovieModel: Codable, Identifiable {
    let id: Int
    let title: String
    let releaseDate: String?
    let overview: String
    let posterPath: String?

    enum CodingKeys: String, CodingKey {
        case id
        case title
        case releaseDate = "release_date"
        case overview
        case posterPath = "poster_path"
    }

    var posterURL: URL? {
        if let path = posterPath {
            return URL(string: "https://image.tmdb.org/t/p/w200\(path)")
        }
        return nil
    }
}
