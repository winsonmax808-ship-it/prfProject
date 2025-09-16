//
//  NoteDetailViewController.swift
//  prfProject
//
//  Created by artem on 15.09.2025.
//

import UIKit

class NoteDetailViewController: UIViewController {
    
    private let note: PersonalNote
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    
    private let headerView = UIView()
    private let titleLabel = UILabel()
    private let categoryLabel = UILabel()
    private let dateLabel = UILabel()
    private let contentLabel = UILabel()
    private let tagsStackView = UIStackView()
    private let detailsStackView = UIStackView()
    private let favoriteButton = UIButton(type: .system)
    
    init(note: PersonalNote) {
        self.note = note
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupConstraints()
        configureWithNote()
    }
    
    private func setupUI() {
        view.backgroundColor = UIColor.systemBackground
        title = "Note Details"
        
        navigationController?.navigationBar.prefersLargeTitles = false
        
        // Edit button
        let editButton = UIBarButtonItem(
            barButtonSystemItem: .edit,
            target: self,
            action: #selector(editButtonTapped)
        )
        navigationItem.rightBarButtonItem = editButton
        
        // Scroll view setup
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        // Header view
        headerView.backgroundColor = colorForCategory(note.category).withAlphaComponent(0.1)
        headerView.layer.cornerRadius = 16
        headerView.layer.borderWidth = 1
        headerView.layer.borderColor = colorForCategory(note.category).withAlphaComponent(0.3).cgColor
        headerView.translatesAutoresizingMaskIntoConstraints = false
        
        // Title label
        titleLabel.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        titleLabel.textColor = UIColor.label
        titleLabel.numberOfLines = 0
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        // Category label
        categoryLabel.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        categoryLabel.textColor = colorForCategory(note.category)
        categoryLabel.translatesAutoresizingMaskIntoConstraints = false
        
        // Date label
        dateLabel.font = UIFont.systemFont(ofSize: 14)
        dateLabel.textColor = UIColor.secondaryLabel
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        
        // Content label
        contentLabel.font = UIFont.systemFont(ofSize: 16)
        contentLabel.textColor = UIColor.label
        contentLabel.numberOfLines = 0
        contentLabel.translatesAutoresizingMaskIntoConstraints = false
        
        // Tags stack view
        tagsStackView.axis = .horizontal
        tagsStackView.spacing = 8
        tagsStackView.translatesAutoresizingMaskIntoConstraints = false
        
        // Details stack view
        detailsStackView.axis = .vertical
        detailsStackView.spacing = 12
        detailsStackView.translatesAutoresizingMaskIntoConstraints = false
        
        // Favorite button
        favoriteButton.setImage(UIImage(systemName: note.isFavorite ? "heart.fill" : "heart"), for: .normal)
        favoriteButton.tintColor = note.isFavorite ? UIColor.systemRed : UIColor.systemGray
        favoriteButton.addTarget(self, action: #selector(favoriteButtonTapped), for: .touchUpInside)
        favoriteButton.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(headerView)
        headerView.addSubview(titleLabel)
        headerView.addSubview(categoryLabel)
        headerView.addSubview(dateLabel)
        headerView.addSubview(favoriteButton)
        contentView.addSubview(contentLabel)
        contentView.addSubview(tagsStackView)
        contentView.addSubview(detailsStackView)
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
            titleLabel.trailingAnchor.constraint(equalTo: favoriteButton.leadingAnchor, constant: -8),
            
            categoryLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            categoryLabel.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 20),
            categoryLabel.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -20),
            
