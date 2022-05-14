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
    private var scrollView: UIScrollView!
    private var contentView: UIView!
    
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
        addScrollView()
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

        contentView.addSubview(stackView)

        stackView.translatesAutoresizingMaskIntoConstraints = false

        stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20).isActive = true
        stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20).isActive = true
        stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20).isActive = true
        stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20).isActive = true
    }
    
    private func addScrollView() {
        scrollView = UIScrollView()
        contentView = UIView()
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(scrollView)
        
        scrollView.addSubview(contentView)
        scrollView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        scrollView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        scrollView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        contentView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        contentView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
    }
    
}
