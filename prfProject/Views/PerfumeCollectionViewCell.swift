//
//  PerfumeCollectionViewCell.swift
//  prfProject
//
//  Created by artem on 15.09.2025.
//

import UIKit

class PerfumeCollectionViewCell: UICollectionViewCell {
    
    private let containerView = UIView()
    private let imageView = UIImageView()
    private let nameLabel = UILabel()
    private let brandLabel = UILabel()
    private let ratingLabel = UILabel()
    private let priceLabel = UILabel()
    private let favoriteButton = UIButton(type: .system)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        // Container view
        containerView.backgroundColor = UIColor.systemBackground
        containerView.layer.cornerRadius = 12
        containerView.layer.shadowColor = UIColor.black.cgColor
        containerView.layer.shadowOffset = CGSize(width: 0, height: 2)
        containerView.layer.shadowOpacity = 0.1
        containerView.layer.shadowRadius = 4
        containerView.translatesAutoresizingMaskIntoConstraints = false
        
        // Image view
        imageView.backgroundColor = UIColor.systemGray6
        imageView.layer.cornerRadius = 8
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        // Name label
        nameLabel.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        nameLabel.textColor = UIColor.label
        nameLabel.numberOfLines = 2
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        // Brand label
        brandLabel.font = UIFont.systemFont(ofSize: 14)
        brandLabel.textColor = UIColor.secondaryLabel
        brandLabel.translatesAutoresizingMaskIntoConstraints = false
        
        // Rating label
        ratingLabel.font = UIFont.systemFont(ofSize: 12)
        ratingLabel.textColor = UIColor.systemOrange
        ratingLabel.translatesAutoresizingMaskIntoConstraints = false
        
        // Price label
        priceLabel.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        priceLabel.textColor = UIColor.systemGreen
        priceLabel.translatesAutoresizingMaskIntoConstraints = false
        
        // Favorite button
        favoriteButton.setImage(UIImage(systemName: "heart"), for: .normal)
        favoriteButton.tintColor = UIColor.systemGray
        favoriteButton.addTarget(self, action: #selector(favoriteButtonTapped), for: .touchUpInside)
        favoriteButton.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(containerView)
        containerView.addSubview(imageView)
        containerView.addSubview(nameLabel)
        containerView.addSubview(brandLabel)
        containerView.addSubview(ratingLabel)
        containerView.addSubview(priceLabel)
        containerView.addSubview(favoriteButton)
        
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            imageView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 12),
            imageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 12),
            imageView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -12),
            imageView.heightAnchor.constraint(equalToConstant: 120),
            
            favoriteButton.topAnchor.constraint(equalTo: imageView.topAnchor, constant: 8),
            favoriteButton.trailingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: -8),
            favoriteButton.widthAnchor.constraint(equalToConstant: 30),
            favoriteButton.heightAnchor.constraint(equalToConstant: 30),
            
            nameLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 8),
            nameLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 12),
            nameLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -12),
            
            brandLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 4),
            brandLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 12),
            brandLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -12),
            
            ratingLabel.topAnchor.constraint(equalTo: brandLabel.bottomAnchor, constant: 4),
            ratingLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 12),
            
            priceLabel.topAnchor.constraint(equalTo: brandLabel.bottomAnchor, constant: 4),
            priceLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -12),
            priceLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -12)
        ])
    }
    
    func configure(with perfume: Perfume) {
        nameLabel.text = perfume.name
        brandLabel.text = perfume.brand
        ratingLabel.text = "⭐ \(String(format: "%.1f", perfume.rating))"
        priceLabel.text = perfume.priceRange.rawValue
        
        // Заглушка для зображення
        imageView.image = UIImage(systemName: "sparkles")
        imageView.tintColor = UIColor.systemPurple
    }
    
    @objc private func favoriteButtonTapped() {
        // Тут буде логіка додавання до улюблених
        let isFavorite = favoriteButton.tintColor == UIColor.systemRed
        favoriteButton.tintColor = isFavorite ? UIColor.systemGray : UIColor.systemRed
        favoriteButton.setImage(UIImage(systemName: isFavorite ? "heart" : "heart.fill"), for: .normal)
    }
}
