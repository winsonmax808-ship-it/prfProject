//
//  TestTableViewCell.swift
//  prfProject
//
//  Created by artem on 15.09.2025.
//

import UIKit

class TestTableViewCell: UITableViewCell {
    
    private let containerView = UIView()
    private let iconImageView = UIImageView()
    private let titleLabel = UILabel()
    private let descriptionLabel = UILabel()
    private let difficultyLabel = UILabel()
    private let questionsLabel = UILabel()
    private let timeLabel = UILabel()
    private let startButton = UIButton(type: .system)
    
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
        iconImageView.backgroundColor = UIColor.systemBlue.withAlphaComponent(0.1)
        iconImageView.layer.cornerRadius = 8
        iconImageView.contentMode = .scaleAspectFit
        iconImageView.translatesAutoresizingMaskIntoConstraints = false
        
        // Title label
        titleLabel.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        titleLabel.textColor = UIColor.label
        titleLabel.numberOfLines = 1
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        // Description label
        descriptionLabel.font = UIFont.systemFont(ofSize: 14)
        descriptionLabel.textColor = UIColor.secondaryLabel
        descriptionLabel.numberOfLines = 2
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        
        // Difficulty label
        difficultyLabel.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        difficultyLabel.textColor = UIColor.systemOrange
        difficultyLabel.translatesAutoresizingMaskIntoConstraints = false
        
        // Questions label
        questionsLabel.font = UIFont.systemFont(ofSize: 12)
        questionsLabel.textColor = UIColor.systemBlue
        questionsLabel.translatesAutoresizingMaskIntoConstraints = false
        
        // Time label
        timeLabel.font = UIFont.systemFont(ofSize: 12)
        timeLabel.textColor = UIColor.systemGreen
        timeLabel.translatesAutoresizingMaskIntoConstraints = false
        
        // Start button
        startButton.setTitle("Start", for: .normal)
        startButton.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        startButton.backgroundColor = UIColor.systemBlue
        startButton.setTitleColor(.white, for: .normal)
        startButton.layer.cornerRadius = 8
        startButton.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(containerView)
        containerView.addSubview(iconImageView)
        containerView.addSubview(titleLabel)
        containerView.addSubview(descriptionLabel)
        containerView.addSubview(difficultyLabel)
        containerView.addSubview(questionsLabel)
        containerView.addSubview(timeLabel)
        containerView.addSubview(startButton)
        
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            
            iconImageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            iconImageView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            iconImageView.widthAnchor.constraint(equalToConstant: 50),
            iconImageView.heightAnchor.constraint(equalToConstant: 50),
            
            titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 16),
            titleLabel.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: startButton.leadingAnchor, constant: -8),
            
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
            descriptionLabel.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: 16),
            descriptionLabel.trailingAnchor.constraint(equalTo: startButton.leadingAnchor, constant: -8),
            
            difficultyLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 8),
            difficultyLabel.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: 16),
            
            questionsLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 8),
            questionsLabel.leadingAnchor.constraint(equalTo: difficultyLabel.trailingAnchor, constant: 12),
            
            timeLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 8),
            timeLabel.leadingAnchor.constraint(equalTo: questionsLabel.trailingAnchor, constant: 12),
            timeLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -16),
            
            startButton.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            startButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
            startButton.widthAnchor.constraint(equalToConstant: 60),
            startButton.heightAnchor.constraint(equalToConstant: 32)
        ])
    }
    
    func configure(with test: Test) {
        titleLabel.text = test.title
        descriptionLabel.text = test.description
        difficultyLabel.text = test.difficulty.rawValue
        questionsLabel.text = "\(test.questions.count) questions"
        
        if let timeLimit = test.timeLimit {
            timeLabel.text = "\(timeLimit) min"
        } else {
            timeLabel.text = "No limit"
        }
        
        // Set icon
        iconImageView.image = UIImage(systemName: "brain.head.profile")
        iconImageView.tintColor = UIColor.systemBlue
        
        // Set difficulty color
        switch test.difficulty {
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
