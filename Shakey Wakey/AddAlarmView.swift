//
//  AddAlarmView.swift
//  Shakey Wakey
//
//  Created by Johan Karlsson on 2025-04-12.
//

import SwiftUI

struct AddAlarmView: View {
    @Binding var alarms: [Alarm]
    @Environment(\.presentationMode) var presentationMode
    @State private var newAlarmTime = Date()

    var body: some View {
        NavigationView {
            VStack {
                DatePicker("Alarmtid", selection: $newAlarmTime, displayedComponents: .hourAndMinute)
                Button("Spara") {
                    let newAlarm = Alarm(time: newAlarmTime, isActive: true)
                    alarms.append(newAlarm)
                    NotificationManager.shared.scheduleNotification(for: newAlarm) // Schemalägg notis
                    presentationMode.wrappedValue.dismiss()
                }
            }
            .padding()
            .navigationTitle("Lägg till alarm")
        }
    }
}

struct AddAlarmView_Previews: PreviewProvider {
    static var previews: some View {
        let dummyAlarms = Binding.constant([Alarm(time: Date(), isActive: true)]) // Skapa en dummy-bindning
        AddAlarmView(alarms: dummyAlarms)
    }
}
