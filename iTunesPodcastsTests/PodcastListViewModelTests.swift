//
//  PodcastListViewModelTests.swift
//  iTunesPodcastsTests
//
//  Created by Florin Uscatu on 13.05.2022.
//

import XCTest
import RxSwift
import RxTest
@testable import iTunesPodcasts

class PodcastListViewModelTests: XCTestCase {
    
    var scheduler: TestScheduler!
    var disposeBag: DisposeBag!

    override func setUp() {
        super.setUp()
        scheduler = TestScheduler(initialClock: 0)
        disposeBag = DisposeBag()
    }

    func test_initialState_isNotRequested() throws {
        let state = scheduler.createObserver(Loadable<[Podcast]>.self)
        let viewModel = createSUT()

        viewModel.state
            .drive(state)
            .disposed(by: disposeBag)

        scheduler.start()
        
        XCTAssertEqual(state.events, [.next(0, .notRequested)])
    }
    
    func test_lastStateAfterRequestingDataWithoutError_isLoaded() throws {
        let state = scheduler.createObserver(Loadable<[Podcast]>.self)
        let viewModel = createSUT()

        viewModel.state
            .drive(state)
            .disposed(by: disposeBag)

        viewModel.getData(searchTerm: "test")
        
        scheduler.start()
        
        XCTAssertEqual(state.events.last, .next(0, .loaded([iTunesPodcasts.Podcast(artist: "Joe Rogan", track: "Episode 1", releaseDate: "2020-04-10T19:42:00Z", imageURL: "https://is1-ssl.mzstatic.com/image/thumb/Podcasts125/v4/9a/d6/c5/9ad6c560-4d6c-dd45-e01d-4f6aa95213de/mza_18024229060766846024.jpg/600x600bb.jpg"), iTunesPodcasts.Podcast(artist: "Joe Rogan", track: "Episode 3", releaseDate: "2020-10-10T19:42:00Z", imageURL: "https://is5-ssl.mzstatic.com/image/thumb/Podcasts123/v4/9b/c3/fd/9bc3fd54-315f-a3b7-6ffd-b3710a1f5a27/mza_13251109906953285905.jpg/600x600bb.jpg")])))
    }
    
    func test_lastStateAfterRequestingDataWithError_isError() throws {
        let state = scheduler.createObserver(Loadable<[Podcast]>.self)
        let viewModel = createSUT(withError: true)

        viewModel.state
            .drive(state)
            .disposed(by: disposeBag)

        viewModel.getData(searchTerm: "test")
        
        scheduler.start()
        
        XCTAssertEqual(state.events.last, .next(0, .failed(CustomError.general)))
    }


    func test_podcastDetailViewModel_atValidIndex_isNotNil() {
        let viewModel = createSUT()
        viewModel.getData(searchTerm: "")
        XCTAssertNotNil(viewModel.podcastDetailViewModel(at: 1))
    }

    func test_podcastDetailViewModel_atInvalidIndex_isNil() {
        let viewModel = createSUT()
        viewModel.getData(searchTerm: "")
        XCTAssertNil(viewModel.podcastDetailViewModel(at: 5))
    }

    private func createSUT(withError: Bool = false) -> PodcastListViewModel {
        let viewModel = PodcastListViewModel(repository: MockRepository(shouldReturnError: withError))
        return viewModel
    }

}
