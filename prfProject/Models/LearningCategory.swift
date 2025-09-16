//
//  LearningCategory.swift
//  prfProject
//
//  Created by artem on 15.09.2025.
//

import UIKit

enum LearningCategory: String, CaseIterable, Codable {
    case basics = "Perfume Basics"
    case notes = "Notes & Compositions"
    case application = "Application"
    case storage = "Storage"
    case history = "Perfume History"
    case brands = "Famous Brands"
    
    var description: String {
        switch self {
        case .basics:
            return "Learn the fundamentals of perfumery art"
        case .notes:
            return "Discover different types of fragrance notes"
        case .application:
            return "Proper perfume application techniques"
        case .storage:
            return "How to store perfumes correctly"
        case .history:
            return "History of perfumery development"
        case .brands:
            return "Legendary perfume houses"
        }
    }
    
    var icon: String {
        switch self {
        case .basics: return "book.fill"
        case .notes: return "leaf.fill"
        case .application: return "hand.tap.fill"
        case .storage: return "archivebox.fill"
        case .history: return "clock.fill"
        case .brands: return "building.2.fill"
        }
    }
    
    var color: UIColor {
        switch self {
        case .basics: return .systemBlue
        case .notes: return .systemGreen
        case .application: return .systemPurple
        case .storage: return .systemOrange
        case .history: return .systemBrown
        case .brands: return .systemRed
        }
    }
}
