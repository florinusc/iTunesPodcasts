//
//  SessionManager.swift
//  iTunesPodcasts
//
//  Created by Florin Uscatu on 13.05.2022.
//

import Foundation
import Alamofire

class SessionManager {
    
    func request<T: Decodable>(type _: T.Type, requestType: Request, completion handler: @escaping (Result<T, Error>) -> Void) {
        guard let url = requestType.url else {
            handler(Result.failure(CustomError.network))
            return
        }
        AF.request(url)
          .validate()
          .responseDecodable(of: T.self) { (response) in
            guard let object = response.value else { return }
            handler(Result.success(object))
        }
    }
    
}
