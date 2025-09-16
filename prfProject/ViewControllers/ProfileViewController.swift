//
//  ProfileViewController.swift
//  prfProject
//
//  Created by artem on 15.09.2025.
//

import UIKit

class ProfileViewController: UIViewController {
    
    private let tableView = UITableView(frame: .zero, style: .grouped)
    private let headerView = ProfileHeaderView()
    
    private var userProfile: UserProfile?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupTableView()
        loadUserProfile()
    }
    
    private func setupUI() {
        view.backgroundColor = UIColor.systemBackground
        title = "Profile"
        
        navigationController?.navigationBar.prefersLargeTitles = true
        
        // Settings button
//        let settingsButton = UIBarButtonItem(
//            image: UIImage(systemName: "gearshape.fill"),
//            style: .plain,
//            target: self,
//            action: #selector(settingsButtonTapped)
//        )
//        navigationItem.rightBarButtonItem = settingsButton
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = UIColor.systemBackground
        tableView.separatorStyle = .singleLine
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        tableView.register(ProfileMenuCell.self, forCellReuseIdentifier: "MenuCell")
        tableView.register(ProfileStatsCell.self, forCellReuseIdentifier: "StatsCell")
        
        // Налаштування header view
        headerView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 200)
        tableView.tableHeaderView = headerView
        
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func loadUserProfile() {
        // Sample data
        userProfile = UserProfile(
            name: "Perfume Master", // Загальне ім'я замість особистого
            email: "user@perfumemaster.com",
            level: .enthusiast,
            experience: 250,
            favoriteNotes: ["Rose", "Jasmine", "Vanilla"],
            favoritePerfumes: [],
            completedTests: [],
            achievements: [
                Achievement(
                    title: "First Steps",
                    description: "Created your first note",
                    icon: "note.text",
                    category: .learning
                ),
                Achievement(
                    title: "Curious Learner",
                    description: "Read 5 articles",
                    icon: "book.fill",
                    category: .learning
                )
            ]
        )
        
        headerView.configure(with: userProfile!)
        tableView.reloadData()
    }
    
    @objc private func settingsButtonTapped() {
        let settingsVC = SettingsViewController()
        let navController = UINavigationController(rootViewController: settingsVC)
        present(navController, animated: true)
    }
}

// MARK: - UITableViewDataSource
extension ProfileViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0: return 1 // Статистика
        case 1: return 1 // Тільки About App
        default: return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "StatsCell", for: indexPath) as! ProfileStatsCell
            cell.configure(with: userProfile!)
            return cell
            
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "MenuCell", for: indexPath) as! ProfileMenuCell
            cell.configure(title: "About App", icon: "info.circle.fill", color: UIColor.systemPurple)
            return cell
            
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0: return "Statistics"
        case 1: return "Settings"
        default: return nil
        }
    }
}

// MARK: - UITableViewDelegate
extension ProfileViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        switch indexPath.section {
        case 1:
            // About App
            let aboutVC = AboutViewController()
            navigationController?.pushViewController(aboutVC, animated: true)
        default: break
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 120
        }
        return 50
    }
}
