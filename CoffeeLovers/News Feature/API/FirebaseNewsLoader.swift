//
//  FirebaseNewsLoader.swift
//  CoffeeLovers
//
//  Created by Valeria Chub on 30.05.2022.
//  Copyright © 2022 Valeria. All rights reserved.
//

import Foundation
//import FirebaseFirestore

class FirebaseNewsLoader: NewsLoader {
    
    private enum NewsFirestore: String {
        case News = "News"
        case title = "title"
        case description = "description"
        case addedAt = "addedAt"
    }
    
//    private let news = Firestore.firestore().collection(NewsFirestore.News.rawValue)
    
    func load(completion: @escaping ([NewsItem]) -> Void) {
//        news.getDocuments { [weak self] snapshot, error in
//            guard error == nil, let documents = snapshot?.documents else {
//                return
//            }
//
//            completion(documents.compactMap { self?.map(from: $0.data() ) })
//        }
    }
    
    func map(from data: [String : Any]) -> NewsItem? {
//        guard let title = data[NewsFirestore.title.rawValue] as? String,
//              let description = data[NewsFirestore.description.rawValue] as? String,
//              let addedAt = data[NewsFirestore.addedAt.rawValue] as? Timestamp else {
//                  return nil
//              }
//        return NewsItem(title: title, descripttion: description, date: addedAt.dateValue())
        return nil
    }
}
