//
//  TestsListViewController.swift
//  prfProject
//
//  Created by artem on 15.09.2025.
//

import UIKit

class TestsListViewController: UIViewController {
    
    private let category: TestCategory
    private let tableView = UITableView(frame: .zero, style: .grouped)
    private let tests: [Test]
    
    init(category: TestCategory) {
        self.category = category
        self.tests = TestManager.getTests(for: category)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupTableView()
    }
    
    private func setupUI() {
        view.backgroundColor = UIColor.systemBackground
        title = category.rawValue
        
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = UIColor.systemBackground
        tableView.separatorStyle = .singleLine
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        tableView.register(TestTableViewCell.self, forCellReuseIdentifier: "TestCell")
        
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

// MARK: - UITableViewDataSource
extension TestsListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tests.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TestCell", for: indexPath) as! TestTableViewCell
        cell.configure(with: tests[indexPath.row])
        return cell
    }
}

// MARK: - UITableViewDelegate
extension TestsListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let test = tests[indexPath.row]
        let testVC = TestViewController(test: test)
        navigationController?.pushViewController(testVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}

// MARK: - Test Manager
class TestManager {
    static func getTests(for category: TestCategory) -> [Test] {
        switch category {
        case .basics:
            return [
            Test(
                title: "Perfume Basics Quiz",
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
                    ),
                    Question(
                        text: "What is the main purpose of base notes?",
                        options: ["To create first impression", "To provide longevity", "To add freshness", "To make it lighter"],
                        correctAnswer: 1,
                        explanation: "Base notes provide the lasting impression and longevity of a fragrance."
                    ),
                    Question(
                        text: "What does 'sillage' mean in perfumery?",
                        options: ["The scent trail left behind", "The bottle design", "The price range", "The brand name"],
                        correctAnswer: 0,
                        explanation: "Sillage refers to the scent trail or aura that a perfume leaves behind as you move."
                    ),
                    Question(
                        text: "Which concentration typically lasts the longest?",
                        options: ["Eau de Cologne", "Eau de Toilette", "Eau de Parfum", "All last the same"],
                        correctAnswer: 2,
                        explanation: "Eau de Parfum has higher concentration of fragrance oils, making it last longer."
                    ),
                    Question(
                        text: "What are the three main note categories?",
                        options: ["Top, Middle, Base", "Light, Medium, Heavy", "Fresh, Floral, Woody", "Sweet, Spicy, Fresh"],
                        correctAnswer: 0,
                        explanation: "The three main note categories are Top notes, Middle notes, and Base notes."
                    ),
                    Question(
                        text: "How should you apply perfume for best results?",
                        options: ["Rub it into skin", "Spray on pulse points", "Apply all over body", "Only on clothes"],
                        correctAnswer: 1,
                        explanation: "Apply perfume on pulse points like wrists, neck, and behind ears for best diffusion."
                    ),
                    Question(
                        text: "What is the ideal storage condition for perfumes?",
                        options: ["Hot and humid", "Cold and dry", "Room temperature and dry", "Anywhere is fine"],
                        correctAnswer: 2,
                        explanation: "Store perfumes at room temperature in a dry place away from direct sunlight."
                    )
                ],
                passingScore: 5,
                timeLimit: 15
            ),
                Test(
                    title: "Fragrance Families",
                    description: "Learn about different fragrance families",
                    category: .basics,
                    difficulty: .intermediate,
                    questions: [
                        Question(
                            text: "Which family does Chanel No. 5 belong to?",
                            options: ["Oriental", "Floral", "Woody", "Fresh"],
                            correctAnswer: 1,
                            explanation: "Chanel No. 5 is a classic floral fragrance."
                        ),
                        Question(
                            text: "What characterizes Oriental fragrances?",
                            options: ["Light and fresh", "Heavy and spicy", "Sweet and floral", "Woody and earthy"],
                            correctAnswer: 1,
                            explanation: "Oriental fragrances are characterized by heavy, spicy, and exotic notes."
                        ),
                        Question(
                            text: "Which family typically includes citrus notes?",
                            options: ["Oriental", "Floral", "Fresh", "Woody"],
                            correctAnswer: 2,
                            explanation: "Fresh fragrances typically include citrus, aquatic, and green notes."
                        ),
                        Question(
                            text: "What are the main notes in Woody fragrances?",
                            options: ["Citrus and floral", "Wood and moss", "Spice and vanilla", "Rose and jasmine"],
                            correctAnswer: 1,
                            explanation: "Woody fragrances feature wood, moss, and earthy notes as their foundation."
                        ),
                        Question(
                            text: "Which fragrance family is most popular for summer?",
                            options: ["Oriental", "Floral", "Fresh", "Woody"],
                            correctAnswer: 2,
                            explanation: "Fresh fragrances with citrus and aquatic notes are most popular in summer."
                        )
                    ],
                    passingScore: 3,
                    timeLimit: 20
                )
            ]
            
