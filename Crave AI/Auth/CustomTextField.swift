//
//  CustomTextField.swift
//  Crave AI
//
//  Created by Indraneel Varma on 23/02/25.
//
import SwiftUI

// Custom reusable components
struct CustomTextField: View {
    let icon: String
    let placeholder: String
    @Binding var text: String
    
    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: icon)
                .foregroundColor(.gray)
                .frame(width: 24)
            
            TextField(placeholder, text: $text)
                .font(.system(size: 16))
        }
        .padding()
        .background(Color.gray.opacity(0.1))
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }
}

struct CustomSecureField: View {
    let icon: String
    let placeholder: String
    @Binding var text: String
    
    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: icon)
                .foregroundColor(.gray)
                .frame(width: 24)
            
            SecureField(placeholder, text: $text)
                .font(.system(size: 16))
        }
        .padding()
        .background(Color.gray.opacity(0.1))
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }
}
