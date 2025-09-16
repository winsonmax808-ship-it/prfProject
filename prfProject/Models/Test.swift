//
//  Test.swift
//  prfProject
//
//  Created by artem on 15.09.2025.
//

import Foundation

struct Test: Codable, Identifiable {
    let id: UUID
    let title: String
    let description: String
    let category: TestCategory
    let difficulty: Difficulty
    let questions: [Question]
    let passingScore: Int
    let timeLimit: Int? // в хвилинах
    let isPremium: Bool
    
    init(id: UUID = UUID(), title: String, description: String, category: TestCategory, difficulty: Difficulty, questions: [Question], passingScore: Int, timeLimit: Int? = nil, isPremium: Bool = false) {
        self.id = id
        self.title = title
        self.description = description
        self.category = category
        self.difficulty = difficulty
        self.questions = questions
        self.passingScore = passingScore
        self.timeLimit = timeLimit
        self.isPremium = isPremium
    }
}

struct Question: Codable, Identifiable {
    let id: UUID
    let text: String
    let options: [String]
    let correctAnswer: Int
    let explanation: String
    let imageURL: String?
    
    init(id: UUID = UUID(), text: String, options: [String], correctAnswer: Int, explanation: String, imageURL: String? = nil) {
        self.id = id
        self.text = text
        self.options = options
        self.correctAnswer = correctAnswer
        self.explanation = explanation
        self.imageURL = imageURL
    }
}

enum TestCategory: String, CaseIterable, Codable {
    case basics = "Perfume Basics"
    case notes = "Notes & Compositions"
    case brands = "Brands & History"
    case chemistry = "Perfume Chemistry"
    case application = "Application & Storage"
}

enum Difficulty: String, CaseIterable, Codable {
    case beginner = "Beginner"
    case intermediate = "Intermediate"
    case advanced = "Advanced"
    case expert = "Expert"
}

struct TestResult: Codable, Identifiable {
    let id: UUID
    let testId: UUID
    let userId: UUID
    let score: Int
    let totalQuestions: Int
    let percentage: Double
    let timeSpent: Int // в секундах
    let completedAt: Date
    let passed: Bool
    
    init(id: UUID = UUID(), testId: UUID, userId: UUID, score: Int, totalQuestions: Int, timeSpent: Int, completedAt: Date = Date()) {
        self.id = id
        self.testId = testId
        self.userId = userId
        self.score = score
        self.totalQuestions = totalQuestions
        self.percentage = Double(score) / Double(totalQuestions) * 100
        self.timeSpent = timeSpent
        self.completedAt = completedAt
        self.passed = percentage >= 70.0
    }
}
