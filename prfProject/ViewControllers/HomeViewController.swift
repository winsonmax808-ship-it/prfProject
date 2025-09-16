//
//  HomeViewController.swift
//  prfProject
//
//  Created by artem on 15.09.2025.
//

import UIKit

class HomeViewController: UIViewController {
    
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    
    private let welcomeLabel = UILabel()
    private let dailyTipCard = UIView()
    private let quickStatsCard = UIView()
    private let recentActivityCard = UIView()
    private let featuredPerfumesCard = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupConstraints()
        loadData()
    }
    
    private func setupUI() {
        view.backgroundColor = UIColor.systemBackground
        title = "Perfume Master"
        
        // Налаштування навігації
        navigationController?.navigationBar.prefersLargeTitles = true
        
        // Налаштування scroll view
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        // Welcome text
        welcomeLabel.text = "Welcome to the world of perfumery! 🌸"
        welcomeLabel.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        welcomeLabel.textColor = UIColor.label
        welcomeLabel.textAlignment = .center
        welcomeLabel.numberOfLines = 0
        welcomeLabel.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(welcomeLabel)
        
        // Створення карток
        setupDailyTipCard()
        setupQuickStatsCard()
        setupRecentActivityCard()
        setupFeaturedPerfumesCard()
    }
    
    private func setupDailyTipCard() {
        dailyTipCard.backgroundColor = UIColor.systemPurple.withAlphaComponent(0.1)
        dailyTipCard.layer.cornerRadius = 16
        dailyTipCard.layer.borderWidth = 1
        dailyTipCard.layer.borderColor = UIColor.systemPurple.withAlphaComponent(0.3).cgColor
        dailyTipCard.translatesAutoresizingMaskIntoConstraints = false
        
        let titleLabel = UILabel()
        titleLabel.text = "💡 Tip of the Day"
        titleLabel.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        titleLabel.textColor = UIColor.label
        
        let tipLabel = UILabel()
        tipLabel.text = "For better fragrance development, apply perfume to pulse points: wrists, neck, behind ears."
        tipLabel.font = UIFont.systemFont(ofSize: 14)
        tipLabel.textColor = UIColor.secondaryLabel
        tipLabel.numberOfLines = 0
        
        [titleLabel, tipLabel].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            dailyTipCard.addSubview($0)
        }
        
        contentView.addSubview(dailyTipCard)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: dailyTipCard.topAnchor, constant: 16),
            titleLabel.leadingAnchor.constraint(equalTo: dailyTipCard.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: dailyTipCard.trailingAnchor, constant: -16),
            
            tipLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            tipLabel.leadingAnchor.constraint(equalTo: dailyTipCard.leadingAnchor, constant: 16),
            tipLabel.trailingAnchor.constraint(equalTo: dailyTipCard.trailingAnchor, constant: -16),
            tipLabel.bottomAnchor.constraint(equalTo: dailyTipCard.bottomAnchor, constant: -16)
        ])
    }
    
    private func setupQuickStatsCard() {
        quickStatsCard.backgroundColor = UIColor.systemBlue.withAlphaComponent(0.1)
        quickStatsCard.layer.cornerRadius = 16
        quickStatsCard.layer.borderWidth = 1
        quickStatsCard.layer.borderColor = UIColor.systemBlue.withAlphaComponent(0.3).cgColor
        quickStatsCard.translatesAutoresizingMaskIntoConstraints = false
        
        let titleLabel = UILabel()
        titleLabel.text = "📊 Your Statistics"
        titleLabel.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        titleLabel.textColor = UIColor.label
        
        let statsStackView = UIStackView()
        statsStackView.axis = .horizontal
        statsStackView.distribution = .fillEqually
        statsStackView.spacing = 16
        
        let testsStat = createStatView(title: "Tests Passed", value: "0", color: .systemBlue)
        let notesStat = createStatView(title: "Notes", value: "0", color: .systemGreen)
        let favoritesStat = createStatView(title: "Favorites", value: "0", color: .systemOrange)
        
        statsStackView.addArrangedSubview(testsStat)
        statsStackView.addArrangedSubview(notesStat)
        statsStackView.addArrangedSubview(favoritesStat)
        
        [titleLabel, statsStackView].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            quickStatsCard.addSubview($0)
        }
        
        contentView.addSubview(quickStatsCard)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: quickStatsCard.topAnchor, constant: 16),
            titleLabel.leadingAnchor.constraint(equalTo: quickStatsCard.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: quickStatsCard.trailingAnchor, constant: -16),
            
            statsStackView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16),
            statsStackView.leadingAnchor.constraint(equalTo: quickStatsCard.leadingAnchor, constant: 16),
            statsStackView.trailingAnchor.constraint(equalTo: quickStatsCard.trailingAnchor, constant: -16),
            statsStackView.bottomAnchor.constraint(equalTo: quickStatsCard.bottomAnchor, constant: -16)
        ])
    }
    
    private func createStatView(title: String, value: String, color: UIColor) -> UIView {
        let containerView = UIView()
        
        let valueLabel = UILabel()
        valueLabel.text = value
        valueLabel.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        valueLabel.textColor = color
        valueLabel.textAlignment = .center
        
        let titleLabel = UILabel()
        titleLabel.text = title
        titleLabel.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        titleLabel.textColor = UIColor.secondaryLabel
        titleLabel.textAlignment = .center
        titleLabel.numberOfLines = 0
        
        [valueLabel, titleLabel].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            containerView.addSubview($0)
        }
        
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
    
    private func setupRecentActivityCard() {
        recentActivityCard.backgroundColor = UIColor.systemGreen.withAlphaComponent(0.1)
        recentActivityCard.layer.cornerRadius = 16
        recentActivityCard.layer.borderWidth = 1
        recentActivityCard.layer.borderColor = UIColor.systemGreen.withAlphaComponent(0.3).cgColor
        recentActivityCard.translatesAutoresizingMaskIntoConstraints = false
        
        let titleLabel = UILabel()
        titleLabel.text = "🕒 Recent Activity"
        titleLabel.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        titleLabel.textColor = UIColor.label
        
        let activityLabel = UILabel()
        activityLabel.text = "You don't have any activity yet. Start by taking tests or adding notes!"
        activityLabel.font = UIFont.systemFont(ofSize: 14)
        activityLabel.textColor = UIColor.secondaryLabel
        activityLabel.numberOfLines = 0
        
        [titleLabel, activityLabel].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            recentActivityCard.addSubview($0)
        }
        
        contentView.addSubview(recentActivityCard)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: recentActivityCard.topAnchor, constant: 16),
            titleLabel.leadingAnchor.constraint(equalTo: recentActivityCard.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: recentActivityCard.trailingAnchor, constant: -16),
            
            activityLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            activityLabel.leadingAnchor.constraint(equalTo: recentActivityCard.leadingAnchor, constant: 16),
            activityLabel.trailingAnchor.constraint(equalTo: recentActivityCard.trailingAnchor, constant: -16),
            activityLabel.bottomAnchor.constraint(equalTo: recentActivityCard.bottomAnchor, constant: -16)
        ])
    }
    
    private func setupFeaturedPerfumesCard() {
        featuredPerfumesCard.backgroundColor = UIColor.systemOrange.withAlphaComponent(0.1)
        featuredPerfumesCard.layer.cornerRadius = 16
        featuredPerfumesCard.layer.borderWidth = 1
        featuredPerfumesCard.layer.borderColor = UIColor.systemOrange.withAlphaComponent(0.3).cgColor
        featuredPerfumesCard.translatesAutoresizingMaskIntoConstraints = false
        
        let titleLabel = UILabel()
        titleLabel.text = "⭐ Recommended Perfumes"
        titleLabel.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        titleLabel.textColor = UIColor.label
        
        let subtitleLabel = UILabel()
        subtitleLabel.text = "Popular fragrances this month"
        subtitleLabel.font = UIFont.systemFont(ofSize: 14)
        subtitleLabel.textColor = UIColor.secondaryLabel
        
        let exploreButton = UIButton(type: .system)
        exploreButton.setTitle("Explore →", for: .normal)
        exploreButton.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        exploreButton.setTitleColor(UIColor.systemOrange, for: .normal)
        exploreButton.addTarget(self, action: #selector(explorePerfumesTapped), for: .touchUpInside)
        
        [titleLabel, subtitleLabel, exploreButton].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            featuredPerfumesCard.addSubview($0)
        }
        
        contentView.addSubview(featuredPerfumesCard)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: featuredPerfumesCard.topAnchor, constant: 16),
            titleLabel.leadingAnchor.constraint(equalTo: featuredPerfumesCard.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: featuredPerfumesCard.trailingAnchor, constant: -16),
            
            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
            subtitleLabel.leadingAnchor.constraint(equalTo: featuredPerfumesCard.leadingAnchor, constant: 16),
            subtitleLabel.trailingAnchor.constraint(equalTo: featuredPerfumesCard.trailingAnchor, constant: -16),
            
            exploreButton.topAnchor.constraint(equalTo: subtitleLabel.bottomAnchor, constant: 12),
            exploreButton.leadingAnchor.constraint(equalTo: featuredPerfumesCard.leadingAnchor, constant: 16),
            exploreButton.bottomAnchor.constraint(equalTo: featuredPerfumesCard.bottomAnchor, constant: -16)
        ])
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
            
            welcomeLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            welcomeLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            welcomeLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            dailyTipCard.topAnchor.constraint(equalTo: welcomeLabel.bottomAnchor, constant: 24),
            dailyTipCard.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            dailyTipCard.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            quickStatsCard.topAnchor.constraint(equalTo: dailyTipCard.bottomAnchor, constant: 16),
            quickStatsCard.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            quickStatsCard.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            recentActivityCard.topAnchor.constraint(equalTo: quickStatsCard.bottomAnchor, constant: 16),
            recentActivityCard.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            recentActivityCard.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            featuredPerfumesCard.topAnchor.constraint(equalTo: recentActivityCard.bottomAnchor, constant: 16),
            featuredPerfumesCard.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            featuredPerfumesCard.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            featuredPerfumesCard.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20)
        ])
    }
    
    private func loadData() {
        // Тут буде завантаження реальних даних
        // Поки що використовуємо заглушки
    }
    
    @objc private func explorePerfumesTapped() {
        tabBarController?.selectedIndex = 1 // Переходимо до каталогу
    }
}
