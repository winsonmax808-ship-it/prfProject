//
//  TestResultsViewController.swift
//  prfProject
//
//  Created by artem on 15.09.2025.
//

import UIKit

class TestResultsViewController: UIViewController {
    
    private let result: TestResult
    private let test: Test
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    
    private let headerView = UIView()
    private let scoreLabel = UILabel()
    private let percentageLabel = UILabel()
    private let timeLabel = UILabel()
    private let detailsStackView = UIStackView()
    private let reviewButton = UIButton(type: .system)
    private let retakeButton = UIButton(type: .system)
    
    init(result: TestResult, test: Test) {
        self.result = result
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
        configureWithResult()
    }
    
    private func setupUI() {
        view.backgroundColor = UIColor.systemBackground
        title = "Test Results"
        
        navigationController?.navigationBar.prefersLargeTitles = false
        
        // Hide back button and add done button
        navigationItem.hidesBackButton = true
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .done,
            target: self,
            action: #selector(doneButtonTapped)
        )
        
        // Scroll view setup
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        // Header view
        headerView.backgroundColor = getScoreColor().withAlphaComponent(0.1)
        headerView.layer.cornerRadius = 20
        headerView.layer.borderWidth = 2
        headerView.layer.borderColor = getScoreColor().withAlphaComponent(0.3).cgColor
        headerView.translatesAutoresizingMaskIntoConstraints = false
        
        // Score label
        scoreLabel.font = UIFont.systemFont(ofSize: 48, weight: .bold)
        scoreLabel.textColor = getScoreColor()
        scoreLabel.textAlignment = .center
        scoreLabel.translatesAutoresizingMaskIntoConstraints = false
        
        // Percentage label
        percentageLabel.font = UIFont.systemFont(ofSize: 24, weight: .semibold)
        percentageLabel.textColor = UIColor.label
        percentageLabel.textAlignment = .center
        percentageLabel.translatesAutoresizingMaskIntoConstraints = false
        
        // Time label
        timeLabel.font = UIFont.systemFont(ofSize: 16)
        timeLabel.textColor = UIColor.secondaryLabel
        timeLabel.textAlignment = .center
        timeLabel.translatesAutoresizingMaskIntoConstraints = false
        
        // Details stack view
        detailsStackView.axis = .vertical
        detailsStackView.spacing = 16
        detailsStackView.translatesAutoresizingMaskIntoConstraints = false
        
