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
    var savedCharacters: [Character]? { get }
}

final class HomeInteractor: HomeBusinessLogic, HomeDataStore {
    var presenter: HomePresentationLogic?
    var worker: HomeWorkingLogic = HomeWorker()
    var allCharacters: [Home.Case.Response.Result]?
    var savedCharacters: [Character]?

    func loadData() {
        // check if exists in coredata
        worker.checkCoreDataForCharacters { [weak self] result in
            switch result {
            case let .success(response):
                self?.savedCharacters = response
                if response.isEmpty {
                    self?.sendRequest()
                } else {
                    self?.presenter?.presentSavedCharacters(characters: response)
                }
            case .failure:
                // if not existing, request all characters
                self?.sendRequest()
            }
        }
    }

    private func sendRequest() {
        worker.sendRequestForAllCharacters { [weak self] result in
            switch result {
            case let .success(response):
                self?.allCharacters = response.results
                self?.worker.saveCharacters(characters: response.results, completion: { result in
                    switch result {
                    case let .success(characters):
                        self?.savedCharacters = characters
                        self?.presenter?.presentSavedCharacters(characters: characters)
                    case let .failure(error):
                        self?.presenter?.presentError(message: error.customMessage)
                    }
                })
            case let .failure(error):
                self?.presenter?.presentError(message: error.customMessage)
            }
        }
    }
}
