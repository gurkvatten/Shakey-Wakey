//
//  Untitled.swift
//  Shakey Wakey
//
//  Created by Johan Karlsson on 2025-04-12.
//
import CoreMotion

class MotionManager: ObservableObject {
    private let motionManager = CMMotionManager()
    @Published var isShaking = false

    func startMonitoring() {
        if motionManager.isAccelerometerAvailable {
            motionManager.accelerometerUpdateInterval = 0.2
            motionManager.startAccelerometerUpdates(to: .main) { data, error in
                if let acceleration = data?.acceleration {
                    let totalAcceleration = sqrt(pow(acceleration.x, 2) + pow(acceleration.y, 2) + pow(acceleration.z, 2))
                    if totalAcceleration > 2.5 { // Justera tröskelvärdet efter behov
                        self.isShaking = true
                    } else {
                        self.isShaking = false
                    }
                }
            }
        }
    }

    func stopMonitoring() {
        motionManager.stopAccelerometerUpdates()
    }
}
