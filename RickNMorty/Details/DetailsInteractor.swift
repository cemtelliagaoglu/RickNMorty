//
//  DetailsInteractor.swift
//  RickNMorty
//
//  Created by admin on 8.08.2023.
//

import Foundation

protocol DetailsBusinessLogic: AnyObject {}

protocol DetailsDataStore: AnyObject {}

final class DetailsInteractor: DetailsBusinessLogic, DetailsDataStore {
    var presenter: DetailsPresentationLogic?
    var worker: DetailsWorkingLogic = DetailsWorker()
}