        // Review button
        reviewButton.setTitle("Review Answers", for: .normal)
        reviewButton.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        reviewButton.backgroundColor = UIColor.systemBlue
        reviewButton.setTitleColor(.white, for: .normal)
        reviewButton.layer.cornerRadius = 12
        reviewButton.addTarget(self, action: #selector(reviewButtonTapped), for: .touchUpInside)
        reviewButton.translatesAutoresizingMaskIntoConstraints = false
        
        // Retake button
        retakeButton.setTitle("Retake Test", for: .normal)
        retakeButton.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        retakeButton.backgroundColor = UIColor.systemGray
        retakeButton.setTitleColor(.white, for: .normal)
        retakeButton.layer.cornerRadius = 12
        retakeButton.addTarget(self, action: #selector(retakeButtonTapped), for: .touchUpInside)
        retakeButton.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(headerView)
        headerView.addSubview(scoreLabel)
        headerView.addSubview(percentageLabel)
        headerView.addSubview(timeLabel)
        contentView.addSubview(detailsStackView)
        contentView.addSubview(reviewButton)
        contentView.addSubview(retakeButton)
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
            
            headerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            headerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            headerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            scoreLabel.topAnchor.constraint(equalTo: headerView.topAnchor, constant: 30),
            scoreLabel.centerXAnchor.constraint(equalTo: headerView.centerXAnchor),
            
            percentageLabel.topAnchor.constraint(equalTo: scoreLabel.bottomAnchor, constant: 8),
            percentageLabel.centerXAnchor.constraint(equalTo: headerView.centerXAnchor),
            
            timeLabel.topAnchor.constraint(equalTo: percentageLabel.bottomAnchor, constant: 8),
            timeLabel.centerXAnchor.constraint(equalTo: headerView.centerXAnchor),
            timeLabel.bottomAnchor.constraint(equalTo: headerView.bottomAnchor, constant: -30),
            
            detailsStackView.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 24),
            detailsStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            detailsStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            reviewButton.topAnchor.constraint(equalTo: detailsStackView.bottomAnchor, constant: 32),
            reviewButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            reviewButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            reviewButton.heightAnchor.constraint(equalToConstant: 50),
            
            retakeButton.topAnchor.constraint(equalTo: reviewButton.bottomAnchor, constant: 12),
            retakeButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            retakeButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            retakeButton.heightAnchor.constraint(equalToConstant: 50),
            retakeButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20)
        ])
    }
    
    private func configureWithResult() {
        let percentage = Int((Double(result.score) / Double(result.totalQuestions)) * 100)
        
        scoreLabel.text = "\(result.score)/\(result.totalQuestions)"
        percentageLabel.text = "\(percentage)%"
        
        let minutes = result.timeSpent / 60
        let seconds = result.timeSpent % 60
        timeLabel.text = "Completed in \(minutes)m \(seconds)s"
        
        // Setup details
        setupDetails()
        
        // Add celebration animation for good scores
        if percentage >= 80 {
            addCelebrationAnimation()
        }
    }
    
    private func setupDetails() {
        // Test info
        let testInfoView = createDetailRow(title: "Test", value: test.title, icon: "brain.head.profile")
        detailsStackView.addArrangedSubview(testInfoView)
        
        // Difficulty
        let difficultyView = createDetailRow(title: "Difficulty", value: test.difficulty.rawValue, icon: "star.fill")
        detailsStackView.addArrangedSubview(difficultyView)
        
        // Category
        let categoryView = createDetailRow(title: "Category", value: test.category.rawValue, icon: "folder.fill")
        detailsStackView.addArrangedSubview(categoryView)
        
        // Passing score
        let passingView = createDetailRow(title: "Passing Score", value: "\(test.passingScore)/\(test.questions.count)", icon: "checkmark.circle.fill")
        detailsStackView.addArrangedSubview(passingView)
        
        // Result status
        let passed = result.score >= test.passingScore
        let statusView = createDetailRow(
            title: "Result",
            value: passed ? "PASSED" : "FAILED",
            icon: passed ? "checkmark.circle.fill" : "xmark.circle.fill"
        )
        detailsStackView.addArrangedSubview(statusView)
    }
    
    private func createDetailRow(title: String, value: String, icon: String) -> UIView {
        let containerView = UIView()
        containerView.backgroundColor = UIColor.systemGray6
        containerView.layer.cornerRadius = 12
        containerView.translatesAutoresizingMaskIntoConstraints = false
        
        let iconImageView = UIImageView()
        iconImageView.image = UIImage(systemName: icon)
        iconImageView.tintColor = UIColor.systemPurple
        iconImageView.contentMode = .scaleAspectFit
        iconImageView.translatesAutoresizingMaskIntoConstraints = false
        
        let titleLabel = UILabel()
        titleLabel.text = title
        titleLabel.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        titleLabel.textColor = UIColor.label
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let valueLabel = UILabel()
        valueLabel.text = value
        valueLabel.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        valueLabel.textColor = UIColor.label
        valueLabel.textAlignment = .right
        valueLabel.translatesAutoresizingMaskIntoConstraints = false
        
        containerView.addSubview(iconImageView)
        containerView.addSubview(titleLabel)
        containerView.addSubview(valueLabel)
        
        NSLayoutConstraint.activate([
            containerView.heightAnchor.constraint(equalToConstant: 60),
            
            iconImageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            iconImageView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            iconImageView.widthAnchor.constraint(equalToConstant: 24),
            iconImageView.heightAnchor.constraint(equalToConstant: 24),
            
            titleLabel.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: 12),
            titleLabel.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            
            valueLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
            valueLabel.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            valueLabel.leadingAnchor.constraint(greaterThanOrEqualTo: titleLabel.trailingAnchor, constant: 8)
        ])
        
        return containerView
    }
    
    private func getScoreColor() -> UIColor {
        let percentage = Double(result.score) / Double(result.totalQuestions)
        
        if percentage >= 0.8 {
            return UIColor.systemGreen
        } else if percentage >= 0.6 {
            return UIColor.systemOrange
        } else {
            return UIColor.systemRed
        }
    }
    
    private func addCelebrationAnimation() {
        // Add confetti animation for high scores
        let confettiView = UIView()
        confettiView.backgroundColor = UIColor.clear
        confettiView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(confettiView)
        
        NSLayoutConstraint.activate([
            confettiView.topAnchor.constraint(equalTo: view.topAnchor),
            confettiView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            confettiView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            confettiView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        // Create confetti particles
        for _ in 0..<50 {
            let particle = UIView()
            particle.backgroundColor = UIColor.systemYellow
            particle.layer.cornerRadius = 2
            particle.frame = CGRect(x: CGFloat.random(in: 0...view.bounds.width), y: -10, width: 4, height: 4)
            confettiView.addSubview(particle)
            
            UIView.animate(withDuration: Double.random(in: 2...4), delay: Double.random(in: 0...1), options: [], animations: {
                particle.frame.origin.y = self.view.bounds.height + 10
                particle.frame.origin.x += CGFloat.random(in: -50...50)
            }) { _ in
                particle.removeFromSuperview()
            }
        }
        
        // Remove confetti view after animation
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            confettiView.removeFromSuperview()
        }
    }
    
    @objc private func reviewButtonTapped() {
//        let reviewVC = TestReviewViewController(test: test, userAnswers: result.userAnswers ?? [])
//        navigationController?.pushViewController(reviewVC, animated: true)
    }
    
    @objc private func retakeButtonTapped() {
        let alert = UIAlertController(title: "Retake Test", message: "Are you sure you want to retake this test?", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        alert.addAction(UIAlertAction(title: "Retake", style: .default) { _ in
            let testVC = TestViewController(test: self.test)
            self.navigationController?.setViewControllers([self.navigationController!.viewControllers.first!, testVC], animated: true)
        })
        
        present(alert, animated: true)
    }
    
    @objc private func doneButtonTapped() {
        navigationController?.popToRootViewController(animated: true)
    }
}
