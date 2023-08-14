//
//  HomeViewController.swift
//  RickNMorty
//
//  Created by admin on 7.08.2023.
//

import UIKit

protocol HomeDisplayLogic: AnyObject {
    func displayCharacters(viewModels: [Home.Case.ViewModel], isLastPage: Bool)
    func displayErrorMessage(_ message: String)
}

final class HomeViewController: UIViewController {
    // MARK: - Properties

    @IBOutlet var tableView: UITableView!
    @IBOutlet var nextPageLoadingIndicator: UIActivityIndicatorView!

    var interactor: HomeBusinessLogic?
    var router: (HomeRoutingLogic & HomeDataPassing)?
    private var viewModel: [Home.Case.ViewModel]?
    private let characterCellIdentifier = "characterCell"
    private var isLastPage: Bool = false

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        interactor?.loadData()
    }

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
        let interactor = HomeInteractor()
        let presenter = HomePresenter()
        let router = HomeRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }

    private func setupView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "CharacterTableViewCell", bundle: nil), forCellReuseIdentifier: characterCellIdentifier)
        setupNavigationBar()
    }

    private func setupNavigationBar() {
        title = "Rick and Morty"
        let navBar = navigationController?.navigationBar
        let appearance = UINavigationBarAppearance()
        appearance.titleTextAttributes = [
            .font: UIFont(name: "Noteworthy Bold", size: 22)!,
            .foregroundColor: UIColor.systemGreen,
            .strokeColor: UIColor.black,
            .strokeWidth: -2.5,
        ]
        appearance.backgroundColor = UIColor(named: "barBackgroundColor")
        navigationItem.backButtonTitle = ""
        navBar?.tintColor = UIColor(named: "textColor")
        navBar?.standardAppearance = appearance
        navBar?.scrollEdgeAppearance = appearance
    }
}

// MARK: - TableView

extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        return viewModel?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: characterCellIdentifier) as? CharacterTableViewCell else { return UITableViewCell() }
        guard let viewModel = viewModel?[indexPath.row] else { return cell }
        cell.viewModel = viewModel
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        router?.routeToCharacterDetails(at: indexPath.row)
    }

    func tableView(_: UITableView, willDisplay _: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let modelCount = viewModel?.count else { return }
        if indexPath.row == modelCount - 1 {
            if !isLastPage {
                nextPageLoadingIndicator.startAnimating()
                interactor?.nextPage()
            }
        }
    }
}

// MARK: - DisplayLogic

extension HomeViewController: HomeDisplayLogic {
    func displayCharacters(viewModels: [Home.Case.ViewModel], isLastPage: Bool) {
        DispatchQueue.main.async { [weak self] in
            self?.isLastPage = isLastPage
            self?.viewModel = viewModels
            self?.tableView.reloadData()
            self?.nextPageLoadingIndicator.stopAnimating()
        }
    }

    func displayErrorMessage(_ message: String) {
        showError(with: message)
    }
}
