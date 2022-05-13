//
//  PodcastListViewModel.swift
//  iTunesPodcasts
//
//  Created by Florin Uscatu on 11.05.2022.
//

import Foundation

class PodcastListViewModel {
    
    private let repository: Repository
    private var snapshot = PodcastSnapshot()
    
    var dataSource: PodcastDataSource! {
        didSet {
            dataSource.apply(snapshot, animatingDifferences: true)
        }
    }
    
    init(repository: Repository) {
        self.repository = repository
    }
    
    func getData(searchTerm: String, _ handler: @escaping (Error?) -> Void) {
        snapshot.deleteAllItems()
        repository.getPodcasts(searchTerm: searchTerm) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .failure(let error):
                handler(error)
            case .success(let podcasts):
                self.snapshot.appendSections([.main])
                self.snapshot.appendItems(podcasts)
                self.dataSource.apply(self.snapshot, animatingDifferences: true)
                handler(nil)
            }
        }
    }
    
    func podcastDetailViewModel(at index: Int) -> PodcastDetailViewModel? {
        guard snapshot.itemIdentifiers.count >= 0, index < snapshot.itemIdentifiers.count else { return nil }
        let podcast = snapshot.itemIdentifiers[index]
        return PodcastDetailViewModel(podcast: podcast)
    }
    
}
