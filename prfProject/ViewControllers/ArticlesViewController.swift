//
//  ArticlesViewController.swift
//  prfProject
//
//  Created by artem on 15.09.2025.
//

import UIKit
import Foundation

class ArticlesViewController: UIViewController {
    
    private let category: LearningCategory
    private let tableView = UITableView(frame: .zero, style: .grouped)
    private let articles: [Article]
    
    init(category: LearningCategory) {
        self.category = category
        self.articles = ArticleManager.getArticles(for: category)
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
        
        tableView.register(ArticleTableViewCell.self, forCellReuseIdentifier: "ArticleCell")
        
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
extension ArticlesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ArticleCell", for: indexPath) as! ArticleTableViewCell
        cell.configure(with: articles[indexPath.row])
        return cell
    }
}

// MARK: - UITableViewDelegate
extension ArticlesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let article = articles[indexPath.row]
        let articleDetailVC = ArticleDetailViewController(article: article)
        navigationController?.pushViewController(articleDetailVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
}

// MARK: - Article Model
// Article is now defined in Models/Article.swift

// MARK: - Article Manager
class ArticleManager {
    static func getArticles(for category: LearningCategory) -> [Article] {
        switch category {
        case .basics:
            return [
                Article(
                    title: "What is Perfume?",
                    subtitle: "Understanding the basics of fragrance",
                    content: "Perfume is a mixture of fragrant essential oils or aroma compounds, fixatives and solvents, used to give the human body, animals, food, objects, and living spaces an agreeable scent. The word perfume is derived from the Latin perfumare, meaning 'to smoke through'.",
                    category: .basics,
                    difficulty: .beginner,
                    readTime: 5,
                    tags: ["basics", "introduction", "fragrance"]
                ),
                Article(
                    title: "Perfume Concentrations Explained",
                    subtitle: "From Eau de Cologne to Parfum",
                    content: "Perfume concentrations refer to the amount of aromatic compounds in a fragrance. The main concentrations are: Eau de Cologne (2-5%), Eau de Toilette (5-15%), Eau de Parfum (15-20%), and Parfum (20-30%). Higher concentrations mean longer-lasting fragrances.",
                    category: .basics,
                    difficulty: .beginner,
                    readTime: 7,
                    tags: ["concentration", "strength", "longevity"]
                ),
                Article(
                    title: "The Art of Perfume Making",
                    subtitle: "From raw materials to finished product",
                    content: "Creating a perfume is a complex process that involves selecting raw materials, blending them in precise proportions, and allowing the mixture to mature. Master perfumers spend years learning to identify and combine hundreds of different scents.",
                    category: .basics,
                    difficulty: .intermediate,
                    readTime: 10,
                    tags: ["creation", "process", "perfumer"]
                )
            ]
            
        case .notes:
            return [
                Article(
                    title: "Understanding Fragrance Notes",
                    subtitle: "Top, middle, and base notes explained",
                    content: "Fragrance notes are the different scents that can be perceived with the passage of time after the application of a perfume. They are classified into three categories: top notes (immediate impression), middle notes (heart of the fragrance), and base notes (lasting impression).",
                    category: .notes,
                    difficulty: .beginner,
                    readTime: 8,
                    tags: ["notes", "pyramid", "structure"]
                ),
                Article(
                    title: "Popular Top Notes",
                    subtitle: "Citrus, fresh, and aromatic openings",
                    content: "Top notes are the first scents you smell when applying a perfume. Common top notes include citrus fruits like bergamot, lemon, and orange, as well as fresh herbs like mint and lavender. These notes are typically light and evaporate quickly.",
                    category: .notes,
                    difficulty: .beginner,
                    readTime: 6,
                    tags: ["top notes", "citrus", "fresh"]
                ),
                Article(
                    title: "Floral Middle Notes",
                    subtitle: "The heart of feminine fragrances",
                    content: "Middle notes, also called heart notes, form the core of a fragrance and emerge after the top notes fade. Floral middle notes like rose, jasmine, and lily are popular in feminine fragrances, while spices and herbs are common in masculine scents.",
                    category: .notes,
                    difficulty: .intermediate,
                    readTime: 7,
                    tags: ["middle notes", "floral", "heart"]
                )
            ]
            
        case .application:
            return [
                Article(
                    title: "How to Apply Perfume",
                    subtitle: "Techniques for maximum impact",
                    content: "The key to applying perfume is to target pulse points where the skin is warmest: wrists, neck, behind ears, and inside elbows. Spray from a distance of 6-8 inches and avoid rubbing the fragrance into the skin, as this can break down the molecules.",
                    category: .application,
                    difficulty: .beginner,
                    readTime: 5,
                    tags: ["application", "technique", "pulse points"]
                ),
                Article(
                    title: "Perfume Layering",
                    subtitle: "Creating your signature scent",
                    content: "Layering involves combining different fragrances to create a unique scent. Start with a base fragrance and add complementary scents. Use products from the same fragrance family or with similar notes for best results.",
                    category: .application,
                    difficulty: .intermediate,
                    readTime: 8,
                    tags: ["layering", "signature", "combination"]
                )
            ]
            
        case .storage:
            return [
                Article(
                    title: "Proper Perfume Storage",
                    subtitle: "Keeping your fragrances fresh",
                    content: "Store perfumes in cool, dry places away from direct sunlight and heat. Keep bottles upright and tightly closed. Avoid storing in bathrooms due to humidity. Proper storage can extend a perfume's life by several years.",
                    category: .storage,
                    difficulty: .beginner,
                    readTime: 6,
                    tags: ["storage", "preservation", "care"]
                )
            ]
            
        case .history:
            return [
                Article(
                    title: "History of Perfumery",
                    subtitle: "From ancient times to modern day",
                    content: "Perfumery has a rich history dating back to ancient civilizations. The Egyptians used fragrances in religious ceremonies, while the Romans popularized perfumes for personal use. Modern perfumery began in France in the 19th century.",
                    category: .history,
                    difficulty: .intermediate,
                    readTime: 12,
                    tags: ["history", "ancient", "evolution"]
                )
            ]
            
        case .brands:
            return [
                Article(
                    title: "Legendary Perfume Houses",
                    subtitle: "The masters of fragrance",
                    content: "From  timeless elegance to  modern luxury, legendary perfume houses have shaped the industry. Each house has its own signature style and philosophy, creating fragrances that define eras and cultures.",
                    category: .brands,
                    difficulty: .intermediate,
                    readTime: 10,
                    tags: ["brands", "houses", "legends"]
                )
            ]
        }
    }
}
