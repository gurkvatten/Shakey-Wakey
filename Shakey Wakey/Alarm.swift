//
//  Alarm.swift
//  Shakey Wakey
//
//  Created by Johan Karlsson on 2025-04-12.
//
import Foundation

struct Alarm: Identifiable {
    let id = UUID()
    var time: Date
    var isActive: Bool
}
