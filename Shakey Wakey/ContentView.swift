//
//  ContentView.swift
//  Shakey Wakey
//
//  Created by Johan Karlsson on 2025-04-12.
//

import SwiftUI
import CoreMotion

struct ContentView: View {
    @State private var alarms: [Alarm] = []
    @State private var showingAddAlarm = false
    @State private var timer = Timer.publish(every: 60, on: .main, in: .common).autoconnect()
    @StateObject private var motionManager = MotionManager() // Lägg till MotionManager

    var body: some View {
        NavigationView {
            List {
                ForEach(alarms) { alarm in
                    Text("\(alarm.time)")
                }
            }
            .navigationTitle("Alarm")
            .toolbar {
                Button(action: {
                    showingAddAlarm = true
                }) {
                    Image(systemName: "plus")
                }
            }
            .sheet(isPresented: $showingAddAlarm) {
                AddAlarmView(alarms: $alarms)
            }
        }
        .onReceive(timer) { _ in
            checkAlarms()
        }
        .onAppear {
            motionManager.startMonitoring() // Starta övervakning av skakningar
        }
        .onDisappear {
            motionManager.stopMonitoring() // Stoppa övervakning av skakningar
        }
        .onChange(of: motionManager.isShaking) { oldValue, newValue in
            if newValue {
                silenceActiveAlarm()
            }
        }
    }

    func checkAlarms() {
            let now = Date()
            for alarm in alarms {
                if alarm.isActive && Calendar.current.isDate(alarm.time, inSameDayAs: now) &&
                   Calendar.current.compare(alarm.time, to: now, toGranularity: .minute) == .orderedSame {
                    SoundManager.instance.playSound() // Spela upp ljud
                    NotificationManager.shared.scheduleNotification(for: alarm) // Schemalägg notis
                }
            }
        }

        func silenceActiveAlarm() {
            for index in alarms.indices {
                if alarms[index].isActive {
                    SoundManager.instance.player?.stop() // Stoppa ljud
                    NotificationManager.shared.cancelNotification(for: alarms[index]) // Avbryt notis
                    alarms[index].isActive = false
                }
            }
        }
    }
#Preview {
    ContentView()
}
