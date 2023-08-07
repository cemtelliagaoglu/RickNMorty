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
    
}

final class HomeInteractor: HomeBusinessLogic, HomeDataStore {
    
    var presenter: HomePresentationLogic?
    var worker: HomeWorkingLogic = HomeWorker()

    func loadData() {
        // TODO: check if exists in coredata
        // if not existing, request all characters
        worker.sendRequestForAllCharacters { [weak self] result in
            switch result {
            case .success(let response):
                self?.presenter?.presentCharacters(model: response)
            case .failure(let error):
                self?.presenter?.presentError(message: error.customMessage)
            }
        }
    }
    
}
