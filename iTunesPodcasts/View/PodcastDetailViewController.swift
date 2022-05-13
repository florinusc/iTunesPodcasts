//
//  PodcastDetailViewController.swift
//  iTunesPodcasts
//
//  Created by Florin Uscatu on 12.05.2022.
//

import UIKit

class PodcastDetailViewController: UIViewController {
    
    private let viewModel: PodcastDetailViewModel
    
    weak var coordinator: MainCoordinator?
    
    private var podcastImageView: UIImageView!
    private var artistLabel: UILabel!
    private var trackLabel: UILabel!
    private var releaseDateLabel: UILabel!
    private var stackView: UIStackView!
    
    init(viewModel: PodcastDetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        view.backgroundColor = .systemBackground
        addViews()
    }
    
    private func addViews() {
        addPodcastImageView()
        addLabels()
        addStackView()
    }
    
    private func addPodcastImageView() {
        podcastImageView = UIImageView()
        podcastImageView.setImage(with: viewModel.imageURL)
        podcastImageView.translatesAutoresizingMaskIntoConstraints = false
        podcastImageView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        podcastImageView.widthAnchor.constraint(equalToConstant: 200).isActive = true
        podcastImageView.layer.cornerRadius = 8
        podcastImageView.clipsToBounds = true
    }
    
    private func addLabels() {
        artistLabel = UILabel()
        artistLabel.numberOfLines = 0
        artistLabel.font = .preferredFont(forTextStyle: .title2)
        artistLabel.textAlignment = .center
        artistLabel.text = viewModel.artistName
        
        trackLabel = UILabel()
        trackLabel.numberOfLines = 0
        trackLabel.textAlignment = .center
        trackLabel.text = viewModel.trackName
        
        releaseDateLabel = UILabel()
        releaseDateLabel.numberOfLines = 2
        releaseDateLabel.font = .preferredFont(forTextStyle: .footnote)
        releaseDateLabel.textAlignment = .center
        releaseDateLabel.text = viewModel.releaseDate
    }
    
    private func addStackView() {
        stackView = UIStackView(arrangedSubviews: [podcastImageView, artistLabel, trackLabel, releaseDateLabel])
        
        stackView.axis = .vertical
        stackView.spacing = 20
        stackView.distribution = .fill
        stackView.alignment = .center
        
        view.addSubview(stackView)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
        stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
    }
    
}
