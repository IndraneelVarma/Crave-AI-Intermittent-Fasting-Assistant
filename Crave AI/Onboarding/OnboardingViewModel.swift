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
    @Published var error: String? = nil
    
    @Published var currentStep: Int = 0 // Keeps track of which step in onboarding the user is on
    @Published var isOnboardingComplete: Bool = false // If onboarding is completed
    
    // Function to proceed to the next step
    func nextStep() {
        if currentStep < 2 {
                currentStep += 1
        } else {
            // Onboarding complete, save profile
            Task{
                await completeOnboarding()
            }
        }
    }
    
    func fetchData() async {
            do {
                print("Making Supabase request...")
                let userData: [OnboardingDownloadModel] = try await supabase
                    .from("OnboardingSelections")
                    .select()
                    .eq("email", value: UserDefaults.standard.string(forKey: "email"))
                    .execute()
                    .value
                
                print("Successfully fetched User data: \(userData)")
                UserDefaults.standard.set(userData.first?.name, forKey: "userName")
                UserDefaults.standard.set(userData.first?.fastSchedule, forKey: "schedule")
                UserDefaults.standard.set(userData.first?.goal, forKey: "goal")
                print("Successfully saved data to UserDefaults")
                
            } catch {
                print("⚠️ Error encountered while fetching sessions")
                print("Error details: \(error)")
                print("Error localized description: \(error.localizedDescription)")
                self.error = error.localizedDescription
            }
    }
    
    func completeOnboarding() async {
            UserDefaults.standard.set(name, forKey: "userName")
            UserDefaults.standard.set(fastingSchedule, forKey: "schedule")
            UserDefaults.standard.set(goal, forKey: "goal")
            let userData = OnboardingUploadModel(name: name, goal: goal, fastSchedule: fastingSchedule)
            do {
                let response = try await supabase
                    .from("OnboardingSelections")
                    .insert(userData)
                    .execute()
                print("Session saved successfully. Response: \(response)")
                
            } catch {
                self.error = error.localizedDescription
                print("Error saving session: \(error)")
            }
    }
}
