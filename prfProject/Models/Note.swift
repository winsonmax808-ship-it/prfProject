//
//  Note.swift
//  prfProject
//
//  Created by artem on 15.09.2025.
//

import Foundation

struct Note: Codable, Identifiable {
    let id: UUID
    let name: String
    let category: NoteCategory
    let description: String
    let origin: NoteOrigin
    let intensity: Intensity
    let commonIn: [String] // Бренди або парфуми
    let imageURL: String?
    
    init(id: UUID = UUID(), name: String, category: NoteCategory, description: String, origin: NoteOrigin, intensity: Intensity, commonIn: [String] = [], imageURL: String? = nil) {
        self.id = id
        self.name = name
        self.category = category
        self.description = description
        self.origin = origin
        self.intensity = intensity
        self.commonIn = commonIn
        self.imageURL = imageURL
    }
}

enum NoteCategory: String, CaseIterable, Codable {
    case top = "Top Notes"
    case middle = "Middle Notes"
    case base = "Base Notes"
}

enum NoteOrigin: String, CaseIterable, Codable {
    case natural = "Natural"
    case synthetic = "Synthetic"
    case mixed = "Mixed"
}

enum Intensity: String, CaseIterable, Codable {
    case light = "Light"
    case moderate = "Moderate"
    case strong = "Strong"
    case overpowering = "Overpowering"
}

// Popular notes for quick access
struct PopularNotes {
    static let topNotes = [
        "Bergamot", "Lemon", "Orange", "Grapefruit", "Mint", "Lavender", "Rosemary", "Eucalyptus"
    ]
    
    static let middleNotes = [
        "Rose", "Jasmine", "Lily", "Iris", "Lavender", "Violet", "Peony", "Magnolia"
    ]
    
    static let baseNotes = [
        "Sandalwood", "Patchouli", "Vanilla", "Musk", "Amber", "Wood", "Cedar", "Vetiver"
    ]
}
