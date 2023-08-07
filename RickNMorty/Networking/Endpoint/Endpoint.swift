//
//  Endpoint.swift
//  RickNMorty
//
//  Created by admin on 7.08.2023.
//

import Foundation

public protocol Endpoint {
    var scheme: String { get }
    var host: String { get }
    var path: String { get }
    var method: RequestMethod { get }
    var header: [String: String]? { get }
    var body: [String: String]? { get }
    var queryItems: [URLQueryItem]? { get }
}

public extension Endpoint {
    var scheme: String {
        "https"
    }

    var host: String {
        "rickandmortyapi.com"
    }
}
