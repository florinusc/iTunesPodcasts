//
//  PodcastDetailViewModelTests.swift
//  iTunesPodcastsTests
//
//  Created by Florin Uscatu on 13.05.2022.
//

import XCTest
@testable import iTunesPodcasts

class PodcastDetailViewModelTests: XCTestCase {
    
    func test_imageURL_isNotNil() {
        XCTAssertNotNil(createSUT().imageURL)
    }
    
    func test_trackName_isCorrect() {
        XCTAssertEqual(createSUT().trackName, "Episode 1")
    }
    
    func test_artistName_isCorrect() {
        XCTAssertEqual(createSUT().artistName, "Joe Rogan")
    }
    
    func test_releaseDate_isCorrect() {
        XCTAssertEqual(createSUT().releaseDate, "Apr 10, 2020, 10:42 PM")
    }
    
    private func createSUT() -> PodcastDetailViewModel {
        let podcast = Podcast(artist: "Joe Rogan",
                              track: "Episode 1",
                              releaseDate: "2020-04-10T19:42:00Z",
                              imageURL:"https://is1-ssl.mzstatic.com/image/thumb/Podcasts125/v4/9a/d6/c5/9ad6c560-4d6c-dd45-e01d-4f6aa95213de/mza_18024229060766846024.jpg/600x600bb.jpg")
        return PodcastDetailViewModel(podcast: podcast)
    }
    
}
