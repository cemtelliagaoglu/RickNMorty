//
//  DetailsPresenter.swift
//  RickNMorty
//
//  Created by admin on 8.08.2023.
//

import Foundation

protocol DetailsPresentationLogic: AnyObject {
    func presentCharacter(model: Details.Case.Response)
    func presentError(error: RequestError)
}

final class DetailsPresenter: DetailsPresentationLogic {
    weak var viewController: DetailsDisplayLogic?

    func presentCharacter(model: Details.Case.Response) {
        viewController?.displayCharacter(
            viewModel: .init(
                name: model.name,
                species: model.species,
                gender: model.gender,
                origin: model.origin.name,
                location: model.location.name,
                imageURLString: model.image
            ))
    }

    func presentError(error: RequestError) {
        viewController?.displayErrorMessage(error.customMessage)
    }
}
