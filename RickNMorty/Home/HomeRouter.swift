//
//  HomeRouter.swift
//  RickNMorty
//
//  Created by admin on 7.08.2023.
//

import Foundation

protocol HomeRoutingLogic: AnyObject {
    
}

protocol HomeDataPassing: class {
    var dataStore: HomeDataStore? { get }
}

final class HomeRouter: HomeRoutingLogic, HomeDataPassing {
    
    weak var viewController: HomeViewController?
    var dataStore: HomeDataStore?
    
}
