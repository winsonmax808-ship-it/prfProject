//
//  ViewController.swift
//  prfProject
//
//  Created by artem on 15.09.2025.
//

import UIKit

class ViewController: UIViewController {
    
    private var hasPresentedInitialScreen = false

    override func viewDidLoad() {
        super.viewDidLoad()
        setupLaunchScreen()
    }
    
    private func setupLaunchScreen() {
        view.backgroundColor = UIColor.systemBackground
        
        // Add logo or app name
        let logoLabel = UILabel()
        logoLabel.text = "🌸 Perfume Master"
        logoLabel.font = UIFont.systemFont(ofSize: 32, weight: .bold)
        logoLabel.textColor = UIColor.systemPurple
        logoLabel.textAlignment = .center
        logoLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let subtitleLabel = UILabel()
        subtitleLabel.text = "Discover the world of fragrances"
        subtitleLabel.font = UIFont.systemFont(ofSize: 16)
        subtitleLabel.textColor = UIColor.secondaryLabel
        subtitleLabel.textAlignment = .center
        subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(logoLabel)
        view.addSubview(subtitleLabel)
        
        NSLayoutConstraint.activate([
            logoLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -20),
            
            subtitleLabel.topAnchor.constraint(equalTo: logoLabel.bottomAnchor, constant: 8),
            subtitleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // Перевіряємо чи користувач проходив онбординг
        guard !hasPresentedInitialScreen else { return }
        hasPresentedInitialScreen = true
        
        if !UserDefaults.standard.bool(forKey: "hasCompletedOnboarding") {
            showOnboarding()
        } else {
            showMainApp()
        }
    }
    
    private func showOnboarding() {
        guard presentedViewController == nil else { return }
        let onboardingVC = OnboardingViewController()
        onboardingVC.delegate = self
        onboardingVC.modalPresentationStyle = .fullScreen
        present(onboardingVC, animated: true)
    }
    
    private func showMainApp() {
        print("Attempting to show main app...")
        let mainTabBarController = MainTabBarController()
        
        // Використовуємо зміну root view controller для більш надійного переходу
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let window = windowScene.windows.first {
            print("Using window root view controller approach")
            window.rootViewController = mainTabBarController
            window.makeKeyAndVisible()
            
            // Плавна анімація переходу
            UIView.transition(with: window, duration: 0.3, options: .transitionCrossDissolve, animations: nil, completion: nil)
        } else {
            print("Using modal presentation fallback")
            // Fallback до modal presentation
            mainTabBarController.modalPresentationStyle = .fullScreen
            present(mainTabBarController, animated: true)
        }
    }
}

// MARK: - OnboardingViewControllerDelegate
extension ViewController: OnboardingViewControllerDelegate {
    func didCompleteOnboarding() {
        UserDefaults.standard.set(true, forKey: "hasCompletedOnboarding")
        
        // Показуємо головний додаток
        showMainApp()
    }
}

