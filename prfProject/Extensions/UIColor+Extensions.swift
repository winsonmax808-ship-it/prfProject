//
//  UIColor+Extensions.swift
//  prfProject
//
//  Created by artem on 15.09.2025.
//

import UIKit

extension UIColor {
    
    // MARK: - Perfume App Colors
    static let perfumePrimary = UIColor.systemPurple
    static let perfumeSecondary = UIColor.systemBlue
    static let perfumeAccent = UIColor.systemOrange
    
    // MARK: - Gradient Colors
    static let gradientStart = UIColor.systemPurple.withAlphaComponent(0.8)
    static let gradientEnd = UIColor.systemBlue.withAlphaComponent(0.8)
    
    // MARK: - Card Colors
    static let cardBackground = UIColor.systemBackground
    static let cardShadow = UIColor.black.withAlphaComponent(0.1)
    
    // MARK: - Text Colors
    static let primaryText = UIColor.label
    static let secondaryText = UIColor.secondaryLabel
    static let tertiaryText = UIColor.tertiaryLabel
    
    // MARK: - Status Colors
    static let successColor = UIColor.systemGreen
    static let warningColor = UIColor.systemOrange
    static let errorColor = UIColor.systemRed
    static let infoColor = UIColor.systemBlue
    
    // MARK: - Category Colors
    static let topNoteColor = UIColor.systemYellow
    static let middleNoteColor = UIColor.systemPink
    static let baseNoteColor = UIColor.systemBrown
    
    // MARK: - Season Colors
    static let springColor = UIColor.systemGreen
    static let summerColor = UIColor.systemBlue
    static let autumnColor = UIColor.systemOrange
    static let winterColor = UIColor.systemGray
    
    // MARK: - Gender Colors
    static let maleColor = UIColor.systemBlue
    static let femaleColor = UIColor.systemPink
    static let unisexColor = UIColor.systemPurple
    
    // MARK: - Price Range Colors
    static let budgetColor = UIColor.systemGreen
    static let midRangeColor = UIColor.systemBlue
    static let premiumColor = UIColor.systemPurple
    static let luxuryColor = UIColor.systemOrange
    
    // MARK: - Helper Methods
    static func randomColor() -> UIColor {
        let colors: [UIColor] = [
            .systemRed, .systemBlue, .systemGreen, .systemOrange,
            .systemPurple, .systemPink, .systemTeal, .systemIndigo
        ]
        return colors.randomElement() ?? .systemBlue
    }
    
    static func colorForRating(_ rating: Double) -> UIColor {
        switch rating {
        case 4.5...5.0:
            return .systemGreen
        case 3.5..<4.5:
            return .systemBlue
        case 2.5..<3.5:
            return .systemOrange
        default:
            return .systemRed
        }
    }
    
    static func colorForLongevity(_ longevity: Longevity) -> UIColor {
        switch longevity {
        case .weak:
            return .systemRed
        case .moderate:
            return .systemOrange
        case .strong:
            return .systemBlue
        case .veryStrong:
            return .systemGreen
        }
    }
    
    static func colorForSillage(_ sillage: Sillage) -> UIColor {
        switch sillage {
        case .intimate:
            return .systemGray
        case .moderate:
            return .systemBlue
        case .strong:
            return .systemOrange
        case .powerful:
            return .systemRed
        }
    }
}
