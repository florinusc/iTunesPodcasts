//
//  PodcastListViewModelTests.swift
//  iTunesPodcastsTests
//
//  Created by Florin Uscatu on 13.05.2022.
//

import XCTest
@testable import iTunesPodcasts

class PodcastListViewModelTests: XCTestCase {
    
    func test_getData_withoutRepositoryError_errorIsNil() {
        let viewModel = createSUT()
        let expectation = XCTestExpectation()
        viewModel.getData(searchTerm: "") { error in
            XCTAssertNil(error)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 5.0)
    }
    
    func test_getData_withRepositoryError_errorIsNotNil() {
        let viewModel = createSUT(withError: true)
        let expectation = XCTestExpectation()
        viewModel.getData(searchTerm: "") { error in
            XCTAssertNotNil(error)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 5.0)
    }
    
    func test_podcastDetailViewModel_atValidIndex_isNotNil() {
        let viewModel = createSUT()
        let expectation = XCTestExpectation()
        viewModel.getData(searchTerm: "") { error in
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 5.0)
        XCTAssertNotNil(viewModel.podcastDetailViewModel(at: 1))
    }
    
    func test_podcastDetailViewModel_atInvalidIndex_isNil() {
        let viewModel = createSUT()
        let expectation = XCTestExpectation()
        viewModel.getData(searchTerm: "") { error in
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 5.0)
        XCTAssertNil(viewModel.podcastDetailViewModel(at: 5))
    }
    
    private func createSUT(withError: Bool = false) -> PodcastListViewModel {
        let viewModel = PodcastListViewModel(repository: MockRepository(shouldReturnError: withError))
        viewModel.dataSource = PodcastDataSource(tableView: UITableView(), cellProvider: { _, _, _ in
            return UITableViewCell()
        })
        return viewModel
    }
    
}
