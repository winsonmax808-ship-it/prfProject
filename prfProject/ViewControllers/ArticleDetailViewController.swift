//
//  ArticleDetailViewController.swift
//  prfProject
//
//  Created by artem on 15.09.2025.
//

import UIKit
import Foundation

class ArticleDetailViewController: UIViewController {
    
    private let article: Article
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    
    private let headerView = UIView()
    private let titleLabel = UILabel()
    private let subtitleLabel = UILabel()
    private let metaStackView = UIStackView()
    private let contentLabel = UILabel()
    private let tagsStackView = UIStackView()
    
    init(article: Article) {
        self.article = article
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupConstraints()
        configureWithArticle()
    }
    
    private func setupUI() {
        view.backgroundColor = UIColor.systemBackground
        title = article.title
        
        navigationController?.navigationBar.prefersLargeTitles = false
        
        // Scroll view setup
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        // Header view
        headerView.backgroundColor = article.category.color.withAlphaComponent(0.1)
        headerView.layer.cornerRadius = 16
        headerView.layer.borderWidth = 1
        headerView.layer.borderColor = article.category.color.withAlphaComponent(0.3).cgColor
        headerView.translatesAutoresizingMaskIntoConstraints = false
        
        // Title label
        titleLabel.font = UIFont.systemFont(ofSize: 28, weight: .bold)
        titleLabel.textColor = UIColor.label
        titleLabel.numberOfLines = 0
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        // Subtitle label
        subtitleLabel.font = UIFont.systemFont(ofSize: 18)
        subtitleLabel.textColor = UIColor.secondaryLabel
        subtitleLabel.numberOfLines = 0
        subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        // Meta stack view
        metaStackView.axis = .horizontal
        metaStackView.spacing = 16
        metaStackView.translatesAutoresizingMaskIntoConstraints = false
        
        // Content label
        contentLabel.font = UIFont.systemFont(ofSize: 16)
        contentLabel.textColor = UIColor.label
        contentLabel.numberOfLines = 0
        contentLabel.translatesAutoresizingMaskIntoConstraints = false
        
        // Tags stack view
        tagsStackView.axis = .horizontal
        tagsStackView.spacing = 8
        tagsStackView.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(headerView)
        headerView.addSubview(titleLabel)
        headerView.addSubview(subtitleLabel)
        headerView.addSubview(metaStackView)
        contentView.addSubview(contentLabel)
        contentView.addSubview(tagsStackView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            headerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            headerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            headerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            titleLabel.topAnchor.constraint(equalTo: headerView.topAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -20),
            
            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            subtitleLabel.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 20),
            subtitleLabel.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -20),
            
            metaStackView.topAnchor.constraint(equalTo: subtitleLabel.bottomAnchor, constant: 16),
            metaStackView.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 20),
            metaStackView.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -20),
            metaStackView.bottomAnchor.constraint(equalTo: headerView.bottomAnchor, constant: -20),
            
            contentLabel.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 24),
            contentLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            contentLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            tagsStackView.topAnchor.constraint(equalTo: contentLabel.bottomAnchor, constant: 24),
            tagsStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            tagsStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            tagsStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20)
        ])
    }
    
    private func configureWithArticle() {
        titleLabel.text = article.title
        subtitleLabel.text = article.subtitle
        contentLabel.text = article.content
        
        // Setup meta information
        setupMetaInformation()
        
        // Setup tags
        setupTags()
    }
    
    private func setupMetaInformation() {
        // Read time
        let readTimeView = createMetaView(icon: "clock.fill", text: "\(article.readTime) min read", color: .systemBlue)
        metaStackView.addArrangedSubview(readTimeView)
        
        // Difficulty
        let difficultyView = createMetaView(icon: "star.fill", text: article.difficulty.rawValue, color: getDifficultyColor())
        metaStackView.addArrangedSubview(difficultyView)
        
        // Category
        let categoryView = createMetaView(icon: article.category.icon, text: article.category.rawValue, color: article.category.color)
        metaStackView.addArrangedSubview(categoryView)
    }
    
    private func createMetaView(icon: String, text: String, color: UIColor) -> UIView {
        let containerView = UIView()
        
        let iconImageView = UIImageView()
        iconImageView.image = UIImage(systemName: icon)
        iconImageView.tintColor = color
        iconImageView.contentMode = .scaleAspectFit
        iconImageView.translatesAutoresizingMaskIntoConstraints = false
        
        let textLabel = UILabel()
        textLabel.text = text
        textLabel.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        textLabel.textColor = color
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        
        containerView.addSubview(iconImageView)
        containerView.addSubview(textLabel)
        
        NSLayoutConstraint.activate([
            iconImageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            iconImageView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            iconImageView.widthAnchor.constraint(equalToConstant: 16),
            iconImageView.heightAnchor.constraint(equalToConstant: 16),
            
            textLabel.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: 4),
            textLabel.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            textLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            textLabel.topAnchor.constraint(equalTo: containerView.topAnchor),
            textLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor)
        ])
        
        return containerView
    }
    
    private func getDifficultyColor() -> UIColor {
        switch article.difficulty {
        case .beginner: return .systemGreen
        case .intermediate: return .systemOrange
        case .advanced: return .systemRed
        case .expert: return .systemPurple
        }
    }
    
    private func setupTags() {
        for tag in article.tags {
            let tagLabel = UILabel()
            tagLabel.text = "#\(tag)"
            tagLabel.font = UIFont.systemFont(ofSize: 12, weight: .medium)
            tagLabel.textColor = UIColor.systemPurple
            tagLabel.backgroundColor = UIColor.systemPurple.withAlphaComponent(0.1)
            tagLabel.layer.cornerRadius = 8
            tagLabel.clipsToBounds = true
            tagLabel.textAlignment = .center
            tagLabel.translatesAutoresizingMaskIntoConstraints = false
            
            NSLayoutConstraint.activate([
                tagLabel.heightAnchor.constraint(equalToConstant: 24)
            ])
            
            tagsStackView.addArrangedSubview(tagLabel)
        }
    }
}
