//
//  NotesViewController.swift
//  prfProject
//
//  Created by artem on 15.09.2025.
//

import UIKit

class NotesViewController: UIViewController {
    
    private let tableView = UITableView(frame: .zero, style: .grouped)
    private let addButton = UIButton(type: .system)
    
    private var notes: [PersonalNote] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupTableView()
        setupAddButton()
        loadNotes()
    }
    
    private func setupUI() {
        view.backgroundColor = UIColor.systemBackground
        title = "My Notes"
        
        navigationController?.navigationBar.prefersLargeTitles = true
        
        // Search button
        let searchButton = UIBarButtonItem(
            image: UIImage(systemName: "magnifyingglass"),
            style: .plain,
            target: self,
            action: #selector(searchButtonTapped)
        )
        navigationItem.rightBarButtonItem = searchButton
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = UIColor.systemBackground
        tableView.separatorStyle = .singleLine
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        tableView.register(NoteTableViewCell.self, forCellReuseIdentifier: "NoteCell")
        
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -80)
        ])
    }
    
    private func setupAddButton() {
        addButton.setTitle("+ Add Note", for: .normal)
        addButton.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        addButton.backgroundColor = UIColor.systemPurple
        addButton.setTitleColor(.white, for: .normal)
        addButton.layer.cornerRadius = 25
        addButton.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
        addButton.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(addButton)
        
        NSLayoutConstraint.activate([
            addButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            addButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            addButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            addButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    private func loadNotes() {
        // Sample data
        notes = [
            PersonalNote(
                userId: UUID(),
                perfumeId: UUID(),
                title: "First impression of Tea",
                content: "Tried the legendary fragrance for the first time. Very elegant, classic scent. The top notes of aldehydes are quite sharp, but after an hour the beautiful rose with jasmine unfolds.",
                category: .review,
                tags: ["Chanel", "classic", "rose"],
                rating: 4,
                weather: .sunny,
                mood: .happy,
                occasion: .evening,
                longevity: .strong,
                sillage: .moderate
            ),
            PersonalNote(
                userId: UUID(),
                title: "Comparison of citrus notes",
                content: "Tested different citrus notes: bergamot, lemon, grapefruit. Bergamot is the most versatile, lemon is the freshest, and grapefruit is the most original.",
                category: .comparison,
                tags: ["citrus", "notes", "comparison"],
                rating: nil,
                weather: .sunny,
                mood: .excited
            )
        ]
        
        tableView.reloadData()
    }
    
    @objc private func addButtonTapped() {
        let addNoteVC = AddNoteViewController()
        addNoteVC.delegate = self
        let navController = UINavigationController(rootViewController: addNoteVC)
        present(navController, animated: true)
    }
    
    @objc private func searchButtonTapped() {
        let searchVC = NotesSearchViewController()
        let navController = UINavigationController(rootViewController: searchVC)
        present(navController, animated: true)
    }
}

// MARK: - UITableViewDataSource
extension NotesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NoteCell", for: indexPath) as! NoteTableViewCell
        cell.configure(with: notes[indexPath.row])
        return cell
    }
}

// MARK: - UITableViewDelegate
extension NotesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
//        let note = notes[indexPath.row]
//        let detailVC = NoteDetailViewController(note: note)
//        detailVC.delegate = self
//        navigationController?.pushViewController(detailVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            notes.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}

// MARK: - AddNoteViewControllerDelegate
extension NotesViewController: AddNoteViewControllerDelegate {
    func didAddNote(_ note: PersonalNote) {
        notes.insert(note, at: 0)
        tableView.insertRows(at: [IndexPath(row: 0, section: 0)], with: .automatic)
    }
}

// MARK: - NoteDetailViewControllerDelegate
extension NotesViewController: NoteDetailViewControllerDelegate {
    func didUpdateNote(_ note: PersonalNote) {
        if let index = notes.firstIndex(where: { $0.id == note.id }) {
            notes[index] = note
            tableView.reloadRows(at: [IndexPath(row: index, section: 0)], with: .none)
        }
    }
    
    func didDeleteNote(_ note: PersonalNote) {
        if let index = notes.firstIndex(where: { $0.id == note.id }) {
            notes.remove(at: index)
            tableView.deleteRows(at: [IndexPath(row: index, section: 0)], with: .fade)
        }
    }
}
