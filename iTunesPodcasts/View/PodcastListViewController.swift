//
//  PodcastListViewController.swift
//  iTunesPodcasts
//
//  Created by Florin Uscatu on 11.05.2022.
//

import UIKit
import RxSwift
import RxCocoa

class PodcastListViewController: UIViewController {

    private let viewModel: PodcastListViewModel
    private let disposeBag = DisposeBag()
    
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
        tableView.registerCell(PodcastCell.self)
        addSubscribers()
    }
    
    private func addSubscribers() {
        addSubscriberForLoadingState()
        addSubscriberForError()
        addSubscriberForSearch()
    }
    
    private func addSubscriberForLoadingState() {
        viewModel.state.map { $0.isLoading }
            .drive(onNext: { [weak self] isLoading in
                if isLoading {
                    self?.addLoadingViewController()
                } else {
                    self?.removeLoadingViewController()
                }
            })
            .disposed(by: disposeBag)
    }
    
    private func addSubscriberForError() {
        viewModel.state.map({ $0.error })
            .drive(onNext: { [weak self] error in
                if let error = error {
                    self?.presentAlert(for: error)
                }
            })
            .disposed(by: disposeBag)
    }
    
    private func addSubscriberForSearch() {
        searchBar.rx.searchButtonClicked
            .subscribe(onNext: { [weak self] in
                guard
                    let self = self,
                    let searchTerm = self.searchBar.text
                else {
                    return
                }
                self.view.endEditing(true)
                self.viewModel.getData(searchTerm: searchTerm)
            })
            .disposed(by: disposeBag)
    }
    
    private func addViews() {
        addSearchBar()
        addTableView()
    }
    
    private func addSearchBar() {
        searchBar = UISearchBar()
        
        searchBar.placeholder = "Name, collection or creator"
        
        view.addSubview(searchBar)
        
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        
        searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    }
    
    private func addTableView() {
        tableView = UITableView()
        
        tableView.rx.setDelegate(self).disposed(by: disposeBag)
        tableView.keyboardDismissMode = .interactive
        
        view.addSubview(tableView)
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        tableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        
        bindTableView()
    }
    
    private func bindTableView() {
        viewModel.state.compactMap { $0.value }
            .drive(tableView.rx.items(cellIdentifier: String(describing: PodcastCell.self), cellType: PodcastCell.self)) { _, podcast, cell in
                cell.viewModel = PodcastCellViewModel(podcast: podcast)
            }
            .disposed(by: disposeBag)
        
        tableView.rx.itemSelected
            .subscribe(onNext: { [weak self] indexPath in
                self?.tableView.deselectRow(at: indexPath, animated: true)
                guard let podcastDetailViewModel = self?.viewModel.podcastDetailViewModel(at: indexPath.row) else { return }
                self?.coordinator?.presentDetail(with: podcastDetailViewModel)
            })
            .disposed(by: disposeBag)
    }
    
    private func addLoadingViewController() {
        loadingViewController = LoadingViewController()
        guard let loadingViewController = loadingViewController else { return }
        add(loadingViewController)
    }
    
    private func removeLoadingViewController() {
        loadingViewController?.remove()
    }
    
}

extension PodcastListViewController: UITableViewDelegate {}
