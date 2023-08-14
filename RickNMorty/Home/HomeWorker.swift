//
//  HomeWorker.swift
//  RickNMorty
//
//  Created by admin on 7.08.2023.
//

import Foundation

protocol HomeWorkingLogic: AnyObject {
    func sendRequestForAllCharacters(completion: @escaping ((Result<Home.Case.Response, RequestError>) -> Void))
    func checkCoreDataForCharacters(completion: @escaping ((Result<[Character], CoreDataError>) -> Void))
    func saveCharacters(characters: [Home.Case.Response.Result], completion: @escaping ((Result<[Character], CoreDataError>) -> Void))
    func sendRequestForNext(urlString: String, completion: @escaping ((Result<Home.Case.Response, RequestError>) -> Void))
}

final class HomeWorker: HomeWorkingLogic, HTTPClient {
    private let coreDataManager = CoreDataManager.shared

    func sendRequestForAllCharacters(completion: @escaping ((Result<Home.Case.Response, RequestError>) -> Void)) {
        sendRequest(endpoint: CharacterEndpoint.all, responseModel: Home.Case.Response.self, completion: completion)
    }

    func checkCoreDataForCharacters(completion: @escaping ((Result<[Character], CoreDataError>) -> Void)) {
        coreDataManager.read(type: Character.self, completion: completion)
    }

    func saveCharacters(characters: [Home.Case.Response.Result], completion: @escaping ((Result<[Character], CoreDataError>) -> Void)) {
        var tempChars = [Character]()
        for character in characters {
            coreDataManager.create(type: Character.self) { [weak self] result in
                switch result {
                case let .success(newCharacter):
                    newCharacter.characterID = String(character.id)
                    newCharacter.imageURLString = character.image
                    newCharacter.name = character.name
                    self?.coreDataManager.update(completion: { result in
                        switch result {
                        case .success:
                            tempChars.append(newCharacter)
                        case let .failure(error):
                            completion(.failure(error))
                        }
                    })
                case let .failure(error):
                    completion(.failure(error))
                }
            }
        }
        completion(.success(tempChars))
    }

    func sendRequestForNext(urlString: String, completion: @escaping ((Result<Home.Case.Response, RequestError>) -> Void)) {
        sendRequest(with: urlString, responseModel: Home.Case.Response.self, completion: completion)
    }
}
