//
//  Perfume.swift
//  prfProject
//
//  Created by artem on 15.09.2025.
//

import Foundation

struct Perfume: Codable, Identifiable {
    let id: UUID
    let name: String
    let brand: String
    let year: Int
    let gender: Gender
    let concentration: Concentration
    let topNotes: [String]
    let middleNotes: [String]
    let baseNotes: [String]
    let description: String
    let priceRange: PriceRange
    let seasonality: [Season]
    let occasion: [Occasion]
    let longevity: Longevity
    let sillage: Sillage
    let rating: Double
    let imageURL: String?
    let isPopular: Bool
    let isLimitedEdition: Bool
    
    init(id: UUID = UUID(), name: String, brand: String, year: Int, gender: Gender, concentration: Concentration, topNotes: [String], middleNotes: [String], baseNotes: [String], description: String, priceRange: PriceRange, seasonality: [Season], occasion: [Occasion], longevity: Longevity, sillage: Sillage, rating: Double, imageURL: String? = nil, isPopular: Bool = false, isLimitedEdition: Bool = false) {
        self.id = id
        self.name = name
        self.brand = brand
        self.year = year
        self.gender = gender
        self.concentration = concentration
        self.topNotes = topNotes
        self.middleNotes = middleNotes
        self.baseNotes = baseNotes
        self.description = description
        self.priceRange = priceRange
        self.seasonality = seasonality
        self.occasion = occasion
        self.longevity = longevity
        self.sillage = sillage
        self.rating = rating
        self.imageURL = imageURL
        self.isPopular = isPopular
        self.isLimitedEdition = isLimitedEdition
    }
}

enum Gender: String, CaseIterable, Codable {
    case male = "Male"
    case female = "Female"
    case unisex = "Unisex"
}

enum Concentration: String, CaseIterable, Codable {
    case eauDeCologne = "Eau de Cologne"
    case eauDeToilette = "Eau de Toilette"
    case eauDeParfum = "Eau de Parfum"
    case parfum = "Parfum"
    case extrait = "Extrait"
}

enum PriceRange: String, CaseIterable, Codable {
    case budget = "Budget"
    case midRange = "Mid-Range"
    case premium = "Premium"
    case luxury = "Luxury"
}

enum Season: String, CaseIterable, Codable {
    case spring = "Spring"
    case summer = "Summer"
    case autumn = "Autumn"
    case winter = "Winter"
}

enum Occasion: String, CaseIterable, Codable {
    case daily = "Daily"
    case work = "Work"
    case evening = "Evening"
    case special = "Special"
    case sport = "Sport"
    case romantic = "Romantic"
}

enum Longevity: String, CaseIterable, Codable {
    case weak = "Weak"
    case moderate = "Moderate"
    case strong = "Strong"
    case veryStrong = "Very Strong"
}

enum Sillage: String, CaseIterable, Codable {
    case intimate = "Intimate"
    case moderate = "Moderate"
    case strong = "Strong"
    case powerful = "Powerful"
}
