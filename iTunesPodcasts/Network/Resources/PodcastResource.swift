//
//  PodcastResource.swift
//  iTunesPodcasts
//
//  Created by Florin Uscatu on 13.05.2022.
//

import Foundation

struct PodcastResource: Decodable {
    let artistName: String
    let trackName: String
    let artworkURL: String
    let releaseDate: String
    
    enum CodingKeys: String, CodingKey {
        case artistName, trackName, releaseDate
        case artworkURL = "artworkUrl100"
    }
}
