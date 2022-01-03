/*
 *	HomeViewModel.swift
 *	Floward
 *
 *	Created by Klindayzer on 03/01/2022.
 *	Copyright 2022 ___ORGANIZATIONNAME___. All rights reserved.
 */

import AKNetworking

final class HomeViewModel {
    
    // MARK: - Properties
    private let apiClient: AKClientContractor
    private var movies = [MoviePresentable]()
    private var model: HomeResult? {
        didSet {
            totalResults = Int(model?.totalResults ?? "0") ?? 0
        }
    }
    private var totalResults = 0
    var currentPage = 1
    var itemsCount: Int {
        movies.count
    }
    
    var shouldLoadMore: Bool {        
        itemsCount < totalResults
    }
    
    // MARK: - Constructors
    init(apiClient: AKClientContractor = AKApiClient()) {
        self.apiClient = apiClient
    }
    
    // MARK: - Exposed Methods
    func search(for term: String, callback: @escaping APICallback) {
        
        let api = HomeApi(term: term, page: currentPage)
        apiClient.request(buildable: api, type: HomeResult.self) { [weak self] result in
            
            switch result {
            case .success(let model):
                self?.handleSuccessResponse(model)
                callback(true, .empty)
                
            case .failure(let serviceError):
                callback(false, serviceError.error)
            }
        }
    }
    
    func item(at index: Int) -> MoviePresentable? {
        movies[safe: index]
    }
    
    func validateSearchTerm(_ term: String?) -> String? {
        
        guard let term = term?.trimmingCharacters(in: .whitespacesAndNewlines),
              !term.isEmpty else { return nil }
        return term
    }
    
    // MARK: - Protucted Methods
    func handleSuccessResponse(_ model: HomeResult) {
        
        self.model = model
        let movies = model.convert()
        if currentPage == 1 {
            self.movies = movies
            
        } else {
            self.movies.append(contentsOf: movies)
        }
    }
}
