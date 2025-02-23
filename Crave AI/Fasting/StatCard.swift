//
//  StatCard.swift
//  Crave AI
//
//  Created by Indraneel Varma on 23/02/25.
//
import SwiftUI

struct StatCard: View {
    let title: String
    let value: String
    let icon: String
    let color: Color
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Image(systemName: icon)
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(color)
                Text(title)
                    .font(.system(size: 14))
                    .foregroundColor(.secondary)
            }
            
            Text(value)
                .font(.system(size: 24, weight: .bold))
                .foregroundColor(.primary)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(16)
        .background(Color.white.opacity(0.9))
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .shadow(color: Color.black.opacity(0.05), radius: 5)
    }
}

struct FastingSessionCard: View {
    let session: SessionHistory
    
    private func formatDate(_ dateString: String) -> String {
           let dateFormatter = DateFormatter()
           dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
           
           if let date = dateFormatter.date(from: dateString) {
               dateFormatter.dateFormat = "MMM d, h:mm a" // Feb 23, 2:47 PM
               return dateFormatter.string(from: date)
           }
           return dateString // Return original string if parsing fails
       }
    
    private func formatTime(_ time: TimeInterval) -> String {
        let hours = Int(time) / 3600
        let minutes = Int(time) / 60 % 60
        return String(format: "%02d:%02d", hours, minutes)
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                Image(systemName: "timer.circle.fill")
                    .font(.system(size: 24))
                    .foregroundColor(.blue)
                
                VStack(alignment: .leading, spacing: 4) {
                    Text(formatTime(session.duration))
                        .font(.system(size: 20, weight: .semibold))
                    Text("Duration")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                
                Spacer()
                
                Image(systemName: "checkmark.circle.fill")
                    .font(.system(size: 20))
                    .foregroundColor(.green)
            }
            
            Divider()
            
            HStack {
                VStack(alignment: .leading, spacing: 8) {
                    Label {
                        Text(formatDate(session.startTime))
                    } icon: {
                        Image(systemName: "play.circle.fill")
                            .foregroundColor(.green)
                    }
                    
                    Label {
                        Text(formatDate(session.endTime))
                    } icon: {
                        Image(systemName: "stop.circle.fill")
                            .foregroundColor(.red)
                    }
                }
                .font(.system(size: 14))
            }
        }
        .padding()
        .background(Color.white.opacity(0.9))
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .shadow(color: Color.black.opacity(0.05), radius: 5)
    }
}
