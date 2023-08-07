//
//  CharacterEndpoint.swift
//  RickNMorty
//
//  Created by admin on 7.08.2023.
//

import Foundation

public enum CharacterEndpoint {
    case all
    case single(Int)
}

extension CharacterEndpoint: Endpoint {
    public var path: String {
        switch self {
        case .all:
            return "/api/character"
        case let .single(id):
            return "/api/character/\(id)"
        }
    }

    public var method: RequestMethod {
        .get
    }

    public var header: [String: String]? {
        nil
    }

    public var body: [String: String]? {
        nil
    }

    public var queryItems: [URLQueryItem]? {
        nil
    }
}
