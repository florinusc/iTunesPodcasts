//
//  LoadingViewController.swift
//  iTunesPodcasts
//
//  Created by Florin Uscatu on 13.05.2022.
//

import UIKit

class LoadingViewController: UIViewController {
    
    // MARK: - Lifecycle
    override func loadView() {
        super.loadView()
        addViews()
    }
    
    // MARK: - Private functions
    private func addViews() {
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.startAnimating()
        view.addSubview(spinner)

        NSLayoutConstraint.activate([
            spinner.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            spinner.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}
