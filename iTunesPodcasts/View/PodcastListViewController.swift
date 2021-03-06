//
//  PodcastListViewController.swift
//  iTunesPodcasts
//
//  Created by Florin Uscatu on 11.05.2022.
//

import UIKit

enum PodcastSection {
    case main
}

typealias PodcastDataSource = UITableViewDiffableDataSource<PodcastSection, Podcast>
typealias PodcastSnapshot = NSDiffableDataSourceSnapshot<PodcastSection, Podcast>

class PodcastListViewController: UIViewController {

    private let viewModel: PodcastListViewModel
    
    weak var coordinator: MainCoordinator?
    
    private var searchBar: UISearchBar!
    private var tableView: UITableView!
    private var loadingViewController: LoadingViewController?
    
    init(viewModel: PodcastListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        view.backgroundColor = .white
        addViews()
        setUp()
    }
    
    private func setUp() {
        title = "Podcasts"
        viewModel.dataSource = createDataSource()
        tableView.registerCell(PodcastCell.self)
    }
    
    private func addViews() {
        addSearchBar()
        addTableView()
    }
    
    private func addSearchBar() {
        searchBar = UISearchBar()
        
        searchBar.delegate = self
        searchBar.placeholder = "Name, collection or creator"
        
        view.addSubview(searchBar)
        
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        
        searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    }
    
    private func addTableView() {
        tableView = UITableView()
        
        tableView.delegate = self
        tableView.keyboardDismissMode = .interactive
        
        view.addSubview(tableView)
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        tableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    }
    
    private func createDataSource() -> PodcastDataSource {
        return PodcastDataSource(tableView: tableView) { (tableView, indexPath, itemIdentifier) -> UITableViewCell? in
            let podcastCellViewModel = PodcastCellViewModel(podcast: itemIdentifier)
            let cell: PodcastCell = tableView.dequeueCell()
            cell.viewModel = podcastCellViewModel
            return cell
        }
    }
    
    private func addLoadingViewController() {
        loadingViewController = LoadingViewController()
        guard let loadingViewController = loadingViewController else { return }
        add(loadingViewController)
    }
    
    private func removeLoadingViewController() {
        loadingViewController?.remove()
    }
    
    private func getData(searchTerm: String) {
        addLoadingViewController()
        viewModel.getData(searchTerm: searchTerm) { [weak self] error in
            self?.removeLoadingViewController()
            if let error = error {
                self?.presentAlert(for: error)
            }
        }
    }
    
}

extension PodcastListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let podcastDetailViewModel = viewModel.podcastDetailViewModel(at: indexPath.row) else { return }
        coordinator?.presentDetail(with: podcastDetailViewModel)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}

extension PodcastListViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchTerm = searchBar.text else { return }
        view.endEditing(true)
        getData(searchTerm: searchTerm)
    }
    
}
