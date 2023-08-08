//
//  DetailsRouter.swift
//  RickNMorty
//
//  Created by admin on 8.08.2023.
//

import Foundation

protocol DetailsRoutingLogic: AnyObject {}

protocol DetailsDataPassing: AnyObject {
    var dataStore: DetailsDataStore? { get }
}

final class DetailsRouter: DetailsRoutingLogic, DetailsDataPassing {
    weak var viewController: DetailsViewController?
    var dataStore: DetailsDataStore?
}
