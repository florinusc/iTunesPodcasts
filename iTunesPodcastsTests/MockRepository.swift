//
//  MockRepository.swift
//  iTunesPodcasts
//
//  Created by Florin Uscatu on 13.05.2022.
//

import Foundation
@testable import iTunesPodcasts

class MockRepository: Repository {
    
    private let shouldReturnError: Bool
    
    init(shouldReturnError: Bool = false) {
        self.shouldReturnError = shouldReturnError
    }
    
    func getPodcasts(searchTerm: String, completion handler: @escaping (Result<[Podcast], Error>) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
            if self.shouldReturnError {
                handler(.failure(CustomError.general))
                return
            }
            let podcasts = [
                Podcast(artist: "Joe Rogan", track: "Episode 1", releaseDate: "2020-04-10T19:42:00Z", imageURL:"https://is1-ssl.mzstatic.com/image/thumb/Podcasts125/v4/9a/d6/c5/9ad6c560-4d6c-dd45-e01d-4f6aa95213de/mza_18024229060766846024.jpg/600x600bb.jpg"),
                Podcast(artist: "Joe Rogan", track: "Episode 3", releaseDate: "2020-10-10T19:42:00Z", imageURL: "https://is5-ssl.mzstatic.com/image/thumb/Podcasts123/v4/9b/c3/fd/9bc3fd54-315f-a3b7-6ffd-b3710a1f5a27/mza_13251109906953285905.jpg/600x600bb.jpg")
            ]
            handler(.success(podcasts))
        }
    }
    
}
