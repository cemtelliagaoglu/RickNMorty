//
//  CoreDataError.swift
//  RickNMorty
//
//  Created by admin on 8.08.2023.
//

import Foundation

public enum CoreDataError: Error {
    case create
    case fetch
    case read
    case update
    case delete
    case save
    case unknown

    var customMessage: String {
        switch self {
        case .create:
            return "Failed to create entity"
        case .fetch:
            return "Failed to fetch entity"
        case .read:
            return "Couldn't read entity"
        case .update:
            return "Failed to update"
        case .delete:
            return "Failed to delete"
        case .save:
            return "An error occured while saving context"
        default:
            return "Unknown core data error"
        }
    }
}
