//
//  HomeInteractor.swift
//  RickNMorty
//
//  Created by admin on 7.08.2023.
//

import Foundation

protocol HomeBusinessLogic: AnyObject {
    
}

protocol HomeDataStore: AnyObject {
    
}

final class HomeInteractor: HomeBusinessLogic, HomeDataStore {
    
    var presenter: HomePresentationLogic?
    var worker: HomeWorkingLogic = HomeWorker()
    
}
