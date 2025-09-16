//
//  ProfileStatsCell.swift
//  prfProject
//
//  Created by artem on 15.09.2025.
//

import UIKit

class ProfileStatsCell: UITableViewCell {
    
    private let containerView = UIView()
    private let statsStackView = UIStackView()
    
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
        
        // Stats stack view
        statsStackView.axis = .horizontal
        statsStackView.distribution = .fillEqually
        statsStackView.spacing = 16
        statsStackView.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(containerView)
        containerView.addSubview(statsStackView)
        
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            
            statsStackView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 16),
            statsStackView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            statsStackView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
            statsStackView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -16)
        ])
    }
    
    func configure(with profile: UserProfile) {
        // Очищаємо попередні view
        statsStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        
        let stats = [
            ("Tests passed", "\(profile.completedTests.count)", UIColor.systemBlue),
            ("Notes", "\(profile.favoriteNotes.count)", UIColor.systemGreen),
            ("Favorites", "\(profile.favoritePerfumes.count)", UIColor.systemRed),
            ("Achievements", "\(profile.achievements.count)", UIColor.systemOrange)
        ]
        
        for stat in stats {
            let statView = createStatView(title: stat.0, value: stat.1, color: stat.2)
            statsStackView.addArrangedSubview(statView)
        }
    }
    
    private func createStatView(title: String, value: String, color: UIColor) -> UIView {
        let containerView = UIView()
        
        let valueLabel = UILabel()
        valueLabel.text = value
        valueLabel.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        valueLabel.textColor = color
        valueLabel.textAlignment = .center
        valueLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let titleLabel = UILabel()
        titleLabel.text = title
        titleLabel.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        titleLabel.textColor = UIColor.secondaryLabel
        titleLabel.textAlignment = .center
        titleLabel.numberOfLines = 0
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        containerView.addSubview(valueLabel)
        containerView.addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            valueLabel.topAnchor.constraint(equalTo: containerView.topAnchor),
            valueLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            valueLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            
            titleLabel.topAnchor.constraint(equalTo: valueLabel.bottomAnchor, constant: 4),
            titleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor)
        ])
        
        return containerView
    }
}
