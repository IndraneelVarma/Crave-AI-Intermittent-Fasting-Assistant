//
//  FastingScheduleScreen.swift
//  Crave AI
//
//  Created by Indraneel Varma on 22/02/25.
//


import SwiftUI

struct FastingScheduleScreen: View {
    @ObservedObject var viewModel: OnboardingViewModel
    @State private var showHome = false
    
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
                    Text("Choose Your Schedule")
                        .font(.system(size: 28, weight: .bold))
                    Text("Select a fasting pattern that works for you")
                        .font(.system(size: 17))
                        .foregroundColor(.secondary)
                }
                .padding(.top, 60)
                
                // Fasting schedule picker
                VStack(spacing: 24) {
                    ForEach(["16:8", "18:6", "24-Hour Fast"], id: \.self) { schedule in
                        FastingOptionCard(
                            schedule: schedule,
                            isSelected: viewModel.fastingSchedule == schedule,
                            action: { viewModel.fastingSchedule = schedule }
                        )
                    }
                }
                .padding(.horizontal, 32)
                
                Spacer()
                
                // Complete button
                Button(action: {
                    viewModel.completeOnboarding()
                    showHome = true
                }) {
                    Text("Start My Journey")
                        .font(.system(size: 18, weight: .semibold))
                        .frame(maxWidth: .infinity)
                        .frame(height: 56)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 16))
                        .shadow(color: .blue.opacity(0.2), radius: 5, y: 2)
                }
                .padding(.horizontal, 32)
                .padding(.bottom, 40)
            }
        }
        .navigationDestination(isPresented: $showHome) {
            HomeView()
                .interactiveDismissDisabled(true)
        }
    }
}
