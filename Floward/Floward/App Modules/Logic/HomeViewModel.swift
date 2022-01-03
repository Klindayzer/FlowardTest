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
            movies = model?.convert() ?? []
        }
    }
    
    var currentPage = 1
    var itemsCount: Int {
        movies.count
    }
    
    // MARK: - Constructors
    init(apiClient: AKClientContractor = AKApiClient()) {
        self.apiClient = apiClient
    }

    // MARK: - Exposed Methods
    func fetchHomeData(term: String, callback: @escaping APICallback) {
        
        let api = HomeApi(term: term, page: currentPage)
        apiClient.request(buildable: api, type: HomeResult.self) { [weak self] result in
            
            switch result {
            case .success(let model):
                self?.model = model
                callback(true, .empty)
                
            case .failure(let serviceError):
                callback(false, serviceError.error)
            }
        }
    }
    
    func item(at index: Int) -> MoviePresentable? {
        movies[safe: index]
    }
}
