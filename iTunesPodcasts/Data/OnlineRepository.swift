//
//  OnlineRepository.swift
//  iTunesPodcasts
//
//  Created by Florin Uscatu on 13.05.2022.
//

import Foundation

class OnlineRepository: Repository {
    
    func getPodcasts(searchTerm: String, completion handler: @escaping (Result<[Podcast], Error>) -> Void) {
        SessionManager().request(type: PodcastSearchResultResource.self,
                                 requestType: PodcastRequest(searchTerm: searchTerm)) { result in
            switch result {
            case .failure(let error):
                handler(.failure(error))
            case .success(let resource):
                let podcasts = resource.results.map({ Podcast(resource: $0) })
                handler(.success(podcasts))
            }
        }
    }
    
}
