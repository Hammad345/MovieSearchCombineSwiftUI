//
//  NetworkManager.swift
//  MovieSearchCombineSwiftUI
//
//  Created by Hammad on 07/11/2024.
//

import Foundation
import Combine

class NetworkManager {
    static let shared = NetworkManager()
    // api token    
    private let apiKey = "api_key"

    func searchMovies(query: String) -> AnyPublisher<[MovieModel], Error> {
        guard let queryEncoded = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
              let url = URL(string: "https://api.themoviedb.org/3/search/movie?query=\(queryEncoded)&api_key=\(apiKey)") else {
            return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
        }

        return URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: MovieResponse.self, decoder: JSONDecoder())
            .map { $0.results }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}

struct MovieResponse: Codable {
    let results: [MovieModel]
}
