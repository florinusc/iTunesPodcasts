//
//  Repository.swift
//  iTunesPodcasts
//
//  Created by Florin Uscatu on 13.05.2022.
//

import Foundation
import RxSwift

protocol Repository {
    func getPodcasts(searchTerm: String) -> Single<[Podcast]>
}
