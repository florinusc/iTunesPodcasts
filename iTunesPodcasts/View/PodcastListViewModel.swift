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
    private let _error = BehaviorRelay<Error?>(value: nil)
    
    private var _podcasts = BehaviorSubject<[Podcast]>(value: [])
    
    var isLoading: Driver<Bool> {
        return _isLoading.asDriver()
    }
    
    var error: Driver<Error?> {
        return _error.asDriver()
    }
    
    var podcastCellViewModels: Driver<[PodcastCellViewModel]> {
        return _podcasts.map({ $0.map { PodcastCellViewModel(podcast: $0) } }).asDriver(onErrorJustReturn: [])
    }
    
    init(repository: Repository) {
        self.repository = repository
    }
    
    func getData(searchTerm: String) {
        self._isLoading.accept(true)
        repository.getPodcasts(searchTerm: searchTerm)
            .subscribe { result in
                switch result {
                case .success(let podcasts):
                    self._podcasts.onNext(podcasts)
                case .failure(let error):
                    self._error.accept(error)
                }
                self._isLoading.accept(false)
            }
            .disposed(by: disposeBag)
    }
    
    func podcastDetailViewModel(at index: Int) -> PodcastDetailViewModel? {
        guard let podcasts = try? _podcasts.value() else { return nil }
        guard podcasts.count >= 0, index < podcasts.count else { return nil }
        let podcast = podcasts[index]
        return PodcastDetailViewModel(podcast: podcast)
    }
    
}
