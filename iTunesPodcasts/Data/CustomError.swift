//
//  CustomError.swift
//  iTunesPodcasts
//
//  Created by Florin Uscatu on 13.05.2022.
//

import Foundation

enum CustomError: Error {
    case general
    case network
    case custom(message: String)
}

extension CustomError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .general: return NSLocalizedString("Oops, something went wrong", comment: "General Error")
        case .network: return NSLocalizedString("There's a problem with the network", comment: "Network Error")
        case .custom(let message): return message
        }
    }
}
