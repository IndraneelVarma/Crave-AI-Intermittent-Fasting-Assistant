import SwiftUI

struct AuthView: View {
    @State private var selectedMode: AuthMode = .login
    @State private var showOnboarding = false
    
    enum AuthMode: String, CaseIterable {
        case login = "Login"
        case signup = "Sign Up"
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                // Background gradient
                LinearGradient(
                    gradient: Gradient(colors: [Color.blue.opacity(0.1), Color.purple.opacity(0.1)]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()
                
                VStack(spacing: 30) {
                    // App logo/icon placeholder
                    Image(systemName: "fork.knife.circle.fill")
                        .font(.system(size: 60))
                        .foregroundStyle(.blue)
                        .padding(.top, 40)
                    
                    Text("CraveAI")
                        .font(.system(size: 36, weight: .bold))
                        .foregroundColor(.primary)
                    
                    // Custom segmented control
                    HStack(spacing: 0) {
                        ForEach(AuthMode.allCases, id: \.self) { mode in
                            Button(action: { selectedMode = mode }) {
                                Text(mode.rawValue)
                                    .font(.system(size: 16, weight: .medium))
                                    .padding(.vertical, 12)
                                    .frame(maxWidth: .infinity)
                                    .background(selectedMode == mode ? Color.blue : Color.clear)
                                    .foregroundColor(selectedMode == mode ? .white : .primary)
                            }
                        }
                    }
                    .background(Color.gray.opacity(0.1))
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                    .padding(.horizontal, 30)
                    
                    if selectedMode == .login {
                        LoginView(showOnboarding: $showOnboarding)
                    } else {
                        SignupView(showOnboarding: $showOnboarding)
                    }
                }
            }
            .navigationDestination(isPresented: $showOnboarding) {
                OnboardingView()
                    .interactiveDismissDisabled(true)
            }
        }
    }
}
