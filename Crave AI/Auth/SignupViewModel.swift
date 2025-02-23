//
//  SignupViewModel.swift
//  Crave AI
//
//  Created by Indraneel Varma on 23/02/25.
//


import Foundation
import Combine
import Supabase // Make sure this package is added to your project

class SignupViewModel: ObservableObject {
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var confirmPassword: String = ""
    @Published var errorMessage: String? = nil
    @Published var isSigningUp: Bool = false
    @Published var success: Bool = false

    
    // Validate the email format
    func isValidEmail() -> Bool {
        return email.contains("@") && email.contains(".")
    }
    
    // Check that the password and confirm password fields match
    func passwordsMatch() -> Bool {
        return password == confirmPassword
    }
    
    // Function to sign up a new user
    func signUp() {
        // Validate email format
        guard isValidEmail() else {
            self.errorMessage = "Invalid email format."
            return
        }
        // Validate that both passwords match
        guard passwordsMatch() else {
            self.errorMessage = "Passwords do not match."
            return
        }
        
        self.errorMessage = nil
        isSigningUp = true
        
        // Using async/await in a Task to call Supabase's sign up API
        Task {
            do {
                // This call attempts to sign up a new user
                let _ = try await supabase.auth.signUp(email: email, password: password)
                await MainActor.run {
                    self.success = true
                    self.isSigningUp = false
                }
            } catch {
                await MainActor.run {
                    self.errorMessage = error.localizedDescription
                    self.isSigningUp = false
                }
            }
        }
    }
}
