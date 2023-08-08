//
//  DetailsModels.swift
//  RickNMorty
//
//  Created by admin on 8.08.2023.
//

import Foundation

// swiftlint:disable nesting
enum Details {
    enum Case {
        struct Request {}

        struct Response: Codable {
            let name: String
            let species: String
            let gender: String
            let origin: Origin
            let location: Location
            let image: String

            struct Origin: Codable {
                let name: String
            }

            struct Location: Codable {
                let name: String
            }
        }

        struct ViewModel {
            let name: String
            let species: String
            let gender: String
            let origin: String
            let location: String
            let imageURLString: String
        }
    }
}

// swiftlint:enable nesting
