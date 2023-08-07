//
//  HomeViewController.swift
//  RickNMorty
//
//  Created by admin on 7.08.2023.
//

import UIKit

protocol HomeDisplayLogic: AnyObject {
    func displayCharacters(viewModels: [Home.Case.ViewModel])
    func displayErrorMessage(_ message: String)
}

final class HomeViewController: UIViewController {

    //MARK: - Properties

    @IBOutlet weak var tableView: UITableView!

    var interactor: HomeBusinessLogic?
    var router: (HomeRoutingLogic & HomeDataPassing)?
    private var viewModel: [Home.Case.ViewModel]?
    private let characterCellIdentifier = "characterCell"
    //MARK: - Lifecycle

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
    
    //MARK: - Methods
    
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
    }
}

    //MARK: - TableView

extension HomeViewController: UITableViewDataSource,UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: characterCellIdentifier) as? CharacterTableViewCell else { return UITableViewCell() }
        guard let viewModel = viewModel?[indexPath.row] else { return cell }
        cell.characterNameLabel.text = viewModel.name
        return cell
    }
}

    //MARK: - DisplayLogic
extension HomeViewController: HomeDisplayLogic {
    func displayCharacters(viewModels: [Home.Case.ViewModel]) {
        DispatchQueue.main.async { [weak self] in
            self?.viewModel = viewModels
            self?.tableView.reloadData()
        }
    }
    func displayErrorMessage(_ message: String) {
        
    }
}
