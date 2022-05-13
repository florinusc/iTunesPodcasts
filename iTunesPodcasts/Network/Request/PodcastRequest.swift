//
//  PodcastRequest.swift
//  iTunesPodcasts
//
//  Created by Florin Uscatu on 13.05.2022.
//

import Foundation

struct PodcastRequest: Request {
    
    let searchTerm: String
    
    var url: URL? {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "itunes.apple.com"
        
        components.path = "/search"
        let queryItems = [
            URLQueryItem(name: "term", value: searchTerm),
            URLQueryItem(name: "entity", value: "podcast")
        ]
        components.queryItems = queryItems
        
        return components.url
    }
    
}
