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
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let viewController = PodcastListViewController(viewModel: PodcastListViewModel())
        viewController.coordinator = self
        navigationController.pushViewController(viewController, animated: true)
    }
    
}
