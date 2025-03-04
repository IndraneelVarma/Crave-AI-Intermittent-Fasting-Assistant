import SwiftUI

struct HomeView: View {
    @State private var selection = 1
    @State private var showLogoutAlert = false
    @State private var logout = false
    
    var body: some View {
        NavigationStack {
            TabView(selection: $selection) {
                FastingTimerView()
                    .tag(1)
                    .tabItem {
                        Label("Timer", systemImage: "timer.circle.fill")
                    }
                FastingHistoryView()
                    .tag(2)
                    .tabItem {
                        Label("History", systemImage: "chart.bar.fill")
                    }
            }
            .onAppear(){
                print("Name: \(UserDefaults.standard.string(forKey: "userName"))")
                print("Goal: \(UserDefaults.standard.string(forKey: "goal"))")
                print("Schedule: \(UserDefaults.standard.string(forKey: "schedule"))")
            }
            .tint(.blue)
            .navigationDestination(isPresented: $logout) {
                AuthView()
                    .interactiveDismissDisabled(true)
            }
            .navigationBarBackButtonHidden(true)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: { showLogoutAlert = true }) {
                        Image(systemName: "rectangle.portrait.and.arrow.right")
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundStyle(.red)
                    }
                }
            }
            .alert("Logout", isPresented: $showLogoutAlert) {
                Button("Cancel", role: .cancel) {}
                Button("Logout", role: .destructive) {
                    let domain = Bundle.main.bundleIdentifier!
                    UserDefaults.standard.removePersistentDomain(forName: domain)
                    UserDefaults.standard.synchronize()
                    logout = true
                }
            } message: {
                Text("Are you sure you want to logout?")
            }
        }
    }
}
