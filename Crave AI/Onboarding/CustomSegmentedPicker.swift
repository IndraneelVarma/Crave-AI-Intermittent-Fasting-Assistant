//
//  CustomSegmentedPicker.swift
//  Crave AI
//
//  Created by Indraneel Varma on 23/02/25.
//
import SwiftUI

struct CustomSegmentedPicker: View {
    @Binding var selection: String
    let options: [String]
    
    var body: some View {
        HStack(spacing: 0) {
            ForEach(options, id: \.self) { option in
                Button(action: { selection = option }) {
                    Text(option)
                        .font(.system(size: 14, weight: .medium))
                        .padding(.vertical, 12)
                        .frame(maxWidth: .infinity)
                        .background(selection == option ? Color.blue : Color.clear)
                        .foregroundColor(selection == option ? .white : .primary)
                }
            }
        }
        .background(Color.gray.opacity(0.1))
        .clipShape(RoundedRectangle(cornerRadius: 8))
    }
}

struct FastingOptionCard: View {
    let schedule: String
    let isSelected: Bool
    let action: () -> Void
    
    var scheduleDescription: String {
        switch schedule {
        case "16:8": return "16 hours fasting, 8 hours eating window"
        case "18:6": return "18 hours fasting, 6 hours eating window"
        case "24-Hour Fast": return "Full day fast, one meal a day"
        default: return ""
        }
    }
    
    var body: some View {
        Button(action: action) {
            HStack {
                VStack(alignment: .leading, spacing: 8) {
                    Text(schedule)
                        .font(.system(size: 18, weight: .semibold))
                    Text(scheduleDescription)
                        .font(.system(size: 14))
                        .foregroundColor(.secondary)
                }
                Spacer()
                Image(systemName: isSelected ? "checkmark.circle.fill" : "circle")
                    .foregroundColor(isSelected ? .blue : .gray)
                    .font(.system(size: 24))
            }
            .padding()
            .frame(maxWidth: .infinity)
            .background(Color.white.opacity(0.8))
            .clipShape(RoundedRectangle(cornerRadius: 12))
        }
        .buttonStyle(PlainButtonStyle())
    }
}
