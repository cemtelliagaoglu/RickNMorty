//
//  HomeWorker.swift
//  RickNMorty
//
//  Created by admin on 7.08.2023.
//

import Foundation

protocol HomeWorkingLogic: AnyObject {
    func sendRequestForAllCharacters(completion: @escaping ((Result<Home.Case.Response, RequestError>) -> Void))
}

final class HomeWorker: HomeWorkingLogic, HTTPClient {
    func sendRequestForAllCharacters(completion: @escaping ((Result<Home.Case.Response, RequestError>) -> Void)) {
        sendRequest(endpoint: CharacterEndpoint.all, responseModel: Home.Case.Response.self, completion: completion)
    }
}
