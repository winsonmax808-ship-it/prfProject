//
//  PerfumeCatalogViewController.swift
//  prfProject
//
//  Created by artem on 15.09.2025.
//

import UIKit

class PerfumeCatalogViewController: UIViewController {
    
    private let searchController = UISearchController(searchResultsController: nil)
    private let collectionView: UICollectionView
    private let filterButton = UIButton(type: .system)
    
    private var perfumes: [Perfume] = []
    private var filteredPerfumes: [Perfume] = []
    private var isSearching = false
    
    init() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 16
        layout.minimumLineSpacing = 16
        layout.sectionInset = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupSearchController()
        setupCollectionView()
        loadSampleData()
    }
    
    private func setupUI() {
        view.backgroundColor = UIColor.systemBackground
        title = "Perfume Catalog"
        
        // Navigation setup
        navigationController?.navigationBar.prefersLargeTitles = true
        
        // Filter button
        filterButton.setTitle("Filters", for: .normal)
        filterButton.setImage(UIImage(systemName: "line.3.horizontal.decrease"), for: .normal)
        filterButton.addTarget(self, action: #selector(filterButtonTapped), for: .touchUpInside)
        
        let filterBarButton = UIBarButtonItem(customView: filterButton)
        navigationItem.rightBarButtonItem = filterBarButton
    }
    
    private func setupSearchController() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search perfumes..."
        searchController.searchBar.searchBarStyle = .minimal
        
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
    
    private func setupCollectionView() {
        collectionView.backgroundColor = UIColor.systemBackground
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        collectionView.register(PerfumeCollectionViewCell.self, forCellWithReuseIdentifier: "PerfumeCell")
        
        view.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func loadSampleData() {
        // Заглушка з прикладовими даними
        perfumes = [
            Perfume(
                name: "Liora Essence",
                brand: "Maison Liora",
                year: 1921,
                gender: .female,
                concentration: .eauDeParfum,
                topNotes: ["Aldehydes", "Iris", "Bergamot"],
                middleNotes: ["Rose", "Jasmine", "Lily"],
                baseNotes: ["Sandalwood", "Vanilla", "Musk"],
                description: "A legendary fragrance that became a symbol of elegance and femininity.",
                priceRange: .luxury,
                seasonality: [.spring, .autumn],
                occasion: [.evening, .special],
                longevity: .strong,
                sillage: .moderate,
                rating: 4.5,
                isPopular: true
            ),
            Perfume(
                name: "Aurelian Spirit",
                brand: "Aurelian",
                year: 2015,
                gender: .male,
                concentration: .eauDeToilette,
                topNotes: ["Calabrian Bergamot", "Pepper"],
                middleNotes: ["Sichuan Pepper", "Amberwood"],
                baseNotes: ["Amberwood", "Labdanum"],
                description: "A wild and captivating fragrance for the modern man.",
                priceRange: .premium,
                seasonality: [.spring, .summer],
                occasion: [.daily, .evening],
                longevity: .strong,
                sillage: .strong,
                rating: 4.3,
                isPopular: true
            ),
            Perfume(
                name: "Noctis Orchid",
                brand: "Noctis",
                year: 2006,
                gender: .unisex,
                concentration: .eauDeParfum,
                topNotes: ["Black Orchid", "Fig", "Iris"],
                middleNotes: ["Spices", "Floral Notes"],
                baseNotes: ["Patchouli", "Vanilla", "Incense"],
                description: "A mysterious and sophisticated fragrance for special occasions.",
                priceRange: .luxury,
                seasonality: [.autumn, .winter],
                occasion: [.evening, .special],
                longevity: .veryStrong,
                sillage: .powerful,
                rating: 4.7,
                isPopular: true
            )
        ]
        
        filteredPerfumes = perfumes
        collectionView.reloadData()
    }
    
    @objc private func filterButtonTapped() {
        let filterVC = FilterViewController()
        filterVC.delegate = self
        let navController = UINavigationController(rootViewController: filterVC)
        present(navController, animated: true)
    }
}

// MARK: - UICollectionViewDataSource
extension PerfumeCatalogViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filteredPerfumes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PerfumeCell", for: indexPath) as! PerfumeCollectionViewCell
        cell.configure(with: filteredPerfumes[indexPath.item])
        return cell
    }
}

// MARK: - UICollectionViewDelegate
extension PerfumeCatalogViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let perfume = filteredPerfumes[indexPath.item]
        let detailVC = PerfumeDetailViewController(perfume: perfume)
        navigationController?.pushViewController(detailVC, animated: true)
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension PerfumeCatalogViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.frame.width - 48) / 2 // 2 колонки з відступами
        return CGSize(width: width, height: 280)
    }
}

// MARK: - UISearchResultsUpdating
extension PerfumeCatalogViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText = searchController.searchBar.text else { return }
        
        if searchText.isEmpty {
            filteredPerfumes = perfumes
        } else {
            filteredPerfumes = perfumes.filter { perfume in
                perfume.name.localizedCaseInsensitiveContains(searchText) ||
                perfume.brand.localizedCaseInsensitiveContains(searchText) ||
                perfume.topNotes.contains { $0.localizedCaseInsensitiveContains(searchText) } ||
                perfume.middleNotes.contains { $0.localizedCaseInsensitiveContains(searchText) } ||
                perfume.baseNotes.contains { $0.localizedCaseInsensitiveContains(searchText) }
            }
        }
        
        collectionView.reloadData()
    }
}

// MARK: - FilterViewControllerDelegate
extension PerfumeCatalogViewController: FilterViewControllerDelegate {
    func didApplyFilters(_ filters: FilterOptions) {
        filteredPerfumes = perfumes.filter { perfume in
            // Gender filter
            if let gender = filters.gender, perfume.gender != gender {
                return false
            }
            
            // Price range filter
            if let priceRange = filters.priceRange, perfume.priceRange != priceRange {
                return false
            }
            
            // Season filter
            if let season = filters.season, !perfume.seasonality.contains(season) {
                return false
            }
            
            // Occasion filter
            if let occasion = filters.occasion, !perfume.occasion.contains(occasion) {
                return false
            }
            
            // Longevity filter
            if let longevity = filters.longevity, perfume.longevity != longevity {
                return false
            }
            
            // Sillage filter
            if let sillage = filters.sillage, perfume.sillage != sillage {
                return false
            }
            
            // Brand filter
            if let brand = filters.brand, !perfume.brand.localizedCaseInsensitiveContains(brand) {
                return false
            }
            
            // Rating filter
//            if perfume.rating < filters.minRating || perfume.rating > filters.maxRating {
//                return false
//            }
            
            return true
        }
        
        collectionView.reloadData()
        
        // Update filter button appearance
        updateFilterButtonAppearance(hasActiveFilters: filters.hasActiveFilters)
    }
    
    private func updateFilterButtonAppearance(hasActiveFilters: Bool) {
        if hasActiveFilters {
            filterButton.tintColor = UIColor.systemBlue
            filterButton.setTitle("Filters ✓", for: .normal)
        } else {
            filterButton.tintColor = UIColor.label
            filterButton.setTitle("Filters", for: .normal)
        }
    }
}
