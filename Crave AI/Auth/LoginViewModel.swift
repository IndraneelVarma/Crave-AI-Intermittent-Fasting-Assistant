import Foundation
import Combine
import Supabase // Ensure this is imported from the added package

class LoginViewModel: ObservableObject {
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var errorMessage: String? = nil
    @Published var isLoggingIn: Bool = false
    @Published var success: Bool = false
    // Function to validate email format
    func isValidEmail() -> Bool {
        return email.contains("@") && email.contains(".")
    }
    
    // Function to attempt login using Supabase authentication
    func login() {
        guard isValidEmail() else {
            self.errorMessage = "Invalid email format."
            return
        }
        
        isLoggingIn = true
        
        // Using async/await within a Task to call Supabase's auth API
        Task {
            do {
                // Attempt sign in with Supabase; this returns a session if successful.
                let _ = try await supabase.auth.signIn(email: email, password: password)
                // On success, update the UI on the main thread.
                await MainActor.run {
                    self.errorMessage = nil
                    self.success = true
                    self.isLoggingIn = false
                }
            } catch {
                // On failure, capture the error and update the UI.
                await MainActor.run {
                    self.errorMessage = error.localizedDescription
                    self.isLoggingIn = false
                }
            }
        }
    }
}
