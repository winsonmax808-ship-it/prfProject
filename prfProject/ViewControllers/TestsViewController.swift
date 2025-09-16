//
//  TestsViewController.swift
//  prfProject
//
//  Created by artem on 15.09.2025.
//

import UIKit

class TestsViewController: UIViewController {
    
    private let tableView = UITableView(frame: .zero, style: .grouped)
    private let categories = TestCategory.allCases
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupTableView()
    }
    
    private func setupUI() {
        view.backgroundColor = UIColor.systemBackground
        title = "Tests & Quizzes"
        
        navigationController?.navigationBar.prefersLargeTitles = true
        
        // Кнопка статистики
        let statsButton = UIBarButtonItem(
            image: UIImage(systemName: "chart.bar.fill"),
            style: .plain,
            target: self,
            action: #selector(statsButtonTapped)
        )
        navigationItem.rightBarButtonItem = statsButton
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = UIColor.systemBackground
        tableView.separatorStyle = .none
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        tableView.register(TestCategoryCell.self, forCellReuseIdentifier: "TestCategoryCell")
        
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    @objc private func statsButtonTapped() {
        let statsVC = TestStatsViewController()
        let navController = UINavigationController(rootViewController: statsVC)
        present(navController, animated: true)
    }
}

// MARK: - UITableViewDataSource
extension TestsViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return categories.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TestCategoryCell", for: indexPath) as! TestCategoryCell
        cell.configure(with: categories[indexPath.section])
        return cell
    }
}

// MARK: - UITableViewDelegate
extension TestsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let category = categories[indexPath.section]
        let testsListVC = TestsListViewController(category: category)
        navigationController?.pushViewController(testsListVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return section == 0 ? 20 : 10
    }
}
