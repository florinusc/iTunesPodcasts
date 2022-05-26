//
//  PodcastListViewModel.swift
//  iTunesPodcasts
//
//  Created by Florin Uscatu on 11.05.2022.
//

import Foundation
import RxSwift
import RxCocoa

class PodcastListViewModel {
    
    let searchTermRelay = BehaviorRelay<String?>(value: nil)
    let searchRelay = PublishRelay<Void>()
    
    private let repository: Repository
    private var snapshot = PodcastSnapshot()
    private let disposeBag = DisposeBag()
    
    private let _isLoading = BehaviorRelay<Bool>(value: false)
    private let _error = BehaviorRelay<Error?>(value: nil)
    
    var isLoading: Driver<Bool> {
        return _isLoading.asDriver()
    }
    
    var error: Driver<Error?> {
        return _error.asDriver()
    }
    
    var dataSource: PodcastDataSource! {
        didSet {
            dataSource.apply(snapshot, animatingDifferences: true)
        }
    }
    
    init(repository: Repository) {
        self.repository = repository
        searchRelay.subscribe { [weak self] _ in
            guard let self = self,
                  let searchTerm = self.searchTermRelay.value else { return }
            self._isLoading.accept(true)
            self.getData(searchTerm: searchTerm) { error in
                self._isLoading.accept(false)
                self._error.accept(error)
            }
        }
        .disposed(by: disposeBag)
    }
    
    private func getData(searchTerm: String, _ handler: @escaping (Error?) -> Void) {
        snapshot.deleteAllItems()
        repository.getPodcasts(searchTerm: searchTerm)
            .subscribe { result in
                switch result {
                case .success(let podcasts):
                    self.snapshot.appendSections([.main])
                    self.snapshot.appendItems(podcasts)
                    self.dataSource.apply(self.snapshot, animatingDifferences: true)
                    handler(nil)
                case .failure(let error):
                    handler(error)
                }
            }
            .disposed(by: disposeBag)
    }
    
    func podcastDetailViewModel(at index: Int) -> PodcastDetailViewModel? {
        guard snapshot.itemIdentifiers.count >= 0, index < snapshot.itemIdentifiers.count else { return nil }
        let podcast = snapshot.itemIdentifiers[index]
        return PodcastDetailViewModel(podcast: podcast)
    }
    
}
