//
//  Repository.swift
//  iTunesPodcasts
//
//  Created by Florin Uscatu on 13.05.2022.
//

import Foundation

protocol Repository {
    func getPodcasts(searchTerm: String, completion handler: @escaping (Result<[Podcast], Error>) -> Void)
}
