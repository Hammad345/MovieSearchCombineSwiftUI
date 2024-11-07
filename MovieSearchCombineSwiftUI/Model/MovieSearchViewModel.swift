//
//  MovieSearchViewModel.swift
//  MovieSearchCombineSwiftUI
//
//  Created by Hammad on 07/11/2024.
//

import Foundation
import Combine

class MovieSearchViewModel: ObservableObject {
    @Published var searchText = ""
    @Published var movies: [MovieModel] = []
    @Published var isLoading = false
    private var cancellables = Set<AnyCancellable>()

    init() {
        $searchText
            .debounce(for: .milliseconds(500), scheduler: DispatchQueue.main)
            .removeDuplicates()
            .flatMap { query -> AnyPublisher<[MovieModel], Never> in
                guard !query.isEmpty else { return Just([]).eraseToAnyPublisher() }
                self.isLoading = true
                return NetworkManager.shared.searchMovies(query: query)
                    .catch { _ in Just([]) }
                    .eraseToAnyPublisher()
            }
            .sink { [weak self] movies in
                self?.movies = movies
                self?.isLoading = false
            }
            .store(in: &cancellables)
    }
}
