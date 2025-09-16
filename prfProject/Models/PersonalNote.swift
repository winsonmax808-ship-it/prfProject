//
//  PersonalNote.swift
//  prfProject
//
//  Created by artem on 15.09.2025.
//

import Foundation

struct PersonalNote: Codable, Identifiable {
    let id: UUID
    let userId: UUID
    let perfumeId: UUID?
    let title: String
    let content: String
    let category: PersonalNoteCategory
    let tags: [String]
    let rating: Int? // 1-5 зірок
    let weather: WeatherCondition?
    let mood: Mood?
    let occasion: Occasion?
    let longevity: Longevity?
    let sillage: Sillage?
    let createdAt: Date
    let updatedAt: Date
    let isFavorite: Bool
    
    init(id: UUID = UUID(), userId: UUID, perfumeId: UUID? = nil, title: String, content: String, category: PersonalNoteCategory, tags: [String] = [], rating: Int? = nil, weather: WeatherCondition? = nil, mood: Mood? = nil, occasion: Occasion? = nil, longevity: Longevity? = nil, sillage: Sillage? = nil, createdAt: Date = Date(), updatedAt: Date = Date(), isFavorite: Bool = false) {
        self.id = id
        self.userId = userId
        self.perfumeId = perfumeId
        self.title = title
        self.content = content
        self.category = category
        self.tags = tags
        self.rating = rating
        self.weather = weather
        self.mood = mood
        self.occasion = occasion
        self.longevity = longevity
        self.sillage = sillage
        self.createdAt = createdAt
        self.updatedAt = updatedAt
        self.isFavorite = isFavorite
    }
}

enum PersonalNoteCategory: String, CaseIterable, Codable {
    case review = "Review"
    case observation = "Observation"
    case comparison = "Comparison"
    case wishlist = "Wishlist"
    case gift = "Gift"
    case memory = "Memory"
    case tip = "Tip"
}

enum WeatherCondition: String, CaseIterable, Codable {
    case sunny = "Sunny"
    case cloudy = "Cloudy"
    case rainy = "Rainy"
    case snowy = "Snowy"
    case windy = "Windy"
    case hot = "Hot"
    case cold = "Cold"
}

enum Mood: String, CaseIterable, Codable {
    case happy = "Happy"
    case sad = "Sad"
    case excited = "Excited"
    case calm = "Calm"
    case romantic = "Romantic"
    case confident = "Confident"
    case nostalgic = "Nostalgic"
    case energetic = "Energetic"
}
