//
//  RatingControl.swift
//  MyPlaces
//
//  Created by Arman on 12.10.2021.
//  Copyright © 2021 Alexey Efimov. All rights reserved.
//

import UIKit

@IBDesignable class RatingControl: UIStackView {
    
    // MARK: Properties
    var rating = 0 {
        didSet {
            updateButtonSelectionState()
        }
    }
    
    private var ratingButtons = [UIButton]()
    
    @IBInspectable var starSize: CGSize = CGSize(width: 44, height: 44) {
        didSet{
            setupButtons()
        }
    }
    @IBInspectable var starCount: Int = 5 {
        didSet {
            setupButtons()
        }
    }
    
    

    // MARK: Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButtons()
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
        setupButtons()
    }
    // MARK: Button Action
    
    @objc func ratingButtonTapped(button: UIButton) {
        guard let index = ratingButtons.firstIndex(of: button) else { return }
        
        //Calculate the  rating of selected button
        
        let seletedRating = index + 1
        
        if seletedRating == rating {
            rating = 0
        } else {
            rating = seletedRating
        }
    }
    // MARK: Private methods
    
    private func setupButtons() {
        for button in ratingButtons {
            removeArrangedSubview(button)
            button.removeFromSuperview()
        }
        
        ratingButtons.removeAll()
        // Load button image
        let bundle = Bundle(for: type(of: self))
        let filledStar = UIImage(named: "filledStar",
                                 in: bundle,
                                 compatibleWith: self.traitCollection)
        let emptyStar = UIImage(named: "emptyStar",
                                in: bundle,
                                compatibleWith: self.traitCollection)
        let highlightedStar = UIImage(named: "highlightedStar",
                                      in: bundle,
                                      compatibleWith: self.traitCollection)
        
        for _ in 0..<starCount{
            let button = UIButton()
//            button.backgroundColor = .yellow
            
            // Set the button's Image
            button.setImage(emptyStar, for: .normal)
            button.setImage(filledStar, for: .selected)
            button.setImage(highlightedStar, for: .highlighted)
            button.setImage(highlightedStar, for: [.highlighted, .selected])
             
            //Add constraints to buttons
            button.translatesAutoresizingMaskIntoConstraints = false
            button.heightAnchor.constraint(equalToConstant: starSize.height).isActive = true
            button.widthAnchor.constraint(equalToConstant: starSize.width).isActive = true
            
            // Setup the button actions
            button.addTarget(self, action: #selector(ratingButtonTapped(button: )), for: .touchUpInside)
            
            // Add buttons to stack view
            addArrangedSubview(button)
            // Add new button on the rating button array
            ratingButtons.append(button)
        }
        updateButtonSelectionState()
    }
    private func updateButtonSelectionState() {
        for (index, button) in ratingButtons.enumerated() {
            button.isSelected = index < rating
        }
    }
}
