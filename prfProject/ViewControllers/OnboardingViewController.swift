//
//  OnboardingViewController.swift
//  prfProject
//
//  Created by artem on 15.09.2025.
//

import UIKit

protocol OnboardingViewControllerDelegate: AnyObject {
    func didCompleteOnboarding()
}

class OnboardingViewController: UIViewController {
    
    weak var delegate: OnboardingViewControllerDelegate?
    
    private let scrollView = UIScrollView()
    private let pageControl = UIPageControl()
    private let skipButton = UIButton(type: .system)
    private let nextButton = UIButton(type: .system)
    private let getStartedButton = UIButton(type: .system)
    
    private var hasCompletedOnboarding = false
    
    private let onboardingPages = [
        OnboardingPage(
            title: "Welcome to Perfume Master! 🌸",
            description: "Discover the fascinating world of perfumery and become a true fragrance connoisseur.",
            imageName: "sparkles",
            backgroundColor: UIColor.systemPurple.withAlphaComponent(0.1),
            gradientColors: [UIColor.systemPurple.cgColor, UIColor.systemPink.cgColor],
            emoji: "🌸"
        ),
        OnboardingPage(
            title: "Learn with Us 📚",
            description: "Study the fundamentals of perfumery, learn about different notes and compositions through interactive articles and videos.",
            imageName: "book.fill",
            backgroundColor: UIColor.systemBlue.withAlphaComponent(0.1),
            gradientColors: [UIColor.systemBlue.cgColor, UIColor.systemCyan.cgColor],
            emoji: "📚"
        ),
        OnboardingPage(
            title: "Take Tests 🧠",
            description: "Test your knowledge and develop fragrance recognition skills through interesting quizzes and tests.",
            imageName: "brain.head.profile",
            backgroundColor: UIColor.systemGreen.withAlphaComponent(0.1),
            gradientColors: [UIColor.systemGreen.cgColor, UIColor.systemMint.cgColor],
            emoji: "🧠"
        ),
        OnboardingPage(
            title: "Keep Notes 📝",
            description: "Record your impressions of perfumes, create a personal collection and share observations.",
            imageName: "note.text",
            backgroundColor: UIColor.systemOrange.withAlphaComponent(0.1),
            gradientColors: [UIColor.systemOrange.cgColor, UIColor.systemYellow.cgColor],
            emoji: "📝"
        ),
        OnboardingPage(
            title: "Explore Catalog 🔍",
            description: "Find the perfect fragrance among thousands of perfumes with detailed descriptions and recommendations.",
            imageName: "magnifyingglass",
            backgroundColor: UIColor.systemRed.withAlphaComponent(0.1),
            gradientColors: [UIColor.systemRed.cgColor, UIColor.systemPink.cgColor],
            emoji: "🔍"
        )
    ]
    