        case .notes:
            return [
                Test(
                    title: "Note Recognition Challenge",
                    description: "Test your ability to recognize different fragrance notes",
                    category: .notes,
                    difficulty: .intermediate,
                    questions: [
                        Question(
                            text: "Which note is most commonly used as a base?",
                            options: ["Rose", "Vanilla", "Bergamot", "Jasmine"],
                            correctAnswer: 1,
                            explanation: "Vanilla is often used as a base note due to its persistence and appeal."
                        ),
                        Question(
                            text: "What type of note is bergamot?",
                            options: ["Base note", "Middle note", "Top note", "Fixative"],
                            correctAnswer: 2,
                            explanation: "Bergamot is a citrus top note that provides freshness."
                        ),
                        Question(
                            text: "Which note is typically found in masculine fragrances?",
                            options: ["Rose", "Jasmine", "Vetiver", "Lily"],
                            correctAnswer: 2,
                            explanation: "Vetiver is a woody note commonly used in masculine fragrances."
                        ),
                        Question(
                            text: "What is the main characteristic of top notes?",
                            options: ["They last the longest", "They evaporate quickly", "They are the strongest", "They are synthetic"],
                            correctAnswer: 1,
                            explanation: "Top notes evaporate quickly and are the first scents you smell."
                        ),
                        Question(
                            text: "Which note family does sandalwood belong to?",
                            options: ["Floral", "Citrus", "Woody", "Spicy"],
                            correctAnswer: 2,
                            explanation: "Sandalwood is a woody note with creamy and soft characteristics."
                        ),
                        Question(
                            text: "What is the primary function of middle notes?",
                            options: ["To evaporate quickly", "To form the heart of the fragrance", "To last the longest", "To mask other notes"],
                            correctAnswer: 1,
                            explanation: "Middle notes form the heart of the fragrance and emerge after top notes fade."
                        ),
                        Question(
                            text: "Which note is known for its aphrodisiac properties?",
                            options: ["Lemon", "Rose", "Musk", "Bergamot"],
                            correctAnswer: 2,
                            explanation: "Musk is known for its sensual and aphrodisiac properties."
                        )
                    ],
                    passingScore: 4,
                    timeLimit: 18
                )
            ]
            
        case .brands:
            return [
                Test(
                    title: "Perfume Brands Quiz",
                    description: "Test your knowledge of famous perfume houses",
                    category: .brands,
                    difficulty: .intermediate,
                    questions: [
                        Question(
                            text: "Which brand created the iconic fragrance 'Wild Spirit'?",
                            options: ["Luxe Parfums", "Modern Fragrances", "Luxury Scents", "Royal Fragrances"],
                            correctAnswer: 1,
                            explanation: "Wild Spirit was created by Modern Fragrances and launched in 2015."
                        ),
                        Question(
                            text: "Which house created 'Elegance No. 5'?",
                            options: ["Modern Fragrances", "Luxe Parfums", "Elegant Fragrances", "Royal Fragrances"],
                            correctAnswer: 1,
                            explanation: "Elegance No. 5 was created by Luxe Parfums in 2021."
                        ),
                        Question(
                            text: "Which brand is known for 'Midnight Orchid' fragrance?",
                            options: ["Luxe Parfums", "Modern Fragrances", "Luxury Scents", "Elegant Fragrances"],
                            correctAnswer: 2,
                            explanation: "Midnight Orchid is a famous fragrance by Luxury Scents."
                        ),
                        Question(
                            text: "Which house created 'Free Spirit'?",
                            options: ["Luxe Parfums", "Elegant Fragrances", "Luxury Scents", "Royal Fragrances"],
                            correctAnswer: 1,
                            explanation: "Free Spirit was created by Elegant Fragrances in 2019."
                        ),
                        Question(
                            text: "Which brand is famous for 'Victory'?",
                            options: ["Luxe Parfums", "Modern Fragrances", "Royal Fragrances", "Elegant Fragrances"],
                            correctAnswer: 2,
                            explanation: "Victory is a legendary fragrance by Royal Fragrances, created in 2010."
                        ),
                        Question(
                            text: "Which brand created 'Elegance No. 5'?",
                            options: ["Luxe Parfums", "Modern Fragrances", "Luxury Scents", "Elegant Fragrances"],
                            correctAnswer: 0,
                            explanation: "Elegance No. 5 is a popular fragrance by Luxe Parfums."
                        )
                    ],
                    passingScore: 4,
                    timeLimit: 15
                )
            ]
            
