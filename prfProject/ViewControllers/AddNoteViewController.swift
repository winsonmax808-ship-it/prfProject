//
//  AddNoteViewController.swift
//  prfProject
//
//  Created by artem on 15.09.2025.
//

import UIKit

class AddNoteViewController: UIViewController {
    
    weak var delegate: AddNoteViewControllerDelegate?
    
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    
    private let titleTextField = UITextField()
    private let contentTextView = UITextView()
    private let categorySegmentedControl = UISegmentedControl(items: PersonalNoteCategory.allCases.map { $0.rawValue })
    private let tagsTextField = UITextField()
    private let ratingStackView = UIStackView()
    private let weatherSegmentedControl = UISegmentedControl(items: WeatherCondition.allCases.map { $0.rawValue })
    private let moodSegmentedControl = UISegmentedControl(items: Mood.allCases.map { $0.rawValue })
    private let occasionSegmentedControl = UISegmentedControl(items: Occasion.allCases.map { $0.rawValue })
    private let longevitySegmentedControl = UISegmentedControl(items: Longevity.allCases.map { $0.rawValue })
    private let sillageSegmentedControl = UISegmentedControl(items: Sillage.allCases.map { $0.rawValue })
    
    private var selectedRating = 0
    private var ratingButtons: [UIButton] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupConstraints()
        setupKeyboardHandling()
    }
    
    private func setupUI() {
        view.backgroundColor = UIColor.systemBackground
        title = "Add Note"
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .cancel,
            target: self,
            action: #selector(cancelTapped)
        )
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .save,
            target: self,
            action: #selector(saveTapped)
        )
        
        // Scroll view setup
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        // Title field
        titleTextField.placeholder = "Note title"
        titleTextField.borderStyle = .roundedRect
        titleTextField.font = UIFont.systemFont(ofSize: 16)
        titleTextField.translatesAutoresizingMaskIntoConstraints = false
        
        // Content text view
        contentTextView.font = UIFont.systemFont(ofSize: 16)
        contentTextView.layer.borderColor = UIColor.systemGray4.cgColor
        contentTextView.layer.borderWidth = 1
        contentTextView.layer.cornerRadius = 8
        contentTextView.text = "Write your thoughts about this fragrance..."
        contentTextView.textColor = UIColor.placeholderText
        contentTextView.translatesAutoresizingMaskIntoConstraints = false
        
        // Category segmented control
        categorySegmentedControl.selectedSegmentIndex = 0
        categorySegmentedControl.translatesAutoresizingMaskIntoConstraints = false
        
        // Tags field
        tagsTextField.placeholder = "Tags (comma separated)"
        tagsTextField.borderStyle = .roundedRect
        tagsTextField.font = UIFont.systemFont(ofSize: 16)
        tagsTextField.translatesAutoresizingMaskIntoConstraints = false
        
        // Rating stack view
        ratingStackView.axis = .horizontal
        ratingStackView.spacing = 8
        ratingStackView.translatesAutoresizingMaskIntoConstraints = false
        
        setupRatingButtons()
        
        // Segmented controls
        weatherSegmentedControl.selectedSegmentIndex = 0
        weatherSegmentedControl.translatesAutoresizingMaskIntoConstraints = false
        
        moodSegmentedControl.selectedSegmentIndex = 0
        moodSegmentedControl.translatesAutoresizingMaskIntoConstraints = false
        
        occasionSegmentedControl.selectedSegmentIndex = 0
        occasionSegmentedControl.translatesAutoresizingMaskIntoConstraints = false
        
        longevitySegmentedControl.selectedSegmentIndex = 0
        longevitySegmentedControl.translatesAutoresizingMaskIntoConstraints = false
        
        sillageSegmentedControl.selectedSegmentIndex = 0
        sillageSegmentedControl.translatesAutoresizingMaskIntoConstraints = false
        
        // Add subviews
        contentView.addSubview(titleTextField)
        contentView.addSubview(contentTextView)
        contentView.addSubview(categorySegmentedControl)
        contentView.addSubview(tagsTextField)
        contentView.addSubview(ratingStackView)
        contentView.addSubview(weatherSegmentedControl)
        contentView.addSubview(moodSegmentedControl)
        contentView.addSubview(occasionSegmentedControl)
        contentView.addSubview(longevitySegmentedControl)
        contentView.addSubview(sillageSegmentedControl)
        
        // Set text view delegate
        contentTextView.delegate = self
    }
    
    private func setupRatingButtons() {
        for i in 1...5 {
            let button = UIButton(type: .system)
            button.setTitle("⭐", for: .normal)
            button.titleLabel?.font = UIFont.systemFont(ofSize: 24)
            button.tag = i
            button.addTarget(self, action: #selector(ratingButtonTapped(_:)), for: .touchUpInside)
            ratingButtons.append(button)
            ratingStackView.addArrangedSubview(button)
        }
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            titleTextField.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            titleTextField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            titleTextField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            titleTextField.heightAnchor.constraint(equalToConstant: 44),
            
            contentTextView.topAnchor.constraint(equalTo: titleTextField.bottomAnchor, constant: 16),
            contentTextView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            contentTextView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            contentTextView.heightAnchor.constraint(equalToConstant: 120),
            
            categorySegmentedControl.topAnchor.constraint(equalTo: contentTextView.bottomAnchor, constant: 16),
            categorySegmentedControl.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            categorySegmentedControl.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            tagsTextField.topAnchor.constraint(equalTo: categorySegmentedControl.bottomAnchor, constant: 16),
            tagsTextField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            tagsTextField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            tagsTextField.heightAnchor.constraint(equalToConstant: 44),
            
            ratingStackView.topAnchor.constraint(equalTo: tagsTextField.bottomAnchor, constant: 16),
            ratingStackView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            
            weatherSegmentedControl.topAnchor.constraint(equalTo: ratingStackView.bottomAnchor, constant: 24),
            weatherSegmentedControl.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            weatherSegmentedControl.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            moodSegmentedControl.topAnchor.constraint(equalTo: weatherSegmentedControl.bottomAnchor, constant: 16),
            moodSegmentedControl.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            moodSegmentedControl.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            occasionSegmentedControl.topAnchor.constraint(equalTo: moodSegmentedControl.bottomAnchor, constant: 16),
            occasionSegmentedControl.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            occasionSegmentedControl.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            longevitySegmentedControl.topAnchor.constraint(equalTo: occasionSegmentedControl.bottomAnchor, constant: 16),
            longevitySegmentedControl.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            longevitySegmentedControl.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            sillageSegmentedControl.topAnchor.constraint(equalTo: longevitySegmentedControl.bottomAnchor, constant: 16),
            sillageSegmentedControl.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            sillageSegmentedControl.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            sillageSegmentedControl.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20)
        ])
    }
    
    private func setupKeyboardHandling() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShow),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillHide),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
    }
    
    @objc private func ratingButtonTapped(_ sender: UIButton) {
        selectedRating = sender.tag
        
        // Update button appearances
        for (index, button) in ratingButtons.enumerated() {
            if index < selectedRating {
                button.setTitle("⭐", for: .normal)
                button.tintColor = UIColor.systemYellow
            } else {
                button.setTitle("☆", for: .normal)
                button.tintColor = UIColor.systemGray
            }
        }
    }
    
    @objc private func keyboardWillShow(notification: NSNotification) {
        guard let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }
        let keyboardHeight = keyboardFrame.cgRectValue.height
        
        scrollView.contentInset.bottom = keyboardHeight
        scrollView.scrollIndicatorInsets.bottom = keyboardHeight
    }
    
    @objc private func keyboardWillHide(notification: NSNotification) {
        scrollView.contentInset.bottom = 0
        scrollView.scrollIndicatorInsets.bottom = 0
    }
    
    @objc private func cancelTapped() {
        dismiss(animated: true)
    }
    
    @objc private func saveTapped() {
        guard let title = titleTextField.text, !title.isEmpty else {
            showAlert(title: "Error", message: "Please enter a title for your note.")
            return
        }
        
        let content = contentTextView.textColor == UIColor.placeholderText ? "" : contentTextView.text ?? ""
        
        let tags = tagsTextField.text?.components(separatedBy: ",").map { $0.trimmingCharacters(in: .whitespaces) }.filter { !$0.isEmpty } ?? []
        
        let category = PersonalNoteCategory.allCases[categorySegmentedControl.selectedSegmentIndex]
        let weather = WeatherCondition.allCases[weatherSegmentedControl.selectedSegmentIndex]
        let mood = Mood.allCases[moodSegmentedControl.selectedSegmentIndex]
        let occasion = Occasion.allCases[occasionSegmentedControl.selectedSegmentIndex]
        let longevity = Longevity.allCases[longevitySegmentedControl.selectedSegmentIndex]
        let sillage = Sillage.allCases[sillageSegmentedControl.selectedSegmentIndex]
        
        let note = PersonalNote(
            userId: UUID(), // In real app, get from user session
            title: title,
            content: content,
            category: category,
            tags: tags,
            rating: selectedRating > 0 ? selectedRating : nil,
            weather: weather,
            mood: mood,
            occasion: occasion,
            longevity: longevity,
            sillage: sillage
        )
        
        delegate?.didAddNote(note)
        dismiss(animated: true)
    }
    
    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}

// MARK: - UITextViewDelegate
extension AddNoteViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.placeholderText {
            textView.text = ""
            textView.textColor = UIColor.label
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "Write your thoughts about this fragrance..."
            textView.textColor = UIColor.placeholderText
        }
    }
}
