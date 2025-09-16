//
//  FilterViewController.swift
//  prfProject
//
//  Created by artem on 15.09.2025.
//

import UIKit

class FilterViewController: UIViewController {
    
    weak var delegate: FilterViewControllerDelegate?
    
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    
    private let genderSegmentedControl = UISegmentedControl(items: Gender.allCases.map { $0.rawValue })
    private let priceRangeSegmentedControl = UISegmentedControl(items: PriceRange.allCases.map { $0.rawValue })
    private let seasonSegmentedControl = UISegmentedControl(items: Season.allCases.map { $0.rawValue })
    private let occasionSegmentedControl = UISegmentedControl(items: Occasion.allCases.map { $0.rawValue })
    private let longevitySegmentedControl = UISegmentedControl(items: Longevity.allCases.map { $0.rawValue })
    private let sillageSegmentedControl = UISegmentedControl(items: Sillage.allCases.map { $0.rawValue })
    
    private let brandTextField = UITextField()
    private let minRatingSlider = UISlider()
    private let maxRatingSlider = UISlider()
    private let minRatingLabel = UILabel()
    private let maxRatingLabel = UILabel()
    
    private var currentFilters = FilterOptions()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupConstraints()
        setupSegmentedControls()
    }
    
    private func setupUI() {
        view.backgroundColor = UIColor.systemBackground
        title = "Filters"
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .cancel,
            target: self,
            action: #selector(cancelTapped)
        )
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .done,
            target: self,
            action: #selector(applyTapped)
        )
        
        // Scroll view setup
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        // Gender segmented control
        genderSegmentedControl.selectedSegmentIndex = UISegmentedControl.noSegment
        genderSegmentedControl.translatesAutoresizingMaskIntoConstraints = false
        
        // Price range segmented control
        priceRangeSegmentedControl.selectedSegmentIndex = UISegmentedControl.noSegment
        priceRangeSegmentedControl.translatesAutoresizingMaskIntoConstraints = false
        
        // Season segmented control
        seasonSegmentedControl.selectedSegmentIndex = UISegmentedControl.noSegment
        seasonSegmentedControl.translatesAutoresizingMaskIntoConstraints = false
        
        // Occasion segmented control
        occasionSegmentedControl.selectedSegmentIndex = UISegmentedControl.noSegment
        occasionSegmentedControl.translatesAutoresizingMaskIntoConstraints = false
        
        // Longevity segmented control
        longevitySegmentedControl.selectedSegmentIndex = UISegmentedControl.noSegment
        longevitySegmentedControl.translatesAutoresizingMaskIntoConstraints = false
        
        // Sillage segmented control
        sillageSegmentedControl.selectedSegmentIndex = UISegmentedControl.noSegment
        sillageSegmentedControl.translatesAutoresizingMaskIntoConstraints = false
        
        // Brand text field
        brandTextField.placeholder = "Brand name"
        brandTextField.borderStyle = .roundedRect
        brandTextField.font = UIFont.systemFont(ofSize: 16)
        brandTextField.translatesAutoresizingMaskIntoConstraints = false
        
        // Rating sliders
        minRatingSlider.minimumValue = 1.0
        minRatingSlider.maximumValue = 5.0
        minRatingSlider.value = 1.0
        minRatingSlider.addTarget(self, action: #selector(ratingSliderChanged), for: .valueChanged)
        minRatingSlider.translatesAutoresizingMaskIntoConstraints = false
        
        maxRatingSlider.minimumValue = 1.0
        maxRatingSlider.maximumValue = 5.0
        maxRatingSlider.value = 5.0
        maxRatingSlider.addTarget(self, action: #selector(ratingSliderChanged), for: .valueChanged)
        maxRatingSlider.translatesAutoresizingMaskIntoConstraints = false
        
        minRatingLabel.text = "Min Rating: 1.0"
        minRatingLabel.font = UIFont.systemFont(ofSize: 14)
        minRatingLabel.textColor = UIColor.label
        minRatingLabel.translatesAutoresizingMaskIntoConstraints = false
        
        maxRatingLabel.text = "Max Rating: 5.0"
        maxRatingLabel.font = UIFont.systemFont(ofSize: 14)
        maxRatingLabel.textColor = UIColor.label
        maxRatingLabel.translatesAutoresizingMaskIntoConstraints = false
        
        // Add subviews
        contentView.addSubview(genderSegmentedControl)
        contentView.addSubview(priceRangeSegmentedControl)
        contentView.addSubview(seasonSegmentedControl)
        contentView.addSubview(occasionSegmentedControl)
        contentView.addSubview(longevitySegmentedControl)
        contentView.addSubview(sillageSegmentedControl)
        contentView.addSubview(brandTextField)
        contentView.addSubview(minRatingSlider)
        contentView.addSubview(maxRatingSlider)
        contentView.addSubview(minRatingLabel)
        contentView.addSubview(maxRatingLabel)
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
            
            genderSegmentedControl.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            genderSegmentedControl.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            genderSegmentedControl.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            priceRangeSegmentedControl.topAnchor.constraint(equalTo: genderSegmentedControl.bottomAnchor, constant: 24),
            priceRangeSegmentedControl.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            priceRangeSegmentedControl.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            seasonSegmentedControl.topAnchor.constraint(equalTo: priceRangeSegmentedControl.bottomAnchor, constant: 24),
            seasonSegmentedControl.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            seasonSegmentedControl.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            occasionSegmentedControl.topAnchor.constraint(equalTo: seasonSegmentedControl.bottomAnchor, constant: 24),
            occasionSegmentedControl.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            occasionSegmentedControl.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            longevitySegmentedControl.topAnchor.constraint(equalTo: occasionSegmentedControl.bottomAnchor, constant: 24),
            longevitySegmentedControl.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            longevitySegmentedControl.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            sillageSegmentedControl.topAnchor.constraint(equalTo: longevitySegmentedControl.bottomAnchor, constant: 24),
            sillageSegmentedControl.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            sillageSegmentedControl.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            brandTextField.topAnchor.constraint(equalTo: sillageSegmentedControl.bottomAnchor, constant: 24),
            brandTextField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            brandTextField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            brandTextField.heightAnchor.constraint(equalToConstant: 44),
            
            minRatingLabel.topAnchor.constraint(equalTo: brandTextField.bottomAnchor, constant: 24),
            minRatingLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            minRatingLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            minRatingSlider.topAnchor.constraint(equalTo: minRatingLabel.bottomAnchor, constant: 8),
            minRatingSlider.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            minRatingSlider.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            maxRatingLabel.topAnchor.constraint(equalTo: minRatingSlider.bottomAnchor, constant: 16),
            maxRatingLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            maxRatingLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            maxRatingSlider.topAnchor.constraint(equalTo: maxRatingLabel.bottomAnchor, constant: 8),
            maxRatingSlider.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            maxRatingSlider.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            maxRatingSlider.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20)
        ])
    }
    
    private func setupSegmentedControls() {
        // Add "All" option to each segmented control
        let segmentedControls = [
            genderSegmentedControl,
            priceRangeSegmentedControl,
            seasonSegmentedControl,
            occasionSegmentedControl,
            longevitySegmentedControl,
            sillageSegmentedControl
        ]
        
        for segmentedControl in segmentedControls {
            segmentedControl.insertSegment(withTitle: "All", at: 0, animated: false)
            segmentedControl.selectedSegmentIndex = 0
        }
    }
    
    @objc private func ratingSliderChanged() {
        // Ensure min rating is not higher than max rating
        if minRatingSlider.value > maxRatingSlider.value {
            minRatingSlider.value = maxRatingSlider.value
        }
        
        minRatingLabel.text = String(format: "Min Rating: %.1f", minRatingSlider.value)
        maxRatingLabel.text = String(format: "Max Rating: %.1f", maxRatingSlider.value)
    }
    
    @objc private func cancelTapped() {
        dismiss(animated: true)
    }
    
    @objc private func applyTapped() {
        // Collect filter values
        currentFilters.gender = genderSegmentedControl.selectedSegmentIndex == 0 ? nil : Gender.allCases[genderSegmentedControl.selectedSegmentIndex - 1]
        currentFilters.priceRange = priceRangeSegmentedControl.selectedSegmentIndex == 0 ? nil : PriceRange.allCases[priceRangeSegmentedControl.selectedSegmentIndex - 1]
        currentFilters.season = seasonSegmentedControl.selectedSegmentIndex == 0 ? nil : Season.allCases[seasonSegmentedControl.selectedSegmentIndex - 1]
        currentFilters.occasion = occasionSegmentedControl.selectedSegmentIndex == 0 ? nil : Occasion.allCases[occasionSegmentedControl.selectedSegmentIndex - 1]
        currentFilters.longevity = longevitySegmentedControl.selectedSegmentIndex == 0 ? nil : Longevity.allCases[longevitySegmentedControl.selectedSegmentIndex - 1]
        currentFilters.sillage = sillageSegmentedControl.selectedSegmentIndex == 0 ? nil : Sillage.allCases[sillageSegmentedControl.selectedSegmentIndex - 1]
        currentFilters.brand = brandTextField.text?.isEmpty == false ? brandTextField.text : nil
        currentFilters.minRating = minRatingSlider.value
        currentFilters.maxRating = maxRatingSlider.value
        
        delegate?.didApplyFilters(currentFilters)
        dismiss(animated: true)
    }
}

// MARK: - Filter Options
struct FilterOptions {
    var gender: Gender?
    var priceRange: PriceRange?
    var season: Season?
    var occasion: Occasion?
    var longevity: Longevity?
    var sillage: Sillage?
    var brand: String?
    var minRating: Float = 1.0
    var maxRating: Float = 5.0
    
    var hasActiveFilters: Bool {
        return gender != nil ||
               priceRange != nil ||
               season != nil ||
               occasion != nil ||
               longevity != nil ||
               sillage != nil ||
               brand != nil ||
               minRating > 1.0 ||
               maxRating < 5.0
    }
}

// MARK: - Filter Delegate
protocol FilterViewControllerDelegate: AnyObject {
    func didApplyFilters(_ filters: FilterOptions)
}
