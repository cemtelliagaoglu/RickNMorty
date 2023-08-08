//
//  DetailsInteractor.swift
//  RickNMorty
//
//  Created by admin on 8.08.2023.
//

import Foundation

protocol DetailsBusinessLogic: AnyObject {
    func loadCharacter(id: Int)
}

protocol DetailsDataStore: AnyObject {}

final class DetailsInteractor: DetailsBusinessLogic, DetailsDataStore {
    var presenter: DetailsPresentationLogic?
    var worker: DetailsWorkingLogic = DetailsWorker()

    func loadCharacter(id: Int) {
        worker.sendRequestToCharacter(id: id) { [weak self] result in
            switch result {
            case let .success(response):
                self?.presenter?.presentCharacter(model: response)
            case let .failure(error):
                self?.presenter?.presentError(error: error)
            }
        }
    }
}