    private var currentPage = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupScrollView()
        setupPageControl()
        setupButtons()
        setupConstraints()
    }
    
    private func setupUI() {
        view.backgroundColor = UIColor.systemBackground
        
        // Налаштування градієнта
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [
            UIColor.systemPurple.withAlphaComponent(0.1).cgColor,
            UIColor.systemBlue.withAlphaComponent(0.1).cgColor
        ]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.frame = view.bounds
        view.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    private func setupScrollView() {
        scrollView.isPagingEnabled = true
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.delegate = self
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(scrollView)
        
        // Додаємо сторінки
        for (index, page) in onboardingPages.enumerated() {
            let pageView = createPageView(for: page)
            pageView.translatesAutoresizingMaskIntoConstraints = false
            scrollView.addSubview(pageView)
            
            NSLayoutConstraint.activate([
                pageView.topAnchor.constraint(equalTo: scrollView.topAnchor),
                pageView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: CGFloat(index) * UIScreen.main.bounds.width),
                pageView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width),
                pageView.heightAnchor.constraint(equalTo: scrollView.heightAnchor)
            ])
        }
        
        scrollView.contentSize = CGSize(width: CGFloat(onboardingPages.count) * UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
    }
    
    private func createPageView(for page: OnboardingPage) -> UIView {
        let containerView = UIView()
        containerView.backgroundColor = page.backgroundColor
        
        // Градієнтний фон
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = page.gradientColors
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        containerView.layer.insertSublayer(gradientLayer, at: 0)
        
        // Емодзі іконка
        let emojiLabel = UILabel()
        emojiLabel.text = page.emoji
        emojiLabel.font = UIFont.systemFont(ofSize: 80)
        emojiLabel.textAlignment = .center
        emojiLabel.translatesAutoresizingMaskIntoConstraints = false
        
        // Системна іконка
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: page.imageName)
        imageView.tintColor = UIColor.white.withAlphaComponent(0.8)
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        // Контейнер для іконки з анімацією
        let iconContainer = UIView()
        iconContainer.backgroundColor = UIColor.white.withAlphaComponent(0.2)
        iconContainer.layer.cornerRadius = 60
        iconContainer.layer.shadowColor = UIColor.black.cgColor
        iconContainer.layer.shadowOffset = CGSize(width: 0, height: 4)
        iconContainer.layer.shadowOpacity = 0.1
        iconContainer.layer.shadowRadius = 8
        iconContainer.translatesAutoresizingMaskIntoConstraints = false
        
        let titleLabel = UILabel()
        titleLabel.text = page.title
        titleLabel.font = UIFont.systemFont(ofSize: 32, weight: .bold)
        titleLabel.textColor = UIColor.white
        titleLabel.textAlignment = .center
        titleLabel.numberOfLines = 0
        titleLabel.layer.shadowColor = UIColor.black.cgColor
        titleLabel.layer.shadowOffset = CGSize(width: 0, height: 2)
        titleLabel.layer.shadowOpacity = 0.3
        titleLabel.layer.shadowRadius = 4
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let descriptionLabel = UILabel()
        descriptionLabel.text = page.description
        descriptionLabel.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        descriptionLabel.textColor = UIColor.white.withAlphaComponent(0.9)
        descriptionLabel.textAlignment = .center
        descriptionLabel.numberOfLines = 0
        descriptionLabel.layer.shadowColor = UIColor.black.cgColor
        descriptionLabel.layer.shadowOffset = CGSize(width: 0, height: 1)
        descriptionLabel.layer.shadowOpacity = 0.2
        descriptionLabel.layer.shadowRadius = 2
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        
        iconContainer.addSubview(imageView)
        containerView.addSubview(emojiLabel)
        containerView.addSubview(iconContainer)
        containerView.addSubview(titleLabel)
        containerView.addSubview(descriptionLabel)
        
        NSLayoutConstraint.activate([
            emojiLabel.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            emojiLabel.centerYAnchor.constraint(equalTo: containerView.centerYAnchor, constant: -120),
            
            iconContainer.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            iconContainer.centerYAnchor.constraint(equalTo: containerView.centerYAnchor, constant: -20),
            iconContainer.widthAnchor.constraint(equalToConstant: 120),
            iconContainer.heightAnchor.constraint(equalToConstant: 120),
            
            imageView.centerXAnchor.constraint(equalTo: iconContainer.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: iconContainer.centerYAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 60),
            imageView.heightAnchor.constraint(equalToConstant: 60),
            
            titleLabel.topAnchor.constraint(equalTo: iconContainer.bottomAnchor, constant: 40),
            titleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 40),
            titleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -40),
            
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 24),
            descriptionLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 40),
            descriptionLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -40)
        ])
        
        // Додаємо анімацію пульсації для іконки
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.addPulseAnimation(to: iconContainer)
        }
        
        return containerView
    }
    
    private func addPulseAnimation(to view: UIView) {
        let pulseAnimation = CABasicAnimation(keyPath: "transform.scale")
        pulseAnimation.duration = 2.0
        pulseAnimation.fromValue = 1.0
        pulseAnimation.toValue = 1.1
        pulseAnimation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        pulseAnimation.autoreverses = true
        pulseAnimation.repeatCount = .infinity
        view.layer.add(pulseAnimation, forKey: "pulse")
    }
    
    private func setupPageControl() {
        pageControl.numberOfPages = onboardingPages.count
        pageControl.currentPage = 0
        pageControl.pageIndicatorTintColor = UIColor.white.withAlphaComponent(0.3)
        pageControl.currentPageIndicatorTintColor = UIColor.white
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        
        // Додаємо фон для page control
        pageControl.backgroundColor = UIColor.black.withAlphaComponent(0.1)
        pageControl.layer.cornerRadius = 15
        
        view.addSubview(pageControl)
    }
    
    private func setupButtons() {
        // Skip button
        skipButton.setTitle("Skip", for: .normal)
        skipButton.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        skipButton.setTitleColor(UIColor.white.withAlphaComponent(0.7), for: .normal)
        skipButton.backgroundColor = UIColor.white.withAlphaComponent(0.1)
        skipButton.layer.cornerRadius = 20
        skipButton.layer.borderWidth = 1
        skipButton.layer.borderColor = UIColor.white.withAlphaComponent(0.3).cgColor
        skipButton.addTarget(self, action: #selector(skipButtonTapped), for: .touchUpInside)
        skipButton.translatesAutoresizingMaskIntoConstraints = false
        
        // Next button
        nextButton.setTitle("Next →", for: .normal)
        nextButton.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        nextButton.setTitleColor(.white, for: .normal)
        nextButton.backgroundColor = UIColor.white.withAlphaComponent(0.2)
        nextButton.layer.cornerRadius = 25
        nextButton.layer.shadowColor = UIColor.black.cgColor
        nextButton.layer.shadowOffset = CGSize(width: 0, height: 4)
        nextButton.layer.shadowOpacity = 0.2
        nextButton.layer.shadowRadius = 8
        nextButton.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
        nextButton.translatesAutoresizingMaskIntoConstraints = false
        
        // Get started button
        getStartedButton.setTitle("✨ Start Journey ✨", for: .normal)
        getStartedButton.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        getStartedButton.setTitleColor(.white, for: .normal)
        getStartedButton.layer.cornerRadius = 30
        getStartedButton.layer.shadowColor = UIColor.black.cgColor
        getStartedButton.layer.shadowOffset = CGSize(width: 0, height: 6)
        getStartedButton.layer.shadowOpacity = 0.3
        getStartedButton.layer.shadowRadius = 12
        getStartedButton.addTarget(self, action: #selector(getStartedButtonTapped), for: .touchUpInside)
        getStartedButton.isHidden = true
        getStartedButton.translatesAutoresizingMaskIntoConstraints = false
        
        // Додаємо градієнт до кнопки "Get Started"
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [UIColor.systemPurple.cgColor, UIColor.systemPink.cgColor]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.cornerRadius = 30
        getStartedButton.layer.insertSublayer(gradientLayer, at: 0)
        
        view.addSubview(skipButton)
        view.addSubview(nextButton)
        view.addSubview(getStartedButton)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: pageControl.topAnchor, constant: -20),
            
            pageControl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            pageControl.bottomAnchor.constraint(equalTo: skipButton.topAnchor, constant: -30),
            
            skipButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            skipButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -30),
            skipButton.heightAnchor.constraint(equalToConstant: 50),
            
            nextButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            nextButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -30),
            nextButton.heightAnchor.constraint(equalToConstant: 50),
            
            getStartedButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            getStartedButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -30),
            getStartedButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            getStartedButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            getStartedButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    private func updateButtonsVisibility() {
        let isLastPage = currentPage == onboardingPages.count - 1
        
        skipButton.isHidden = isLastPage
        nextButton.isHidden = isLastPage
        getStartedButton.isHidden = !isLastPage
    }
    
    @objc private func skipButtonTapped() {
        guard !hasCompletedOnboarding else { return }
        hasCompletedOnboarding = true
        
        // Робимо кнопки неактивними
        skipButton.isEnabled = false
        nextButton.isEnabled = false
        getStartedButton.isEnabled = false
        
        // Haptic feedback
        let impactFeedback = UIImpactFeedbackGenerator(style: .light)
        impactFeedback.impactOccurred()
        
        // Анімація кнопки
        UIView.animate(withDuration: 0.1, animations: {
            self.skipButton.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
        }) { _ in
            UIView.animate(withDuration: 0.1) {
                self.skipButton.transform = .identity
            }
        }
        
        // Негайний перехід для Skip
        delegate?.didCompleteOnboarding()
    }
    
    @objc private func nextButtonTapped() {
        // Haptic feedback
        let impactFeedback = UIImpactFeedbackGenerator(style: .medium)
        impactFeedback.impactOccurred()
        
        // Анімація кнопки
        UIView.animate(withDuration: 0.1, animations: {
            self.nextButton.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
        }) { _ in
            UIView.animate(withDuration: 0.1) {
                self.nextButton.transform = .identity
            }
        }
        
        if currentPage < onboardingPages.count - 1 {
            currentPage += 1
            let offset = CGFloat(currentPage) * UIScreen.main.bounds.width
            scrollView.setContentOffset(CGPoint(x: offset, y: 0), animated: true)
        }
    }
    
    @objc private func getStartedButtonTapped() {
        guard !hasCompletedOnboarding else { return }
        hasCompletedOnboarding = true
        
        // Робимо кнопки неактивними
        skipButton.isEnabled = false
        nextButton.isEnabled = false
        getStartedButton.isEnabled = false
        
        // Haptic feedback
        let impactFeedback = UIImpactFeedbackGenerator(style: .heavy)
        impactFeedback.impactOccurred()
        
        // Анімація кнопки з конфеті ефектом
        UIView.animate(withDuration: 0.2, animations: {
            self.getStartedButton.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
        }) { _ in
            UIView.animate(withDuration: 0.2) {
                self.getStartedButton.transform = .identity
            }
        }
        
        // Додаємо конфеті анімацію
        addConfettiAnimation()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            print("Calling delegate didCompleteOnboarding")
            self.delegate?.didCompleteOnboarding()
        }
    }
    
    private func addConfettiAnimation() {
        // Проста конфеті анімація
        for _ in 0..<50 {
            let confetti = UIView()
            confetti.backgroundColor = [UIColor.systemPurple, UIColor.systemPink, UIColor.systemBlue, UIColor.systemGreen, UIColor.systemOrange].randomElement()
            confetti.frame = CGRect(x: CGFloat.random(in: 0...UIScreen.main.bounds.width), y: -20, width: 8, height: 8)
            confetti.layer.cornerRadius = 4
            view.addSubview(confetti)
            
            UIView.animate(withDuration: 3.0, delay: Double.random(in: 0...0.5), options: .curveEaseOut) {
                confetti.frame.origin.y = UIScreen.main.bounds.height + 20
                confetti.transform = CGAffineTransform(rotationAngle: CGFloat.random(in: 0...2 * .pi))
            } completion: { _ in
                confetti.removeFromSuperview()
            }
        }
    }
}

// MARK: - UIScrollViewDelegate
extension OnboardingViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pageIndex = round(scrollView.contentOffset.x / UIScreen.main.bounds.width)
        currentPage = Int(pageIndex)
        pageControl.currentPage = currentPage
        updateButtonsVisibility()
        
        // Додаємо плавну анімацію переходу
        let progress = scrollView.contentOffset.x / scrollView.contentSize.width
        animatePageTransition(progress: progress)
    }
    
    private func animatePageTransition(progress: CGFloat) {
        // Анімація для кнопок
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut) {
            self.skipButton.alpha = progress > 0.8 ? 0.5 : 1.0
            self.nextButton.alpha = progress > 0.8 ? 0.5 : 1.0
        }
    }
}

struct OnboardingPage {
    let title: String
    let description: String
    let imageName: String
    let backgroundColor: UIColor
    let gradientColors: [CGColor]
    let emoji: String
}
