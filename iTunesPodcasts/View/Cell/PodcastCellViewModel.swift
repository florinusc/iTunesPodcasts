//
//  PodcastCellViewModel.swift
//  iTunesPodcasts
//
//  Created by Florin Uscatu on 11.05.2022.
//

import Foundation

struct PodcastCellViewModel {
    let artistName: String
    let trackName: String
    let imageURL: URL?
    
    init(podcast: Podcast) {
        self.artistName = podcast.artist
        self.trackName = podcast.track
        self.imageURL = URL(string: podcast.imageURL)
    }
}
