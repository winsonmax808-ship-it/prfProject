//
//  ProfileHeaderView.swift
//  prfProject
//
//  Created by artem on 15.09.2025.
//

import UIKit

class ProfileHeaderView: UIView {
    
    private let avatarImageView = UIImageView()
    private let nameLabel = UILabel()
    private let levelLabel = UILabel()
    private let experienceLabel = UILabel()
    private let progressView = UIProgressView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        backgroundColor = UIColor.systemBackground
        
        // Avatar image view
        avatarImageView.backgroundColor = UIColor.systemPurple.withAlphaComponent(0.2)
        avatarImageView.layer.cornerRadius = 40
        avatarImageView.contentMode = .scaleAspectFit
        avatarImageView.translatesAutoresizingMaskIntoConstraints = false
        
        // Name label
        nameLabel.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        nameLabel.textColor = UIColor.label
        nameLabel.textAlignment = .center
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        // Level label
        levelLabel.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        levelLabel.textColor = UIColor.systemPurple
        levelLabel.textAlignment = .center
        levelLabel.translatesAutoresizingMaskIntoConstraints = false
        
        // Experience label
        experienceLabel.font = UIFont.systemFont(ofSize: 14)
        experienceLabel.textColor = UIColor.secondaryLabel
        experienceLabel.textAlignment = .center
        experienceLabel.translatesAutoresizingMaskIntoConstraints = false
        
        // Progress view
        progressView.progressTintColor = UIColor.systemPurple
        progressView.trackTintColor = UIColor.systemGray5
        progressView.layer.cornerRadius = 4
        progressView.clipsToBounds = true
        progressView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(avatarImageView)
        addSubview(nameLabel)
        addSubview(levelLabel)
        addSubview(experienceLabel)
        addSubview(progressView)
        
        NSLayoutConstraint.activate([
            avatarImageView.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            avatarImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            avatarImageView.widthAnchor.constraint(equalToConstant: 80),
            avatarImageView.heightAnchor.constraint(equalToConstant: 80),
            
            nameLabel.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: 12),
            nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            nameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            
            levelLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 4),
            levelLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            levelLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            
            experienceLabel.topAnchor.constraint(equalTo: levelLabel.bottomAnchor, constant: 8),
            experienceLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            experienceLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            
            progressView.topAnchor.constraint(equalTo: experienceLabel.bottomAnchor, constant: 8),
            progressView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 40),
            progressView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -40),
            progressView.heightAnchor.constraint(equalToConstant: 8),
            progressView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20)
        ])
    }
    
    func configure(with profile: UserProfile) {
        nameLabel.text = "Perfume Master" // Замість імені користувача
        levelLabel.text = profile.level.rawValue
        experienceLabel.text = "\(profile.experience) experience points"
        
        // Налаштування прогресу
        let currentLevelExp = profile.experience
        let nextLevelExp = profile.level.requiredExperience
        let progress = Float(currentLevelExp) / Float(nextLevelExp)
        progressView.progress = progress
        
        // Аватар
        avatarImageView.image = UIImage(systemName: "person.circle.fill")
        avatarImageView.tintColor = UIColor.systemPurple
    }
}
