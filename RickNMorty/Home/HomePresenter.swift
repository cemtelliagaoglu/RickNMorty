//
//  HomePresenter.swift
//  RickNMorty
//
//  Created by admin on 7.08.2023.
//

import Foundation

protocol HomePresentationLogic: AnyObject {
    func presentCharacters(model: Home.Case.Response, isLastPage: Bool)
    func presentSavedCharacters(characters: [Character])
    func presentError(message: String)
}

final class HomePresenter: HomePresentationLogic {
    weak var viewController: HomeDisplayLogic?
    private var charactersViewModel = [Home.Case.ViewModel]()

    func presentCharacters(model: Home.Case.Response, isLastPage: Bool) {
        let allCharacters = model.results
        allCharacters.forEach {
            charactersViewModel.append(.init(name: $0.name,
                                             imageURLString: $0.image))
        }
        viewController?.displayCharacters(viewModels: charactersViewModel, isLastPage: isLastPage)
    }

    func presentSavedCharacters(characters: [Character]) {
        characters.forEach {
            guard let name = $0.name,
                  let urlString = $0.imageURLString
            else { return }
            charactersViewModel.append(.init(name: name, imageURLString: urlString))
        }
        viewController?.displayCharacters(viewModels: charactersViewModel, isLastPage: false)
    }

    func presentError(message: String) {
        viewController?.displayErrorMessage(message)
    }
}
