//
//  DetailsPresenter.swift
//  RickNMorty
//
//  Created by admin on 8.08.2023.
//

import Foundation

protocol DetailsPresentationLogic: AnyObject {}

final class DetailsPresenter: DetailsPresentationLogic {
    weak var viewController: DetailsDisplayLogic?
}
