//
//  UserProfile.swift
//  prfProject
//
//  Created by artem on 15.09.2025.
//

import Foundation

struct UserProfile: Codable, Identifiable {
    let id: UUID
    var name: String
    var email: String
    var level: UserLevel
    var experience: Int
    var favoriteNotes: [String]
    var favoritePerfumes: [UUID]
    var completedTests: [UUID]
    var achievements: [Achievement]
    var preferences: UserPreferences
    var joinDate: Date
    var lastActiveDate: Date
    
    init(id: UUID = UUID(), name: String, email: String, level: UserLevel = .beginner, experience: Int = 0, favoriteNotes: [String] = [], favoritePerfumes: [UUID] = [], completedTests: [UUID] = [], achievements: [Achievement] = [], preferences: UserPreferences = UserPreferences(), joinDate: Date = Date(), lastActiveDate: Date = Date()) {
        self.id = id
        self.name = name
        self.email = email
        self.level = level
        self.experience = experience
        self.favoriteNotes = favoriteNotes
        self.favoritePerfumes = favoritePerfumes
        self.completedTests = completedTests
        self.achievements = achievements
        self.preferences = preferences
        self.joinDate = joinDate
        self.lastActiveDate = lastActiveDate
    }
}

enum UserLevel: String, CaseIterable, Codable {
    case beginner = "Beginner"
    case enthusiast = "Enthusiast"
    case connoisseur = "Connoisseur"
    case expert = "Expert"
    case master = "Master"
    
    var requiredExperience: Int {
        switch self {
        case .beginner: return 0
        case .enthusiast: return 100
        case .connoisseur: return 500
        case .expert: return 1000
        case .master: return 2000
        }
    }
    
    var color: String {
        switch self {
        case .beginner: return "green"
        case .enthusiast: return "blue"
        case .connoisseur: return "purple"
        case .expert: return "orange"
        case .master: return "gold"
        }
    }
}

struct Achievement: Codable, Identifiable {
    let id: UUID
    let title: String
    let description: String
    let icon: String
    let unlockedAt: Date
    let category: AchievementCategory
    
    init(id: UUID = UUID(), title: String, description: String, icon: String, unlockedAt: Date = Date(), category: AchievementCategory) {
        self.id = id
        self.title = title
        self.description = description
        self.icon = icon
        self.unlockedAt = unlockedAt
        self.category = category
    }
}

enum AchievementCategory: String, CaseIterable, Codable {
    case learning = "Learning"
    case testing = "Testing"
    case exploration = "Exploration"
    case social = "Social"
    case special = "Special"
}

struct UserPreferences: Codable {
    var language: Language
    var notifications: NotificationSettings
    var theme: AppTheme
    var autoSave: Bool
    
    init(language: Language = .ukrainian, notifications: NotificationSettings = NotificationSettings(), theme: AppTheme = .light, autoSave: Bool = true) {
        self.language = language
        self.notifications = notifications
        self.theme = theme
        self.autoSave = autoSave
    }
}

enum Language: String, CaseIterable, Codable {
    case ukrainian = "Ukrainian"
    case english = "English"
}

enum AppTheme: String, CaseIterable, Codable {
    case light = "Light"
    case dark = "Dark"
    case auto = "Auto"
}

struct NotificationSettings: Codable {
    var dailyReminder: Bool
    var testReminders: Bool
    var newContent: Bool
    var achievements: Bool
    
    init(dailyReminder: Bool = true, testReminders: Bool = true, newContent: Bool = true, achievements: Bool = true) {
        self.dailyReminder = dailyReminder
        self.testReminders = testReminders
        self.newContent = newContent
        self.achievements = achievements
    }
}
