//
//  HomeInteractor.swift
//  RickNMorty
//
//  Created by admin on 7.08.2023.
//

import Foundation

protocol HomeBusinessLogic: AnyObject {
    func loadData()
}

protocol HomeDataStore: AnyObject {
    var allCharacters: [Home.Case.Response.Result]? { get }
}

final class HomeInteractor: HomeBusinessLogic, HomeDataStore {
    var presenter: HomePresentationLogic?
    var worker: HomeWorkingLogic = HomeWorker()
    var allCharacters: [Home.Case.Response.Result]?

    func loadData() {
        // TODO: check if exists in coredata
        // if not existing, request all characters
        worker.sendRequestForAllCharacters { [weak self] result in
            switch result {
            case let .success(response):
                self?.allCharacters = response.results
                self?.presenter?.presentCharacters(model: response)
            case let .failure(error):
                self?.presenter?.presentError(message: error.customMessage)
            }
        }
    }
}
