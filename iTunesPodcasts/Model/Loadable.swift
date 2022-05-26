//
//  Loadable.swift
//  iTunesPodcasts
//
//  Created by Florin Uscatu on 26.05.2022.
//

import Foundation

enum Loadable<Value: Equatable> {
    case notRequested
    case isLoading
    case loaded(Value)
    case failed(Error)
}

extension Loadable {
    var notRequested: Bool {
        switch self {
        case .notRequested: return true
        default: return false
        }
    }
    var isLoading: Bool {
        switch self {
        case .isLoading: return true
        default: return false
        }
    }
    var value: Value? {
        switch self {
        case let .loaded(value): return value
        default: return nil
        }
    }
    var error: Error? {
        switch self {
        case let .failed(error): return error
        default: return nil
        }
    }
}

extension Loadable: Equatable {
    static func == (lhs: Loadable<Value>, rhs: Loadable<Value>) -> Bool {
        switch (lhs, rhs) {
        case (.notRequested, .notRequested):
            return true
        case (.isLoading, .isLoading):
            return true
        case (.failed(let lhsError), .failed(let rhsError)):
            let error1 = lhsError as NSError
            let error2 = rhsError as NSError
            return error1.domain == error2.domain && error1.code == error2.code && "\(lhs)" == "\(rhs)"
        case (.loaded(let lhsPodcasts), .loaded(let rhsPodcasts)):
            return lhsPodcasts == rhsPodcasts
        default: return false
        }
    }
}
