//
//  OnboardingPresenter.swift
//  CoffeeLovers
//
//  Created by Valeria Chub on 31.05.2022.
//  Copyright © 2022 Valeria. All rights reserved.
//

import Foundation
import UIKit

class OnboardingPresenter {
    
    private var slides: [OnboardingSlide]?
    
    var numberOfItems: Int {
        return slides?.count ?? 0
    }
    
    init() {
        slides = OnboardingService.loadSlides()
    }
    
    func getItem(for indexPath: IndexPath) -> OnboardingSlide? {
        return slides?[indexPath.row]
    }
}

