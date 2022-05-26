//
//  OnlineRepository.swift
//  iTunesPodcasts
//
//  Created by Florin Uscatu on 13.05.2022.
//

import Foundation
import RxSwift

class OnlineRepository: Repository {
    
    func getPodcasts(searchTerm: String) -> Single<[Podcast]> {
        return SessionManager().request(type: PodcastSearchResultResource.self,
                                        requestType: PodcastRequest(searchTerm: searchTerm))
        .map({ $0.results.map { Podcast(resource: $0) } })
    }
    
}
