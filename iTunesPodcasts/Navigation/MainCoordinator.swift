//
//  MainCoordinator.swift
//  iTunesPodcasts
//
//  Created by Florin Uscatu on 11.05.2022.
//

import UIKit

class MainCoordinator: Coordinator {
    
    var children: [Coordinator] = []
    
    let navigationController: UINavigationController
    
    private let repository = OnlineRepository()
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let viewController = PodcastListViewController(viewModel: PodcastListViewModel(repository: repository))
        viewController.coordinator = self
        navigationController.pushViewController(viewController, animated: true)
    }
    
    func presentDetail(with viewModel: PodcastDetailViewModel) {
        let viewController = PodcastDetailViewController.init(viewModel: viewModel)
        viewController.coordinator = self
        navigationController.pushViewController(viewController, animated: true)
    }
    
}
