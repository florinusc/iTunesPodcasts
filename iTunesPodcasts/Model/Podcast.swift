//
//  Podcast.swift
//  iTunesPodcasts
//
//  Created by Florin Uscatu on 11.05.2022.
//

import Foundation

struct Podcast: Hashable {
    let artist: String
    let track: String
    let releaseDate: String
    let imageURL: String
}

extension Podcast {
    init(resource: PodcastResource) {
        self.artist = resource.artistName
        self.track = resource.trackName
        self.imageURL = resource.artworkURL
        self.releaseDate = resource.releaseDate
    }
}
