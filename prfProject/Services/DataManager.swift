//
//  DataManager.swift
//  prfProject
//
//  Created by artem on 15.09.2025.
//

import Foundation

class DataManager {
    static let shared = DataManager()
    
    private init() {}
    
    // MARK: - Sample Data
    func getSamplePerfumes() -> [Perfume] {
        return [
            Perfume(
                name: "Elegance No. 5",
                brand: "Luxe Parfums",
                year: 2021,
                gender: .female,
                concentration: .eauDeParfum,
                topNotes: ["Aldehydes", "Iris", "Bergamot"],
                middleNotes: ["Rose", "Jasmine", "Lily"],
                baseNotes: ["Sandalwood", "Vanilla", "Musk"],
                description: "Legendary fragrance that became a symbol of elegance and femininity. A timeless classic that remains one of the most popular perfumes in the world.",
                priceRange: .luxury,
                seasonality: [.spring, .autumn],
                occasion: [.evening, .special],
                longevity: .strong,
                sillage: .moderate,
                rating: 4.5,
                isPopular: true
            ),
            Perfume(
                name: "Wild Spirit",
                brand: "Modern Fragrances",
                year: 2015,
                gender: .male,
                concentration: .eauDeToilette,
                topNotes: ["Calabrian Bergamot", "Pepper"],
                middleNotes: ["Sichuan Pepper", "Ambroxan"],
                baseNotes: ["Ambroxan", "Labrador"],
                description: "Wild and attractive fragrance for the modern man. Embodies freedom and adventure with its bold and captivating scent.",
                priceRange: .premium,
                seasonality: [.spring, .summer],
                occasion: [.daily, .evening],
                longevity: .strong,
                sillage: .strong,
                rating: 4.3,
                isPopular: true
            ),
            Perfume(
                name: "Midnight Orchid",
                brand: "Luxury Scents",
                year: 2006,
                gender: .unisex,
                concentration: .eauDeParfum,
                topNotes: ["Black Orchid", "Fig", "Iris"],
                middleNotes: ["Spices", "Flowers"],
                baseNotes: ["Patchouli", "Vanilla", "Incense"],
                description: "Mysterious and sophisticated fragrance for special moments. Black orchid symbolizes luxury and mystery.",
                priceRange: .luxury,
                seasonality: [.autumn, .winter],
                occasion: [.evening, .special],
                longevity: .veryStrong,
                sillage: .powerful,
                rating: 4.7,
                isPopular: true
            ),
            Perfume(
                name: "Free Spirit",
                brand: "Elegant Fragrances",
                year: 2019,
                gender: .female,
                concentration: .eauDeParfum,
                topNotes: ["Lavender", "Black Currant"],
                middleNotes: ["Rose", "Jasmine"],
                baseNotes: ["Vanilla", "Amber"],
                description: "Fragrance of freedom and independence. Symbolizes the modern woman who is not afraid to be herself.",
                priceRange: .premium,
                seasonality: [.spring, .summer],
                occasion: [.daily, .evening],
                longevity: .strong,
                sillage: .moderate,
                rating: 4.2,
                isPopular: true
            ),
            Perfume(
                name: "Victory",
                brand: "Royal Fragrances",
                year: 2010,
                gender: .male,
                concentration: .eauDeParfum,
                topNotes: ["Pineapple", "Black Currant", "Bergamot"],
                middleNotes: ["Rosemary", "Apple", "Birch"],
                baseNotes: ["Oak Moss", "Musk", "Amber"],
                description: "Inspired by legends of strength and success, this fragrance embodies power and achievement.",
                priceRange: .luxury,
                seasonality: [.spring, .summer],
                occasion: [.daily, .work],
                longevity: .veryStrong,
                sillage: .strong,
                rating: 4.6,
                isPopular: true
            )
        ]
    }
    
    func getSampleNotes() -> [Note] {
        return [
            Note(
                name: "Rose",
                category: .middle,
                description: "Classic floral note that symbolizes romance and elegance. Used in many women's perfumes.",
                origin: .natural,
                intensity: .strong,
                commonIn: ["Tea", "Coffe", "Win"]
            ),
            Note(
                name: "Jasmine",
                category: .middle,
                description: "White flower with intense aroma that adds depth and charm to perfumes.",
                origin: .natural,
                intensity: .strong,
                commonIn: ["Win", "Tea", "Coffe"]
            ),
            Note(
                name: "Vanilla",
                category: .base,
                description: "Sweet and warm note that makes the fragrance more attractive and comfortable.",
                origin: .natural,
                intensity: .moderate,
                commonIn: ["Win", "Coffe", "Tea"]
            ),
            Note(
                name: "Bergamot",
                category: .top,
                description: "Fresh citrus aroma that opens many perfumes with its brightness.",
                origin: .natural,
                intensity: .light,
                commonIn: ["Coffe", "Tea", "Win"]
            ),
            Note(
                name: "Sandalwood",
                category: .base,
                description: "Woody note with creamy and soft aroma that adds persistence to perfumes.",
                origin: .natural,
                intensity: .moderate,
                commonIn: ["Tea", "Coffe", "Win"]
            )
        ]
    }
    
    func getSampleTests() -> [Test] {
        return [
            Test(
                title: "Perfume Basics",
                description: "Test your knowledge of basic perfumery concepts",
                category: .basics,
                difficulty: .beginner,
                questions: [
                    Question(
                        text: "What are top notes in perfume?",
                        options: ["Notes that are felt first", "Strongest notes", "Notes at the end", "Weakest notes"],
                        correctAnswer: 0,
                        explanation: "Top notes are the first scents you feel when applying perfume."
                    ),
                    Question(
                        text: "Which perfume concentration is strongest?",
                        options: ["Eau de Toilette", "Eau de Parfum", "Parfum", "Eau de Cologne"],
                        correctAnswer: 2,
                        explanation: "Parfum has the highest concentration of aromatic oils (15-30%)."
                    )
                ],
                passingScore: 1,
                timeLimit: 10
            ),
            Test(
                title: "Note Recognition",
                description: "Learn to recognize different types of notes",
                category: .notes,
                difficulty: .intermediate,
                questions: [
                    Question(
                        text: "Which note is most commonly used as a base?",
                        options: ["Rose", "Vanilla", "Bergamot", "Jasmine"],
                        correctAnswer: 1,
                        explanation: "Vanilla is often used as a base note due to its persistence and appeal."
                    )
                ],
                passingScore: 1,
                timeLimit: 15
            )
        ]
    }
    
    func getSampleUserProfile() -> UserProfile {
        return UserProfile(
            name: "Анна Коваленко",
            email: "anna@example.com",
            level: .enthusiast,
            experience: 250,
            favoriteNotes: ["Троянда", "Жасмін", "Ваніль"],
            favoritePerfumes: [],
            completedTests: [],
            achievements: [
                Achievement(
                    title: "Перші кроки",
                    description: "Створили першу нотатку",
                    icon: "note.text",
                    category: .learning
                ),
                Achievement(
                    title: "Любознатель",
                    description: "Прочитали 5 статей",
                    icon: "book.fill",
                    category: .learning
                ),
                Achievement(
                    title: "Тестувальник",
                    description: "Пройшли перший тест",
                    icon: "brain.head.profile",
                    category: .testing
                )
            ]
        )
    }
}
