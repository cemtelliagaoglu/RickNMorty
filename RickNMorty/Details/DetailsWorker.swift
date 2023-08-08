//
//  DetailsWorker.swift
//  RickNMorty
//
//  Created by admin on 8.08.2023.
//

import Foundation

protocol DetailsWorkingLogic: AnyObject {
    func sendRequestToCharacter(id: Int, completion: @escaping ((Result<Details.Case.Response, RequestError>) -> Void))
}

final class DetailsWorker: DetailsWorkingLogic, HTTPClient {
    func sendRequestToCharacter(id: Int, completion: @escaping ((Result<Details.Case.Response, RequestError>) -> Void)) {
        sendRequest(endpoint: CharacterEndpoint.single(id), responseModel: Details.Case.Response.self, completion: completion)
    }
}
