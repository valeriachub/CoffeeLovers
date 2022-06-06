//
//  OnboardingUIComposer.swift
//  CoffeeLovers
//
//  Created by Valeria Chub on 31.05.2022.
//  Copyright © 2022 Valeria. All rights reserved.
//

import Foundation

final class OnboardingUIComposer {
    
    static func compose(with getStartedCallback: @escaping(() -> Void)) -> OnboardingViewController {
        let presenter = OnboardingPresenter()
        let controller = OnboardingViewController(presenter: presenter, getStartedCallback: getStartedCallback)
        return controller
    }
}
