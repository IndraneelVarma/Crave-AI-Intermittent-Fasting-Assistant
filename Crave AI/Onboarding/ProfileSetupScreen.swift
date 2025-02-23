//
//  ProfileSetupScreen.swift
//  Crave AI
//
//  Created by Indraneel Varma on 22/02/25.
//


import SwiftUI

struct ProfileSetupScreen: View {
    @ObservedObject var viewModel: OnboardingViewModel
    
    var body: some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: [Color.blue.opacity(0.1), Color.purple.opacity(0.1)]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            
            VStack(spacing: 32) {
                // Header
                VStack(spacing: 12) {
                    Text("Tell Us About You")
                        .font(.system(size: 28, weight: .bold))
                    Text("Personalize your fasting journey")
                        .font(.system(size: 17))
                        .foregroundColor(.secondary)
                }
                .padding(.top, 60)
                
                // Form fields
                VStack(spacing: 24) {
                    // Name field
                    CustomTextField(
                        icon: "person.fill",
                        placeholder: "Your Name",
                        text: $viewModel.name
                    )
                    
                    // Goal selection
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Your Goal")
                            .font(.system(size: 16, weight: .medium))
                            .foregroundColor(.secondary)
                        
                        CustomSegmentedPicker(
                            selection: $viewModel.goal,
                            options: ["Weight Loss", "Better Health", "Other"]
                        )
                    }
                }
                .padding(.horizontal, 32)
                
                Spacer()
                
                // Next button
                Button(action: { viewModel.nextStep() }) {
                    Text("Continue")
                        .font(.system(size: 18, weight: .semibold))
                        .frame(maxWidth: .infinity)
                        .frame(height: 56)
                        .background(viewModel.name.count >= 2 ? Color.blue : Color.gray)
                        .foregroundColor(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 16))
                        .shadow(color: .blue.opacity(0.2), radius: 5, y: 2)
                }
                .disabled(viewModel.name.count < 2)
                .padding(.horizontal, 32)
                .padding(.bottom, 40)
            }
        }
    }
}

