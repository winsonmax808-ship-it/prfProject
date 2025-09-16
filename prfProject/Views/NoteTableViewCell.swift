//
//  NoteTableViewCell.swift
//  prfProject
//
//  Created by artem on 15.09.2025.
//

import UIKit

class NoteTableViewCell: UITableViewCell {
    
    private let containerView = UIView()
    private let categoryIconView = UIView()
    private let categoryLabel = UILabel()
    private let titleLabel = UILabel()
    private let contentLabel = UILabel()
    private let dateLabel = UILabel()
    private let ratingStackView = UIStackView()
    private let tagsStackView = UIStackView()
    
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
        containerView.layer.shadowOffset = CGSize(width: 0, height: 1)
        containerView.layer.shadowOpacity = 0.05
        containerView.layer.shadowRadius = 2
        containerView.translatesAutoresizingMaskIntoConstraints = false
        
        // Category icon view
        categoryIconView.layer.cornerRadius = 8
        categoryIconView.translatesAutoresizingMaskIntoConstraints = false
        
        // Category label
        categoryLabel.font = UIFont.systemFont(ofSize: 10, weight: .medium)
        categoryLabel.textColor = UIColor.white
        categoryLabel.textAlignment = .center
        categoryLabel.translatesAutoresizingMaskIntoConstraints = false
        
        // Title label
        titleLabel.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        titleLabel.textColor = UIColor.label
        titleLabel.numberOfLines = 2
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        // Content label
        contentLabel.font = UIFont.systemFont(ofSize: 14)
        contentLabel.textColor = UIColor.secondaryLabel
        contentLabel.numberOfLines = 0
        contentLabel.translatesAutoresizingMaskIntoConstraints = false
        
        // Date label
        dateLabel.font = UIFont.systemFont(ofSize: 12)
        dateLabel.textColor = UIColor.tertiaryLabel
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        
        // Rating stack view
        ratingStackView.axis = .horizontal
        ratingStackView.spacing = 2
        ratingStackView.translatesAutoresizingMaskIntoConstraints = false
        
        // Tags stack view
        tagsStackView.axis = .horizontal
        tagsStackView.spacing = 4
        tagsStackView.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(containerView)
        containerView.addSubview(categoryIconView)
        categoryIconView.addSubview(categoryLabel)
        containerView.addSubview(titleLabel)
        containerView.addSubview(contentLabel)
        containerView.addSubview(dateLabel)
        containerView.addSubview(ratingStackView)
        containerView.addSubview(tagsStackView)
        
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12),
            
            categoryIconView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 12),
            categoryIconView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 12),
            categoryIconView.widthAnchor.constraint(equalToConstant: 50),
            categoryIconView.heightAnchor.constraint(equalToConstant: 20),
            
            categoryLabel.centerXAnchor.constraint(equalTo: categoryIconView.centerXAnchor),
            categoryLabel.centerYAnchor.constraint(equalTo: categoryIconView.centerYAnchor),
            categoryLabel.leadingAnchor.constraint(equalTo: categoryIconView.leadingAnchor, constant: 4),
            categoryLabel.trailingAnchor.constraint(equalTo: categoryIconView.trailingAnchor, constant: -4),
            
            titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 16),
            titleLabel.leadingAnchor.constraint(equalTo: categoryIconView.trailingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
            
            contentLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            contentLabel.leadingAnchor.constraint(equalTo: categoryIconView.trailingAnchor, constant: 16),
            contentLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
            
            dateLabel.topAnchor.constraint(equalTo: contentLabel.bottomAnchor, constant: 12),
            dateLabel.leadingAnchor.constraint(equalTo: categoryIconView.trailingAnchor, constant: 16),
            
            ratingStackView.topAnchor.constraint(equalTo: contentLabel.bottomAnchor, constant: 12),
            ratingStackView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
            
            tagsStackView.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 12),
            tagsStackView.leadingAnchor.constraint(equalTo: categoryIconView.trailingAnchor, constant: 16),
            tagsStackView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
            tagsStackView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -16)
        ])
    }
    
    func configure(with note: PersonalNote) {
        titleLabel.text = note.title
        contentLabel.text = note.content
        dateLabel.text = formatDate(note.createdAt)
        
        // Category
        categoryLabel.text = note.category.rawValue
        categoryIconView.backgroundColor = colorForCategory(note.category)
        
        // Rating
        setupRatingStars(rating: note.rating)
        
        // Tags
        setupTags(tags: note.tags)
    }
    
    private func formatDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .none
        return formatter.string(from: date)
    }
    
    private func colorForCategory(_ category: PersonalNoteCategory) -> UIColor {
        switch category {
        case .review: return .systemBlue
        case .observation: return .systemGreen
        case .comparison: return .systemPurple
        case .wishlist: return .systemOrange
        case .gift: return .systemRed
        case .memory: return .systemBrown
        case .tip: return .systemTeal
        }
    }
    
    private func setupRatingStars(rating: Int?) {
        ratingStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        
        guard let rating = rating else { return }
        
        for i in 1...5 {
            let starImageView = UIImageView()
            starImageView.image = UIImage(systemName: i <= rating ? "star.fill" : "star")
            starImageView.tintColor = UIColor.systemYellow
            starImageView.contentMode = .scaleAspectFit
            starImageView.translatesAutoresizingMaskIntoConstraints = false
            
            NSLayoutConstraint.activate([
                starImageView.widthAnchor.constraint(equalToConstant: 12),
                starImageView.heightAnchor.constraint(equalToConstant: 12)
            ])
            
            ratingStackView.addArrangedSubview(starImageView)
        }
    }
    
    private func setupTags(tags: [String]) {
        tagsStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        
        for tag in tags.prefix(3) { // Показуємо максимум 3 теги
            let tagLabel = UILabel()
            tagLabel.text = "#\(tag)"
            tagLabel.font = UIFont.systemFont(ofSize: 10)
            tagLabel.textColor = UIColor.systemBlue
            tagLabel.backgroundColor = UIColor.systemBlue.withAlphaComponent(0.1)
            tagLabel.layer.cornerRadius = 4
            tagLabel.clipsToBounds = true
            tagLabel.textAlignment = .center
            tagLabel.translatesAutoresizingMaskIntoConstraints = false
            
            NSLayoutConstraint.activate([
                tagLabel.heightAnchor.constraint(equalToConstant: 16)
            ])
            
            tagsStackView.addArrangedSubview(tagLabel)
        }
    }
}
