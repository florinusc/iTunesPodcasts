//
//  PodcastDetailViewModel.swift
//  iTunesPodcasts
//
//  Created by Florin Uscatu on 12.05.2022.
//

import Foundation

class PodcastDetailViewModel {
    
    private let podcast: Podcast
    
    var imageURL: URL? {
        return URL(string: podcast.imageURL)
    }
    
    var artistName: String {
        return podcast.artist
    }
    
    var trackName: String {
        return podcast.track
    }
    
    var releaseDate: String {
        return podcast.releaseDate
    }
    
    init(podcast: Podcast) {
        self.podcast = podcast
    }
    
}
