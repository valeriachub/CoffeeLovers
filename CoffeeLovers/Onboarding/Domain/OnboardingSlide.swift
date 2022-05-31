//
//  OnboardingSlide.swift
//  CoffeeLovers
//
//  Created by Valeria Chub on 31.05.2022.
//  Copyright © 2022 Valeria. All rights reserved.
//

import UIKit

struct OnboardingSlide {
    let title: String
    let description: String
    let image: UIImage
}

enum OnboardingService {
    static func loadSlides() -> [OnboardingSlide] {
        let onboarding1 = OnboardingSlide(title: "Choose Your Favourite Coffee", description: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled.", image: UIImage(named: "onboarding-1")!)
        
        let onboarding2 = OnboardingSlide(title: "Get To Known The Difference Between Coffee", description: "Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for 'lorem ipsum' will uncover many web sites still in their infancy. ", image: UIImage(named: "onboarding-2")!)
        
        let onboarding3 = OnboardingSlide(title: "Get Morning Notifications", description: "All the Lorem Ipsum generators on the Internet tend to repeat predefined chunks as necessary, making this the first true generator on the Internet.", image: UIImage(named: "onboarding-3")!)
        
        return [onboarding1, onboarding2, onboarding3]
    }
}
