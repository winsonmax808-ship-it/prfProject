//
//  PerfumeDetailViewController.swift
//  prfProject
//
//  Created by artem on 15.09.2025.
//

import UIKit

class PerfumeDetailViewController: UIViewController {
    
    private let perfume: Perfume
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    
    private let imageView = UIImageView()
    private let nameLabel = UILabel()
    private let brandLabel = UILabel()
    private let yearLabel = UILabel()
    private let ratingLabel = UILabel()
    private let priceLabel = UILabel()
    private let descriptionLabel = UILabel()
    private let notesStackView = UIStackView()
    private let detailsStackView = UIStackView()
    private let favoriteButton = UIButton(type: .system)
    
    init(perfume: Perfume) {
        self.perfume = perfume
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupConstraints()
        configureWithPerfume()
    }
    
    private func setupUI() {
        view.backgroundColor = UIColor.systemBackground
        title = perfume.name
        
        // Navigation setup
        navigationController?.navigationBar.prefersLargeTitles = false
        
        // Favorite button
        favoriteButton.setImage(UIImage(systemName: "heart"), for: .normal)
        favoriteButton.tintColor = UIColor.systemRed
        favoriteButton.addTarget(self, action: #selector(favoriteButtonTapped), for: .touchUpInside)
        let favoriteBarButton = UIBarButtonItem(customView: favoriteButton)
        navigationItem.rightBarButtonItem = favoriteBarButton
        
        // Scroll view setup
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        // Image view
        imageView.backgroundColor = UIColor.systemGray6
        imageView.layer.cornerRadius = 12
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        // Labels setup
        nameLabel.font = UIFont.systemFont(ofSize: 28, weight: .bold)
        nameLabel.textColor = UIColor.label
        nameLabel.numberOfLines = 0
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        brandLabel.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        brandLabel.textColor = UIColor.secondaryLabel
        brandLabel.translatesAutoresizingMaskIntoConstraints = false
        
        yearLabel.font = UIFont.systemFont(ofSize: 16)
        yearLabel.textColor = UIColor.tertiaryLabel
        yearLabel.translatesAutoresizingMaskIntoConstraints = false
        
        ratingLabel.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        ratingLabel.textColor = UIColor.systemOrange
        ratingLabel.translatesAutoresizingMaskIntoConstraints = false
        
        priceLabel.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        priceLabel.textColor = UIColor.systemGreen
        priceLabel.translatesAutoresizingMaskIntoConstraints = false
        
        descriptionLabel.font = UIFont.systemFont(ofSize: 16)
        descriptionLabel.textColor = UIColor.label
        descriptionLabel.numberOfLines = 0
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        
        // Notes stack view
        notesStackView.axis = .vertical
        notesStackView.spacing = 16
        notesStackView.translatesAutoresizingMaskIntoConstraints = false
        
        // Details stack view
        detailsStackView.axis = .vertical
        detailsStackView.spacing = 12
        detailsStackView.translatesAutoresizingMaskIntoConstraints = false
        
        // Add subviews
        contentView.addSubview(imageView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(brandLabel)
        contentView.addSubview(yearLabel)
        contentView.addSubview(ratingLabel)
        contentView.addSubview(priceLabel)
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(notesStackView)
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
            
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            imageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 200),
            imageView.heightAnchor.constraint(equalToConstant: 200),
            
            nameLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 20),
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            brandLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 8),
            brandLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            brandLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            yearLabel.topAnchor.constraint(equalTo: brandLabel.bottomAnchor, constant: 4),
            yearLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            yearLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            ratingLabel.topAnchor.constraint(equalTo: yearLabel.bottomAnchor, constant: 12),
            ratingLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            
            priceLabel.topAnchor.constraint(equalTo: yearLabel.bottomAnchor, constant: 12),
            priceLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            descriptionLabel.topAnchor.constraint(equalTo: ratingLabel.bottomAnchor, constant: 20),
            descriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            descriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            notesStackView.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 24),
            notesStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            notesStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            detailsStackView.topAnchor.constraint(equalTo: notesStackView.bottomAnchor, constant: 24),
            detailsStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            detailsStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            detailsStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20)
        ])
    }
    
    private func configureWithPerfume() {
        // Basic info
        nameLabel.text = perfume.name
        brandLabel.text = perfume.brand
        yearLabel.text = "Released in \(perfume.year)"
        ratingLabel.text = "⭐ \(String(format: "%.1f", perfume.rating))"
        priceLabel.text = perfume.priceRange.rawValue
        descriptionLabel.text = perfume.description
        
        // Image placeholder
        imageView.image = UIImage(systemName: "sparkles")
        imageView.tintColor = UIColor.systemPurple
        
        // Notes sections
        setupNotesSections()
        
        // Details sections
        setupDetailsSections()
    }
    
    private func setupNotesSections() {
        // Top Notes
        let topNotesView = createNotesSection(title: "Top Notes", notes: perfume.topNotes, color: .systemYellow)
        notesStackView.addArrangedSubview(topNotesView)
        
        // Middle Notes
        let middleNotesView = createNotesSection(title: "Middle Notes", notes: perfume.middleNotes, color: .systemPink)
        notesStackView.addArrangedSubview(middleNotesView)
        
        // Base Notes
        let baseNotesView = createNotesSection(title: "Base Notes", notes: perfume.baseNotes, color: .systemBrown)
        notesStackView.addArrangedSubview(baseNotesView)
    }
    
    private func createNotesSection(title: String, notes: [String], color: UIColor) -> UIView {
        let containerView = UIView()
        containerView.backgroundColor = color.withAlphaComponent(0.1)
        containerView.layer.cornerRadius = 12
        containerView.layer.borderWidth = 1
        containerView.layer.borderColor = color.withAlphaComponent(0.3).cgColor
        containerView.translatesAutoresizingMaskIntoConstraints = false
        
        let titleLabel = UILabel()
        titleLabel.text = title
        titleLabel.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        titleLabel.textColor = color
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let notesLabel = UILabel()
        notesLabel.text = notes.joined(separator: ", ")
        notesLabel.font = UIFont.systemFont(ofSize: 14)
        notesLabel.textColor = UIColor.label
        notesLabel.numberOfLines = 0
        notesLabel.translatesAutoresizingMaskIntoConstraints = false
        
        containerView.addSubview(titleLabel)
        containerView.addSubview(notesLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 16),
            titleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
            
            notesLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            notesLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            notesLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
            notesLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -16)
        ])
        
        return containerView
    }
    
    private func setupDetailsSections() {
        // Gender
        let genderView = createDetailRow(title: "Gender", value: perfume.gender.rawValue, icon: "person.fill")
        detailsStackView.addArrangedSubview(genderView)
        
        // Concentration
        let concentrationView = createDetailRow(title: "Concentration", value: perfume.concentration.rawValue, icon: "drop.fill")
        detailsStackView.addArrangedSubview(concentrationView)
        
        // Longevity
        let longevityView = createDetailRow(title: "Longevity", value: perfume.longevity.rawValue, icon: "clock.fill")
        detailsStackView.addArrangedSubview(longevityView)
        
        // Sillage
        let sillageView = createDetailRow(title: "Sillage", value: perfume.sillage.rawValue, icon: "wind")
        detailsStackView.addArrangedSubview(sillageView)
        
        // Seasons
        let seasonsView = createDetailRow(title: "Seasons", value: perfume.seasonality.map { $0.rawValue }.joined(separator: ", "), icon: "calendar")
        detailsStackView.addArrangedSubview(seasonsView)
        
        // Occasions
        let occasionsView = createDetailRow(title: "Occasions", value: perfume.occasion.map { $0.rawValue }.joined(separator: ", "), icon: "star.fill")
        detailsStackView.addArrangedSubview(occasionsView)
    }
    
    private func createDetailRow(title: String, value: String, icon: String) -> UIView {
        let containerView = UIView()
        containerView.backgroundColor = UIColor.systemGray6
        containerView.layer.cornerRadius = 8
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
        valueLabel.font = UIFont.systemFont(ofSize: 14)
        valueLabel.textColor = UIColor.secondaryLabel
        valueLabel.numberOfLines = 0
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
            titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 12),
            titleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
            
            valueLabel.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: 12),
            valueLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
            valueLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
            valueLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -12)
        ])
        
        return containerView
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
