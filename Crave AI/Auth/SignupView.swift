import SwiftUI

struct SignupView: View {
    @StateObject private var viewModel = SignupViewModel()
    @Binding var showOnboarding: Bool
    
    var body: some View {
        VStack(spacing: 24) {
            VStack(spacing: 16) {
                // Email field
                CustomTextField(
                    icon: "envelope.fill",
                    placeholder: "Email",
                    text: $viewModel.email
                )
                .keyboardType(.emailAddress)
                .autocapitalization(.none)
                
                // Password field
                CustomSecureField(
                    icon: "lock.fill",
                    placeholder: "Password",
                    text: $viewModel.password
                )
                
                // Confirm password field
                CustomSecureField(
                    icon: "lock.fill",
                    placeholder: "Confirm Password",
                    text: $viewModel.confirmPassword
                )
            }
            .padding(.horizontal, 30)
            
            // Error message
            if let errorMessage = viewModel.errorMessage {
                Text(errorMessage)
                    .font(.system(size: 14))
                    .foregroundColor(.red)
                    .padding(.horizontal, 30)
                    .fixedSize(horizontal: false, vertical: true)
            }
            
            // Sign up button
            Button(action: { viewModel.signUp() }) {
                HStack {
                    if viewModel.isSigningUp {
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle(tint: .white))
                    } else {
                        Text("Create Account")
                            .font(.system(size: 17, weight: .semibold))
                    }
                }
                .frame(maxWidth: .infinity)
                .frame(height: 50)
                .background(Color.blue)
                .foregroundColor(.white)
                .clipShape(RoundedRectangle(cornerRadius: 12))
                .shadow(color: .blue.opacity(0.2), radius: 5, y: 2)
            }
            .padding(.horizontal, 30)
            .disabled(viewModel.isSigningUp)
        }
        .navigationBarBackButtonHidden(true)
        .onChange(of: viewModel.success) { newValue in
            if newValue {
                showOnboarding = true
            }
        }
    }
}

