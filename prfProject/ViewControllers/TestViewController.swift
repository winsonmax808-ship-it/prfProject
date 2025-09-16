//
//  TestViewController.swift
//  prfProject
//
//  Created by artem on 15.09.2025.
//

import UIKit

class TestViewController: UIViewController {
    
    private let test: Test
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    private let progressView = UIProgressView()
    private let questionLabel = UILabel()
    private let optionsStackView = UIStackView()
    private let nextButton = UIButton(type: .system)
    private let timerLabel = UILabel()
    
    private var currentQuestionIndex = 0
    private var selectedAnswer: Int?
    private var userAnswers: [Int] = []
    private var startTime: Date?
    private var timer: Timer?
    
    init(test: Test) {
        self.test = test
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupConstraints()
        startTest()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        timer?.invalidate()
    }
    
    private func setupUI() {
        view.backgroundColor = UIColor.systemBackground
        title = test.title
        
        navigationController?.navigationBar.prefersLargeTitles = false
        
        // Cancel button
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .cancel,
            target: self,
            action: #selector(cancelTest)
        )
        
        // Scroll view setup
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        // Progress view
        progressView.progressTintColor = UIColor.systemBlue
        progressView.trackTintColor = UIColor.systemGray5
        progressView.layer.cornerRadius = 2
        progressView.clipsToBounds = true
        progressView.translatesAutoresizingMaskIntoConstraints = false
        
        // Timer label
        timerLabel.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        timerLabel.textColor = UIColor.systemBlue
        timerLabel.textAlignment = .center
        timerLabel.translatesAutoresizingMaskIntoConstraints = false
        
        // Question label
        questionLabel.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        questionLabel.textColor = UIColor.label
        questionLabel.numberOfLines = 0
        questionLabel.textAlignment = .center
        questionLabel.translatesAutoresizingMaskIntoConstraints = false
        
        // Options stack view
        optionsStackView.axis = .vertical
        optionsStackView.spacing = 12
        optionsStackView.translatesAutoresizingMaskIntoConstraints = false
        
        // Next button
        nextButton.setTitle("Next", for: .normal)
        nextButton.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        nextButton.backgroundColor = UIColor.systemBlue
        nextButton.setTitleColor(.white, for: .normal)
        nextButton.layer.cornerRadius = 12
        nextButton.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
        nextButton.isEnabled = false
        nextButton.alpha = 0.5
        nextButton.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(progressView)
        contentView.addSubview(timerLabel)
        contentView.addSubview(questionLabel)
        contentView.addSubview(optionsStackView)
        contentView.addSubview(nextButton)
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
            
            progressView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            progressView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            progressView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            progressView.heightAnchor.constraint(equalToConstant: 4),
            
