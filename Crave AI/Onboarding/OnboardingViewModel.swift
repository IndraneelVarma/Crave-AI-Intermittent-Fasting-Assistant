//
//  OnboardingViewModel.swift
//  Crave AI
//
//  Created by Indraneel Varma on 22/02/25.
//


import Foundation
import Combine

class OnboardingViewModel: ObservableObject {
    @Published var name: String = ""
    @Published var fastingSchedule: String = "16:8" // Default fasting schedule
    @Published var goal: String = "Weight Loss"
    
    @Published var currentStep: Int = 0 // Keeps track of which step in onboarding the user is on
    @Published var isOnboardingComplete: Bool = false // If onboarding is completed
    
    // Function to proceed to the next step
    func nextStep() {
        if currentStep < 2 {
            currentStep += 1
        } else {
            // Onboarding complete, save profile
            completeOnboarding()
        }
    }
    
    func completeOnboarding() {
        // Handle saving the user profile (e.g., storing in a database or UserDefaults)
        // For now, we print the user data to simulate saving.
        print("Onboarding complete: \(name), Fasting Schedule: \(fastingSchedule), Goal: \(goal)")
        UserDefaults.standard.set(name, forKey: "userName")
        UserDefaults.standard.set(fastingSchedule, forKey: "schedule")
        UserDefaults.standard.set(goal, forKey: "goal")
        isOnboardingComplete = true
    }
}
