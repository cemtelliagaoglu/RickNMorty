//
//  DetailsViewController.swift
//  RickNMorty
//
//  Created by admin on 8.08.2023.
//

import UIKit

protocol DetailsDisplayLogic: AnyObject {
    func displayCharacter(viewModel: Details.Case.ViewModel)
    func displayErrorMessage(_ message: String)
}

final class DetailsViewController: UIViewController {
    // MARK: - Properties

    @IBOutlet var imageView: UIImageView!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var locationLabel: UILabel!
    @IBOutlet var speciesLabel: UILabel!
    @IBOutlet var genderLabel: UILabel!
    @IBOutlet var originLabel: UILabel!
    @IBOutlet var loadingIndicator: UIActivityIndicatorView!

    var interactor: DetailsBusinessLogic?
    var router: (DetailsRoutingLogic & DetailsDataPassing)?

    private var viewModel: Details.Case.ViewModel? {
        didSet {
            updateUI()
        }
    }

    // MARK: - Lifecycle

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }

    // MARK: - Methods

    private func setup() {
        let viewController = self
        let interactor = DetailsInteractor()
        let presenter = DetailsPresenter()
        let router = DetailsRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }

    private func updateUI() {
        guard let viewModel else { return }
        imageView.downloadImage(from: viewModel.imageURLString) { [weak self] in
            self?.loadingIndicator.stopAnimating()
        }
        DispatchQueue.main.async { [weak self] in
            self?.nameLabel.text = viewModel.name
            self?.speciesLabel.text = viewModel.species
            self?.genderLabel.text = viewModel.gender
            self?.originLabel.text = viewModel.origin
            self?.locationLabel.text = viewModel.location
        }
    }

    func setCharacter(id: Int) {
        loadingIndicator.startAnimating()
        interactor?.loadCharacter(id: id)
    }
}

// MARK: - DisplayLogic

extension DetailsViewController: DetailsDisplayLogic {
    func displayCharacter(viewModel: Details.Case.ViewModel) {
        self.viewModel = viewModel
    }

    func displayErrorMessage(_ message: String) {
        showError(with: message)
    }
}
