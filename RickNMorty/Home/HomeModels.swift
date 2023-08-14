//
//  HomeModels.swift
//  RickNMorty
//
//  Created by admin on 7.08.2023.
//

import Foundation

// swiftlint:disable nesting
enum Home {
    enum Case {
        struct Request {}

        struct Response: Codable {
            let info: Info
            let results: [Result]

            struct Info: Codable {
                let next: String?
                let prev: String?
            }

            struct Result: Codable {
                let id: Int
                let name: String
                let image: String
            }
        }

        struct ViewModel {
            let name: String
            let imageURLString: String
        }
    }
}

// swiftlint:enable nesting