            timerLabel.topAnchor.constraint(equalTo: progressView.bottomAnchor, constant: 16),
            timerLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            
            questionLabel.topAnchor.constraint(equalTo: timerLabel.bottomAnchor, constant: 24),
            questionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            questionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            optionsStackView.topAnchor.constraint(equalTo: questionLabel.bottomAnchor, constant: 32),
            optionsStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            optionsStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            nextButton.topAnchor.constraint(equalTo: optionsStackView.bottomAnchor, constant: 32),
            nextButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            nextButton.widthAnchor.constraint(equalToConstant: 120),
            nextButton.heightAnchor.constraint(equalToConstant: 50),
            nextButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20)
        ])
    }
    
    private func startTest() {
        startTime = Date()
        userAnswers = Array(repeating: -1, count: test.questions.count)
        
        if let timeLimit = test.timeLimit {
            startTimer(timeLimit: timeLimit)
        }
        
        showCurrentQuestion()
    }
    
    private func startTimer(timeLimit: Int) {
        let totalSeconds = timeLimit * 60
        var remainingSeconds = totalSeconds
        
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] _ in
            remainingSeconds -= 1
            
            let minutes = remainingSeconds / 60
            let seconds = remainingSeconds % 60
            self?.timerLabel.text = String(format: "%02d:%02d", minutes, seconds)
            
            if remainingSeconds <= 0 {
                self?.finishTest()
            }
        }
    }
    
    private func showCurrentQuestion() {
        let question = test.questions[currentQuestionIndex]
        
        // Update progress
        let progress = Float(currentQuestionIndex) / Float(test.questions.count)
        progressView.progress = progress
        
        // Update question
        questionLabel.text = question.text
        
        // Clear previous options
        optionsStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        
        // Add new options
        for (index, option) in question.options.enumerated() {
            let optionButton = createOptionButton(text: option, index: index)
            optionsStackView.addArrangedSubview(optionButton)
        }
        
        // Update next button
        if currentQuestionIndex == test.questions.count - 1 {
            nextButton.setTitle("Finish", for: .normal)
        } else {
            nextButton.setTitle("Next", for: .normal)
        }
        
        nextButton.isEnabled = false
        nextButton.alpha = 0.5
        selectedAnswer = nil
    }
    
    private func createOptionButton(text: String, index: Int) -> UIButton {
        let button = UIButton(type: .system)
        button.setTitle(text, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        button.setTitleColor(UIColor.label, for: .normal)
        button.backgroundColor = UIColor.systemGray6
        button.layer.cornerRadius = 12
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor.clear.cgColor
        button.contentHorizontalAlignment = .left
        button.contentEdgeInsets = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        button.tag = index
        button.addTarget(self, action: #selector(optionSelected(_:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            button.heightAnchor.constraint(greaterThanOrEqualToConstant: 50)
        ])
        
        return button
    }
    
    @objc private func optionSelected(_ sender: UIButton) {
        // Reset previous selection
        optionsStackView.arrangedSubviews.forEach { view in
            if let button = view as? UIButton {
                button.backgroundColor = UIColor.systemGray6
                button.layer.borderColor = UIColor.clear.cgColor
            }
        }
        
        // Select new option
        sender.backgroundColor = UIColor.systemBlue.withAlphaComponent(0.1)
        sender.layer.borderColor = UIColor.systemBlue.cgColor
        selectedAnswer = sender.tag
        
        // Enable next button
        nextButton.isEnabled = true
        nextButton.alpha = 1.0
    }
    
    @objc private func nextButtonTapped() {
        guard let selectedAnswer = selectedAnswer else { return }
        
        // Save answer
        userAnswers[currentQuestionIndex] = selectedAnswer
        
        // Move to next question or finish
        if currentQuestionIndex < test.questions.count - 1 {
            currentQuestionIndex += 1
            showCurrentQuestion()
        } else {
            finishTest()
        }
    }
    
    @objc private func cancelTest() {
        let alert = UIAlertController(title: "Cancel Test", message: "Are you sure you want to cancel? Your progress will be lost.", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Continue Test", style: .cancel))
        alert.addAction(UIAlertAction(title: "Cancel", style: .destructive) { _ in
            self.navigationController?.popViewController(animated: true)
        })
        
        present(alert, animated: true)
    }
    
    private func finishTest() {
        timer?.invalidate()
        
        let endTime = Date()
        let timeSpent = Int(endTime.timeIntervalSince(startTime ?? Date()))
        
        // Calculate score
        var correctAnswers = 0
        for (index, answer) in userAnswers.enumerated() {
            if answer == test.questions[index].correctAnswer {
                correctAnswers += 1
            }
        }
        
        let result = TestResult(
            testId: test.id,
            userId: UUID(), // In real app, get from user session
            score: correctAnswers,
            totalQuestions: test.questions.count,
            timeSpent: timeSpent
        )
        
        // Show results
        let resultsVC = TestResultsViewController(result: result, test: test)
        navigationController?.pushViewController(resultsVC, animated: true)
    }
}
