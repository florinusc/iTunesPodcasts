//
//  PodcastSearchResultResource.swift
//  iTunesPodcasts
//
//  Created by Florin Uscatu on 13.05.2022.
//

import Foundation

struct PodcastSearchResultResource: Decodable {
    let results: [PodcastResource]
}
