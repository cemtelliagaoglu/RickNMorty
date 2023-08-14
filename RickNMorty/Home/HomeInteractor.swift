//
//  HomeInteractor.swift
//  RickNMorty
//
//  Created by admin on 7.08.2023.
//

import Foundation

protocol HomeBusinessLogic: AnyObject {
    func loadData()
    func nextPage()
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
    private var nextPageURL = "https://rickandmortyapi.com/api/character?page=2"

    func loadData() {
        // check if exists in coredata
        worker.checkCoreDataForCharacters { [weak self] result in
            switch result {
            case let .success(response):
                self?.savedCharacters = response
                self?.appendSavedCharactersToAll()
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

    func nextPage() {
        worker.sendRequestForNext(urlString: nextPageURL) { [weak self] result in
            switch result {
            case let .success(response):
                var tempCharacters = self?.allCharacters ?? [Home.Case.Response.Result]()
                for character in response.results {
                    tempCharacters.append(character)
                }
                self?.allCharacters = tempCharacters
                guard let nextURL = response.info.next else {
                    self?.presenter?.presentCharacters(model: response, isLastPage: true)
                    return
                }
                self?.nextPageURL = nextURL
                self?.presenter?.presentCharacters(model: response, isLastPage: false)
            case let .failure(error):
                self?.presenter?.presentError(message: error.customMessage)
            }
        }
    }

    private func appendSavedCharactersToAll() {
        guard let savedCharacters else { return }
        var tempCharacters = allCharacters ?? [Home.Case.Response.Result]()
        savedCharacters.forEach {
            guard let id = Int($0.characterID),
                  let name = $0.name,
                  let image = $0.imageURLString
            else { return }
            tempCharacters.append(.init(id: id,
                                        name: name,
                                        image: image))
        }
        allCharacters = tempCharacters
    }
}
