/*
 *	MoviePresentable.swift
 *	Floward
 *
 *	Created by Klindayzer on 03/01/2022.
 *	Copyright 2022 ___ORGANIZATIONNAME___. All rights reserved.
 */

struct MoviePresentable {
    
    let poster: String
    let title: String
}

protocol MovieConverter {
    func convert() -> [MoviePresentable]
}

extension MovieConverter where Self == HomeResult {
    
    func convert() -> [MoviePresentable] {
        
        guard let movies = self.movies, !movies.isEmpty else { return [] }
        return movies.compactMap {
            
            guard let title = $0.title,
                  let poster = $0.poster else { return nil }
            
            return MoviePresentable(poster: poster, title: title)
        }
    }
}
