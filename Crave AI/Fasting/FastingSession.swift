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
    
    
    
    var timeDifference: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        
        guard let start = dateFormatter.date(from: startTime),
              let end = dateFormatter.date(from: endTime) else {
            return "00:00"
        }
        
        let diffSeconds = Int(end.timeIntervalSince(start))
        let hours = diffSeconds / 3600
        let minutes = (diffSeconds % 3600) / 60
        
        return String(format: "%02d:%02d", hours, minutes)
    }
}

