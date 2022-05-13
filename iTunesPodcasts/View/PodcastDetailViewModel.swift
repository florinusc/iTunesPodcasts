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
    
    var releaseDate: String? {
        let df = DateFormatter()
        df.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        let date = df.date(from: podcast.releaseDate)
        return date?.formatted(date: .abbreviated, time: .shortened)
    }
    
    init(podcast: Podcast) {
        self.podcast = podcast
    }
    
}
