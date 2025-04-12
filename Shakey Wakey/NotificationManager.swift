//
//  NotificationManager.swift
//  Shakey Wakey
//
//  Created by Johan Karlsson on 2025-04-12.
//

import UserNotifications

class NotificationManager {
    static let shared = NotificationManager()

    private init() {}

    func requestAuthorization() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge, .criticalAlert]) { granted, error in
            if granted {
                print("Notisbehörighet beviljad")
                self.createAlarmCategory()
            } else if let error = error {
                print("Fel vid begäran om notisbehörighet: \(error)")
            }
        }
    }

    func createAlarmCategory() {
        let alarmCategory = UNNotificationCategory(identifier: "ALARM_CATEGORY", actions: [], intentIdentifiers: [], options: [])
        UNUserNotificationCenter.current().setNotificationCategories([alarmCategory])
    }

    func scheduleNotification(for alarm: Alarm) {
        let content = UNMutableNotificationContent()
        content.title = "Väckarklocka!"
        content.body = "Det är dags att vakna."
        content.sound = UNNotificationSound.defaultCritical
        content.categoryIdentifier = "ALARM_CATEGORY"

        let dateComponents = Calendar.current.dateComponents([.hour, .minute], from: alarm.time)
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)

        let request = UNNotificationRequest(identifier: alarm.id.uuidString, content: content, trigger: trigger)

        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("Fel vid schemaläggning av notis: \(error)")
            }
        }
    }

    func cancelNotification(for alarm: Alarm) {
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [alarm.id.uuidString])
    }
}
