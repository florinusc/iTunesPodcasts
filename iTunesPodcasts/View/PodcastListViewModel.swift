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
    
    private let repository: Repository
    private let disposeBag = DisposeBag()
    
    private let _isLoading = BehaviorRelay<Bool>(value: false)
    private let _error = PublishRelay<Error>()
    
    private let _state = BehaviorRelay<Loadable<[Podcast]>>(value: .notRequested)
    
    var state: Driver<Loadable<[Podcast]>> {
        return _state.asDriver()
    }
    
    init(repository: Repository) {
        self.repository = repository
    }
    
    func getData(searchTerm: String) {
        _state.accept(.isLoading)
        repository.getPodcasts(searchTerm: searchTerm)
            .subscribe { [weak self] result in
                guard let self = self else { return }
                switch result {
                case .success(let podcasts):
                    self._state.accept(.loaded(podcasts))
                case .failure(let error):
                    self._state.accept(.failed(error))
                }
            }
            .disposed(by: disposeBag)
    }
    
    func podcastDetailViewModel(at index: Int) -> PodcastDetailViewModel? {
        guard case .loaded(let podcasts) = _state.value  else { return nil }
        guard podcasts.count >= 0, index < podcasts.count else { return nil }
        let podcast = podcasts[index]
        return PodcastDetailViewModel(podcast: podcast)
    }
    
}
