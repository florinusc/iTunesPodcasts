//
//  PodcastCell.swift
//  iTunesPodcasts
//
//  Created by Florin Uscatu on 11.05.2022.
//

import UIKit

class PodcastCell: UITableViewCell {
    
    private var podcastImageView: UIImageView!
    private var artistLabel: UILabel!
    private var trackLabel: UILabel!
    
    var viewModel: PodcastCellViewModel? {
        didSet {
            artistLabel.text = viewModel?.artistName
            trackLabel.text = viewModel?.trackName
            podcastImageView.setImage(with: viewModel?.imageURL)
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        podcastImageView = UIImageView()
        
        podcastImageView.translatesAutoresizingMaskIntoConstraints = false
        
        podcastImageView.layer.cornerRadius = 8
        podcastImageView.clipsToBounds = true
        
        let imageViewHeightConstraint = podcastImageView.heightAnchor.constraint(equalToConstant: 100)
        imageViewHeightConstraint.priority = UILayoutPriority(999)
        imageViewHeightConstraint.isActive = true
        podcastImageView.widthAnchor.constraint(equalToConstant: 100).isActive = true
        
        artistLabel = UILabel()
        trackLabel = UILabel()
        
        let labelsStackView = UIStackView(arrangedSubviews: [artistLabel, trackLabel])
        
        labelsStackView.alignment = .fill
        labelsStackView.distribution = .fillEqually
        labelsStackView.axis = .vertical
        
        let mainStackView = UIStackView(arrangedSubviews: [podcastImageView, labelsStackView])
        
        mainStackView.alignment = .fill
        mainStackView.distribution = .fill
        mainStackView.axis = .horizontal
        mainStackView.spacing = 15
        
        addSubview(mainStackView)
        
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        
        mainStackView.topAnchor.constraint(equalTo: topAnchor, constant: 10).isActive = true
        mainStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10).isActive = true
        mainStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10).isActive = true
        mainStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10).isActive = true
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var reuseIdentifier: String? {
        return String(describing: Self.self)
    }
    
}