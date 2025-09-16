//
//  MainTabBarController.swift
//  prfProject
//
//  Created by artem on 15.09.2025.
//

import UIKit

class MainTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBar()
        setupViewControllers()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("MainTabBarController appeared successfully")
    }
    
    private func setupTabBar() {
        tabBar.backgroundColor = UIColor.systemBackground
        tabBar.tintColor = UIColor.systemPurple
        tabBar.unselectedItemTintColor = UIColor.systemGray
        
        // Додаємо тінь для кращого вигляду
        tabBar.layer.shadowColor = UIColor.black.cgColor
        tabBar.layer.shadowOffset = CGSize(width: 0, height: -2)
        tabBar.layer.shadowOpacity = 0.1
        tabBar.layer.shadowRadius = 4
    }
    
    private func setupViewControllers() {
        let homeVC = HomeViewController()
        let homeNav = UINavigationController(rootViewController: homeVC)
        homeNav.tabBarItem = UITabBarItem(
            title: "Home",
            image: UIImage(systemName: "house.fill"),
            selectedImage: UIImage(systemName: "house.fill")
        )
        
        let catalogVC = PerfumeCatalogViewController()
        let catalogNav = UINavigationController(rootViewController: catalogVC)
        catalogNav.tabBarItem = UITabBarItem(
            title: "Catalog",
            image: UIImage(systemName: "sparkles"),
            selectedImage: UIImage(systemName: "sparkles")
        )
        
        let learningVC = LearningViewController()
        let learningNav = UINavigationController(rootViewController: learningVC)
        learningNav.tabBarItem = UITabBarItem(
            title: "Learning",
            image: UIImage(systemName: "book.fill"),
            selectedImage: UIImage(systemName: "book.fill")
        )
        
        let testsVC = TestsViewController()
        let testsNav = UINavigationController(rootViewController: testsVC)
        testsNav.tabBarItem = UITabBarItem(
            title: "Tests",
            image: UIImage(systemName: "brain.head.profile"),
            selectedImage: UIImage(systemName: "brain.head.profile")
        )
        
        let notesVC = NotesViewController()
        let notesNav = UINavigationController(rootViewController: notesVC)
        notesNav.tabBarItem = UITabBarItem(
            title: "Notes",
            image: UIImage(systemName: "note.text"),
            selectedImage: UIImage(systemName: "note.text")
        )
        
        let profileVC = ProfileViewController()
        let profileNav = UINavigationController(rootViewController: profileVC)
        profileNav.tabBarItem = UITabBarItem(
            title: "Profile",
            image: UIImage(systemName: "person.fill"),
            selectedImage: UIImage(systemName: "person.fill")
        )
        
        viewControllers = [homeNav, catalogNav, learningNav, testsNav, notesNav, profileNav]
    }
}
