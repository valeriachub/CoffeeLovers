//
//  LocalNotificationService.swift
//  CoffeeLovers
//
//  Created by Valeria Chub on 29.05.2022.
//  Copyright © 2022 Valeria. All rights reserved.
//

import Foundation
import UserNotifications

final class LocalNotificationService {
    
    private enum NotificationData: String {
        case notificationId = "coffee_notification_id"
        case title = "Good Morning ☀️"
        case subtitle = "Let's drink a coffee ☕️"
        case body = ""
    }
    
    private let coffeeData: [Coffee]
    
    init(coffeeData: [Coffee]) {
        self.coffeeData = coffeeData
    }
    
    func updateMorningNotification() {
        removeOldNotification()
        
        let favourtites = coffeeData.filter { $0.isFavourite }
        guard !favourtites.isEmpty else { return }
        
        createNewNotification(from: favourtites)
    }
    
    private func removeOldNotification() {
        guard let id = UserDefaults.standard.string(forKey: NotificationData.notificationId.rawValue) else {
            return
        }
        print(#function)
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [id])
    }
    
    private func createNewNotification(from coffeeData: [Coffee]) {
        let content = UNMutableNotificationContent()
        content.title = NotificationData.title.rawValue
        content.subtitle = NotificationData.subtitle.rawValue
        content.body = "\(coffeeData.map { $0.title }.joined(separator: ", "))❤️"
        content.sound = .default
        
        let dateComponent = DateComponents(hour: 8, minute: 0, second: 5)
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponent, repeats: true)
        let id = UUID().uuidString
        let request = UNNotificationRequest(identifier: id, content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request)
        UserDefaults.standard.set(id, forKey: NotificationData.notificationId.rawValue)
    }
}
