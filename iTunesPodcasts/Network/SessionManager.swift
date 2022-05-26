//
//  SessionManager.swift
//  iTunesPodcasts
//
//  Created by Florin Uscatu on 13.05.2022.
//

import Foundation
import RxSwift
import RxCocoa

class SessionManager {
    
    func request<T: Decodable>(type _: T.Type, requestType: Request) -> Single<T> {
        guard let url = requestType.url else {
            return .error(CustomError.general)
        }
        let request = URLRequest(url: url)
        return URLSession.shared.rx.data(request: request)
            .decode(type: T.self, decoder: JSONDecoder())
            .observe(on: MainScheduler.instance)
            .asSingle()
    }
    
}
