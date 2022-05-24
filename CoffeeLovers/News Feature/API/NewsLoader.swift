//
//  NewsLoader.swift
//  CoffeeLovers
//
//  Created by Valeria Chub on 30.05.2022.
//  Copyright © 2022 Valeria. All rights reserved.
//

import Foundation

protocol NewsLoader {
    func load(completion: @escaping ([NewsItem]) -> Void)
}
