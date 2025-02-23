import SwiftUI

struct WelcomeScreen: View {
    @ObservedObject var viewModel: OnboardingViewModel
    
    var body: some View {
        ZStack {
            // Background gradient
            LinearGradient(
                gradient: Gradient(colors: [Color.blue.opacity(0.1), Color.purple.opacity(0.1)]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            
            VStack(spacing: 40) {
                // App logo and branding
                VStack(spacing: 20) {
                    Image(systemName: "fork.knife.circle.fill")
                        .font(.system(size: 80))
                        .foregroundStyle(.blue)
                        .padding(.top, 60)
                    
                    Text("Welcome to CraveAI")
                        .font(.system(size: 32, weight: .bold))
                        .foregroundColor(.primary)
                }
                
                // Welcome message
                VStack(spacing: 16) {
                    Text("Your AI-Powered")
                        .font(.title2)
                        .foregroundColor(.secondary)
                    Text("Fasting Companion")
                        .font(.system(size: 24, weight: .semibold))
                        .foregroundColor(.primary)
                }
                
                // Description
                Text("Let's help you manage your cravings and achieve your intermittent fasting goals.")
                    .font(.system(size: 17))
                    .multilineTextAlignment(.center)
                    .foregroundColor(.secondary)
                    .padding(.horizontal, 32)
                
                Spacer()
                
                // Start button
                Button(action: { viewModel.nextStep() }) {
                    Text("Get Started")
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
    }
}
