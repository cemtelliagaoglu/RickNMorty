//
//  HomeRouter.swift
//  RickNMorty
//
//  Created by admin on 7.08.2023.
//

import UIKit

protocol HomeRoutingLogic: AnyObject {
    func routeToCharacterDetails(at index: Int)
}

protocol HomeDataPassing: AnyObject {
    var dataStore: HomeDataStore? { get }
}

final class HomeRouter: HomeRoutingLogic, HomeDataPassing {
    weak var viewController: HomeViewController?
    var dataStore: HomeDataStore?

    func routeToCharacterDetails(at index: Int) {
        guard let character = dataStore?.savedCharacters?[index] else { return }
        let storyboard = UIStoryboard(name: "Details", bundle: nil)
        guard let destinationVC = storyboard.instantiateViewController(withIdentifier: "DetailsViewController") as? DetailsViewController else { return }
        guard let id = Int(character.characterID) else { return }
        destinationVC.setCharacter(id: id)
        DispatchQueue.main.async { [weak self] in
            self?.viewController?.navigationController?.pushViewController(destinationVC, animated: true)
        }
    }
}
