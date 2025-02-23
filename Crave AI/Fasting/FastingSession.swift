//
//  FastingSession.swift
//  Crave AI
//
//  Created by Indraneel Varma on 22/02/25.
//


import Foundation

struct FastingSession: Identifiable, Codable {
    let id = UUID()
    let email = UserDefaults.standard.string(forKey: "email")
    let startTime: Date
    let endTime: Date
    var duration: TimeInterval {
        return endTime.timeIntervalSince(startTime)
    }
}

struct SessionHistory: Identifiable, Codable {
    let id = UUID()
    let startTime: String
    let endTime: String
    
    var duration: TimeInterval {
        let formatter = ISO8601DateFormatter()
        formatter.formatOptions = [.withInternetDateTime]
        
        guard let start = formatter.date(from: startTime),
              let end = formatter.date(from: endTime) else {
            return 0
        }
        
        return end.timeIntervalSince(start)
    }
}

