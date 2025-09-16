//
//  Article.swift
//  prfProject
//
//  Created by artem on 15.09.2025.
//

import Foundation

struct Article: Codable, Identifiable {
    let id: UUID
    let title: String
    let subtitle: String
    let content: String
    let category: LearningCategory
    let difficulty: Difficulty
    let readTime: Int // in minutes
    let imageURL: String?
    let tags: [String]
    let isPremium: Bool
    
    init(id: UUID = UUID(), title: String, subtitle: String, content: String, category: LearningCategory, difficulty: Difficulty, readTime: Int, imageURL: String? = nil, tags: [String] = [], isPremium: Bool = false) {
        self.id = id
        self.title = title
        self.subtitle = subtitle
        self.content = content
        self.category = category
        self.difficulty = difficulty
        self.readTime = readTime
        self.imageURL = imageURL
        self.tags = tags
        self.isPremium = isPremium
    }
}
