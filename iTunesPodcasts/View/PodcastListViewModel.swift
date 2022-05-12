//
//  PodcastListViewModel.swift
//  iTunesPodcasts
//
//  Created by Florin Uscatu on 11.05.2022.
//

import Foundation

class PodcastListViewModel {
    
    private var snapshot = PodcastSnapshot()
    
    var dataSource: PodcastDataSource! {
        didSet {
            dataSource.apply(snapshot, animatingDifferences: true)
        }
    }
    
    func getData() {
        snapshot.appendSections([.main])
        snapshot.appendItems([Podcast(artist: "drake", track: "some", releaseDate: "", imageURL: "https://upload.wikimedia.org/wikipedia/en/c/c8/CarterIII.jpg")])
        dataSource.apply(snapshot, animatingDifferences: true)
    }
    
}
