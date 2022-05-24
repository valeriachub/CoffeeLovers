//
//  NewsPresenter.swift
//  CoffeeLovers
//
//  Created by Valeria Chub on 30.05.2022.
//  Copyright © 2022 Valeria. All rights reserved.
//

import Foundation

protocol NewsView {
    func updateNews(_ news: [NewsItem])
}

class NewsPresenter {
    
    private let loader: NewsLoader
    private var news: [NewsItem]?
    private let view: NewsView
    
    var numberOfRows: Int {
        news?.count ?? 0
    }
    
    init(view: NewsView, loader: NewsLoader) {
        self.loader = loader
        self.view = view
    }
    
    func item(for indexPath: IndexPath) -> NewsItem? {
        return news?[indexPath.row]
    }
    
    func loadNews() {
        loader.load { [weak self] news in
            self?.news = news.sorted(by: { $0.date > $1.date })
            self?.view.updateNews(news)
        }
    }
}
