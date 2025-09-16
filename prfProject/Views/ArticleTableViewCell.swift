//
//  ArticleTableViewCell.swift
//  prfProject
//
//  Created by artem on 15.09.2025.
//

import UIKit
import Foundation

class ArticleTableViewCell: UITableViewCell {
    
    private let containerView = UIView()
    private let iconImageView = UIImageView()
    private let titleLabel = UILabel()
    private let subtitleLabel = UILabel()
    private let readTimeLabel = UILabel()
    private let difficultyLabel = UILabel()
    private let premiumBadge = UIView()
    private let premiumLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        backgroundColor = UIColor.clear
        selectionStyle = .none
        
        // Container view
        containerView.backgroundColor = UIColor.systemBackground
        containerView.layer.cornerRadius = 12
        containerView.layer.shadowColor = UIColor.black.cgColor
        containerView.layer.shadowOffset = CGSize(width: 0, height: 2)
        containerView.layer.shadowOpacity = 0.1
        containerView.layer.shadowRadius = 4
        containerView.translatesAutoresizingMaskIntoConstraints = false
        
        // Icon image view
        iconImageView.backgroundColor = UIColor.systemPurple.withAlphaComponent(0.1)
        iconImageView.layer.cornerRadius = 8
        iconImageView.contentMode = .scaleAspectFit
        iconImageView.translatesAutoresizingMaskIntoConstraints = false
        
        // Title label
        titleLabel.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        titleLabel.textColor = UIColor.label
        titleLabel.numberOfLines = 2
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        // Subtitle label
        subtitleLabel.font = UIFont.systemFont(ofSize: 14)
        subtitleLabel.textColor = UIColor.secondaryLabel
        subtitleLabel.numberOfLines = 0
        subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        // Read time label
        readTimeLabel.font = UIFont.systemFont(ofSize: 12)
        readTimeLabel.textColor = UIColor.systemBlue
        readTimeLabel.translatesAutoresizingMaskIntoConstraints = false
        
        // Difficulty label
        difficultyLabel.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        difficultyLabel.textColor = UIColor.systemOrange
        difficultyLabel.translatesAutoresizingMaskIntoConstraints = false
        
        // Premium badge
        premiumBadge.backgroundColor = UIColor.systemYellow
        premiumBadge.layer.cornerRadius = 4
        premiumBadge.isHidden = true
        premiumBadge.translatesAutoresizingMaskIntoConstraints = false
        
        premiumLabel.text = "PREMIUM"
        premiumLabel.font = UIFont.systemFont(ofSize: 10, weight: .bold)
        premiumLabel.textColor = UIColor.black
        premiumLabel.textAlignment = .center
        premiumLabel.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(containerView)
        containerView.addSubview(iconImageView)
        containerView.addSubview(titleLabel)
        containerView.addSubview(subtitleLabel)
        containerView.addSubview(readTimeLabel)
        containerView.addSubview(difficultyLabel)
        containerView.addSubview(premiumBadge)
        premiumBadge.addSubview(premiumLabel)
        
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            
            iconImageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            iconImageView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            iconImageView.widthAnchor.constraint(equalToConstant: 60),
            iconImageView.heightAnchor.constraint(equalToConstant: 60),
            
            titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 16),
            titleLabel.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: premiumBadge.leadingAnchor, constant: -8),
            
            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
            subtitleLabel.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: 16),
            subtitleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
            
            readTimeLabel.topAnchor.constraint(equalTo: subtitleLabel.bottomAnchor, constant: 8),
            readTimeLabel.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: 16),
            
            difficultyLabel.topAnchor.constraint(equalTo: subtitleLabel.bottomAnchor, constant: 8),
            difficultyLabel.leadingAnchor.constraint(equalTo: readTimeLabel.trailingAnchor, constant: 12),
            difficultyLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -16),
            
            premiumBadge.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 16),
            premiumBadge.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
            premiumBadge.widthAnchor.constraint(equalToConstant: 60),
            premiumBadge.heightAnchor.constraint(equalToConstant: 20),
            
            premiumLabel.centerXAnchor.constraint(equalTo: premiumBadge.centerXAnchor),
            premiumLabel.centerYAnchor.constraint(equalTo: premiumBadge.centerYAnchor)
        ])
    }
    
    func configure(with article: Article) {
        titleLabel.text = article.title
        subtitleLabel.text = article.subtitle
        readTimeLabel.text = "\(article.readTime) min read"
        difficultyLabel.text = article.difficulty.rawValue
        
        // Set icon based on category
        iconImageView.image = UIImage(systemName: article.category.icon)
        iconImageView.tintColor = article.category.color
        
        // Show premium badge if needed
        premiumBadge.isHidden = !article.isPremium
        
        // Set difficulty color
        switch article.difficulty {
        case .beginner:
            difficultyLabel.textColor = UIColor.systemGreen
        case .intermediate:
            difficultyLabel.textColor = UIColor.systemOrange
        case .advanced:
            difficultyLabel.textColor = UIColor.systemRed
        case .expert:
            difficultyLabel.textColor = UIColor.systemPurple
        }
    }
}
