//
//  HomePresenter.swift
//  RickNMorty
//
//  Created by admin on 7.08.2023.
//

import Foundation

protocol HomePresentationLogic: AnyObject {
    func presentCharacters(model: Home.Case.Response)
    func presentError(message: String)
}

final class HomePresenter: HomePresentationLogic {
    
    weak var viewController: HomeDisplayLogic?
    private var charactersViewModel = [Home.Case.ViewModel]()

    func presentCharacters(model: Home.Case.Response) {
        let allCharacters = model.results
        allCharacters.forEach {
            charactersViewModel.append(.init( name: $0.name,
                                              imageURLString: $0.image))
        }
        viewController?.displayCharacters(viewModels: charactersViewModel)
    }

    func presentError(message: String) {

    }
}