            dateLabel.topAnchor.constraint(equalTo: categoryLabel.bottomAnchor, constant: 4),
            dateLabel.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 20),
            dateLabel.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -20),
            dateLabel.bottomAnchor.constraint(equalTo: headerView.bottomAnchor, constant: -20),
            
            favoriteButton.topAnchor.constraint(equalTo: headerView.topAnchor, constant: 20),
            favoriteButton.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -20),
            favoriteButton.widthAnchor.constraint(equalToConstant: 30),
            favoriteButton.heightAnchor.constraint(equalToConstant: 30),
            
            contentLabel.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 24),
            contentLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            contentLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            tagsStackView.topAnchor.constraint(equalTo: contentLabel.bottomAnchor, constant: 16),
            tagsStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            tagsStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            detailsStackView.topAnchor.constraint(equalTo: tagsStackView.bottomAnchor, constant: 24),
            detailsStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            detailsStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            detailsStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20)
        ])
    }
    
    private func configureWithNote() {
        titleLabel.text = note.title
        categoryLabel.text = note.category.rawValue
        dateLabel.text = formatDate(note.createdAt)
        contentLabel.text = note.content.isEmpty ? "No content" : note.content
        
        // Setup tags
        setupTags()
        
        // Setup details
        setupDetails()
    }
    
    private func setupTags() {
        for tag in note.tags {
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
    
    private func setupDetails() {
        // Rating
        if let rating = note.rating {
            let ratingView = createDetailRow(title: "Rating", value: "\(rating)/5 ⭐", icon: "star.fill")
            detailsStackView.addArrangedSubview(ratingView)
        }
        
        // Weather
        if let weather = note.weather {
            let weatherView = createDetailRow(title: "Weather", value: weather.rawValue, icon: "cloud.sun.fill")
            detailsStackView.addArrangedSubview(weatherView)
        }
        
        // Mood
        if let mood = note.mood {
            let moodView = createDetailRow(title: "Mood", value: mood.rawValue, icon: "face.smiling.fill")
            detailsStackView.addArrangedSubview(moodView)
        }
        
        // Occasion
        if let occasion = note.occasion {
            let occasionView = createDetailRow(title: "Occasion", value: occasion.rawValue, icon: "calendar")
            detailsStackView.addArrangedSubview(occasionView)
        }
        
        // Longevity
        if let longevity = note.longevity {
            let longevityView = createDetailRow(title: "Longevity", value: longevity.rawValue, icon: "clock.fill")
            detailsStackView.addArrangedSubview(longevityView)
        }
        
        // Sillage
        if let sillage = note.sillage {
            let sillageView = createDetailRow(title: "Sillage", value: sillage.rawValue, icon: "wind")
            detailsStackView.addArrangedSubview(sillageView)
        }
    }
    
    private func createDetailRow(title: String, value: String, icon: String) -> UIView {
        let containerView = UIView()
        containerView.backgroundColor = UIColor.systemGray6
        containerView.layer.cornerRadius = 12
        containerView.translatesAutoresizingMaskIntoConstraints = false
        
        let iconImageView = UIImageView()
        iconImageView.image = UIImage(systemName: icon)
        iconImageView.tintColor = UIColor.systemPurple
        iconImageView.contentMode = .scaleAspectFit
        iconImageView.translatesAutoresizingMaskIntoConstraints = false
        
        let titleLabel = UILabel()
        titleLabel.text = title
        titleLabel.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        titleLabel.textColor = UIColor.label
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let valueLabel = UILabel()
        valueLabel.text = value
        valueLabel.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        valueLabel.textColor = UIColor.label
        valueLabel.textAlignment = .right
        valueLabel.translatesAutoresizingMaskIntoConstraints = false
        
        containerView.addSubview(iconImageView)
        containerView.addSubview(titleLabel)
        containerView.addSubview(valueLabel)
        
        NSLayoutConstraint.activate([
            containerView.heightAnchor.constraint(equalToConstant: 60),
            
            iconImageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            iconImageView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            iconImageView.widthAnchor.constraint(equalToConstant: 24),
            iconImageView.heightAnchor.constraint(equalToConstant: 24),
            
            titleLabel.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: 12),
            titleLabel.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            
            valueLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
            valueLabel.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            valueLabel.leadingAnchor.constraint(greaterThanOrEqualTo: titleLabel.trailingAnchor, constant: 8)
        ])
        
        return containerView
    }
    
    private func colorForCategory(_ category: PersonalNoteCategory) -> UIColor {
        switch category {
        case .review: return .systemBlue
        case .observation: return .systemGreen
        case .comparison: return .systemPurple
        case .wishlist: return .systemOrange
        case .gift: return .systemRed
        case .memory: return .systemTeal
        case .tip: return .systemIndigo
        }
    }
    
    private func formatDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter.string(from: date)
    }
    
    @objc private func editButtonTapped() {
        let alert = UIAlertController(title: "Edit Note", message: "Note editing will be implemented in the next version.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
    
    @objc private func favoriteButtonTapped() {
        let isFavorite = favoriteButton.tintColor == UIColor.systemRed
        favoriteButton.tintColor = isFavorite ? UIColor.systemGray : UIColor.systemRed
        favoriteButton.setImage(UIImage(systemName: isFavorite ? "heart" : "heart.fill"), for: .normal)
        
        // Add haptic feedback
        let impactFeedback = UIImpactFeedbackGenerator(style: .medium)
        impactFeedback.impactOccurred()
        
        // Show toast message
        showToast(message: isFavorite ? "Removed from favorites" : "Added to favorites")
    }
    
    private func showToast(message: String) {
        let toast = UILabel()
        toast.text = message
        toast.textColor = UIColor.white
        toast.backgroundColor = UIColor.black.withAlphaComponent(0.8)
        toast.textAlignment = .center
        toast.font = UIFont.systemFont(ofSize: 14)
        toast.layer.cornerRadius = 8
        toast.clipsToBounds = true
        toast.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(toast)
        
        NSLayoutConstraint.activate([
            toast.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            toast.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50),
            toast.heightAnchor.constraint(equalToConstant: 40),
            toast.widthAnchor.constraint(equalToConstant: 200)
        ])
        
        UIView.animate(withDuration: 0.3, animations: {
            toast.alpha = 1
        }) { _ in
            UIView.animate(withDuration: 0.3, delay: 1.5, options: [], animations: {
                toast.alpha = 0
            }) { _ in
                toast.removeFromSuperview()
            }
        }
    }
}