        case .chemistry:
            return [
                Test(
                    title: "Perfume Chemistry Basics",
                    description: "Learn about the science behind fragrances",
                    category: .chemistry,
                    difficulty: .advanced,
                    questions: [
                        Question(
                            text: "What is the main solvent in most perfumes?",
                            options: ["Water", "Alcohol", "Oil", "Glycerin"],
                            correctAnswer: 1,
                            explanation: "Alcohol (ethanol) is the most common solvent in perfumes."
                        ),
                        Question(
                            text: "What are fixatives in perfumery?",
                            options: ["Top notes", "Substances that slow evaporation", "Colorants", "Preservatives"],
                            correctAnswer: 1,
                            explanation: "Fixatives slow down the evaporation of volatile components, making fragrances last longer."
                        ),
                        Question(
                            text: "What percentage of aromatic compounds does Eau de Parfum contain?",
                            options: ["5-15%", "15-20%", "20-30%", "2-5%"],
                            correctAnswer: 1,
                            explanation: "Eau de Parfum contains 15-20% aromatic compounds."
                        ),
                        Question(
                            text: "What is the purpose of aldehydes in perfumes?",
                            options: ["To add color", "To create sparkle and lift", "To preserve", "To thicken"],
                            correctAnswer: 1,
                            explanation: "Aldehydes add sparkle and lift to fragrances, making them more vibrant."
                        ),
                        Question(
                            text: "Which molecule is responsible for the 'clean' smell?",
                            options: ["Musk", "Aldehyde C-12", "Vanillin", "Citral"],
                            correctAnswer: 1,
                            explanation: "Aldehyde C-12 (lauryl aldehyde) is responsible for the clean, soapy smell."
                        )
                    ],
                    passingScore: 3,
                    timeLimit: 20
                )
            ]
            
        case .application:
            return [
                Test(
                    title: "Perfume Application Techniques",
                    description: "Learn proper perfume application methods",
                    category: .application,
                    difficulty: .beginner,
                    questions: [
                        Question(
                            text: "Where should you apply perfume for best results?",
                            options: ["All over body", "Only on clothes", "On pulse points", "On hair only"],
                            correctAnswer: 2,
                            explanation: "Pulse points are the warmest areas and help diffuse the fragrance."
                        ),
                        Question(
                            text: "How far should you hold the perfume bottle when spraying?",
                            options: ["1-2 inches", "6-8 inches", "12 inches", "Any distance"],
                            correctAnswer: 1,
                            explanation: "Hold the bottle 6-8 inches away for even distribution."
                        ),
                        Question(
                            text: "Should you rub perfume into your skin?",
                            options: ["Yes, always", "No, never", "Only for oil-based perfumes", "Only on wrists"],
                            correctAnswer: 1,
                            explanation: "Rubbing can break down fragrance molecules and alter the scent."
                        ),
                        Question(
                            text: "What are the main pulse points for perfume application?",
                            options: ["Elbows and knees", "Wrists, neck, behind ears", "Ankles and feet", "Shoulders only"],
                            correctAnswer: 1,
                            explanation: "Wrists, neck, and behind ears are the main pulse points."
                        ),
                        Question(
                            text: "When is the best time to apply perfume?",
                            options: ["After shower", "Before bed", "In the morning", "Any time"],
                            correctAnswer: 0,
                            explanation: "Apply perfume after shower when skin is clean and slightly moist."
                        ),
                        Question(
                            text: "How many sprays of perfume should you use?",
                            options: ["1-2 sprays", "5-10 sprays", "As many as you want", "Depends on concentration"],
                            correctAnswer: 3,
                            explanation: "The number of sprays depends on the perfume concentration and personal preference."
                        )
                    ],
                    passingScore: 4,
                    timeLimit: 12
                )
            ]
        }
    }
}
