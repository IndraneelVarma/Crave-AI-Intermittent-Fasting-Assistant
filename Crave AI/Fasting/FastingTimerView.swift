import SwiftUI

// [Previous HomeView code remains the same...]

struct FastingTimerView: View {
    @State private var isFasting: Bool
    @State private var startTime: Date
    @State private var elapsedTime: TimeInterval = 0
    @State private var timer: Timer? = nil
    @State private var showCongratulations = false
    @State private var showStartConfirmation = false
    @State private var showEndConfirmation = false
    @StateObject private var viewModel = FastingViewModel()
    
    private let isFastingKey = "isFasting"
    private let startTimeKey = "fastingStartTime"
    
    init() {
        _isFasting = State(initialValue: UserDefaults.standard.bool(forKey: "isFasting"))
        if let savedStartTime = UserDefaults.standard.object(forKey: "fastingStartTime") as? Date {
            _startTime = State(initialValue: savedStartTime)
        } else {
            _startTime = State(initialValue: Date.now)
        }
    }
    
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
                // Timer circle
                ZStack {
                    Circle()
                        .stroke(Color.gray.opacity(0.2), lineWidth: 20)
                        .frame(width: 280, height: 280)
                    
                    Circle()
                        .trim(from: 0, to: min(CGFloat(elapsedTime/(16*3600)), 1.0))
                        .stroke(
                            isFasting ? Color.blue : Color.green,
                            style: StrokeStyle(lineWidth: 20, lineCap: .round)
                        )
                        .frame(width: 280, height: 280)
                        .rotationEffect(.degrees(-90))
                        .animation(.linear(duration: 1), value: elapsedTime)
                    
                    VStack(spacing: 16) {
                        Text(isFasting ? "Fasting" : "Not Fasting")
                            .font(.system(size: 24, weight: .semibold))
                            .foregroundColor(.primary)
                        
                        Text(formatTime(elapsedTime))
                            .font(.system(size: 44, weight: .bold, design: .rounded))
                            .foregroundColor(.primary)
                        
                        if isFasting {
                            Text("Keep going!")
                                .font(.system(size: 18))
                                .foregroundColor(.secondary)
                        }
                    }
                }
                .padding(.top, 40)
                
                // Stats cards
                HStack(spacing: 20) {
                    StatCard(
                        title: "Target",
                        value: "16:00:00",
                        icon: "target",
                        color: .purple
                    )
                    
                    StatCard(
                        title: "Progress",
                        value: "\(Int(min((elapsedTime/(16*3600))*100, 100)))%",
                        icon: "chart.bar.fill",
                        color: .blue
                    )
                }
                
                Spacer()
                
                // Action button
                Button(action: {
                    if isFasting {
                        showEndConfirmation = true
                    } else {
                        showStartConfirmation = true
                    }
                }) {
                    Text(isFasting ? "End Fast" : "Start Fasting")
                        .font(.system(size: 20, weight: .semibold))
                        .frame(maxWidth: .infinity)
                        .frame(height: 60)
                        .background(isFasting ? Color.red : Color.green)
                        .foregroundColor(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 16))
                        .shadow(color: (isFasting ? Color.red : Color.green).opacity(0.3), radius: 5, y: 2)
                }
                .padding(.horizontal, 32)
                .padding(.bottom, 40)
            }
            .padding(.horizontal)
        }
        .onAppear {
            if isFasting {
                startTimer()
            }
        }
        // Confirmation dialog for starting a fast
        .confirmationDialog(
            "Start Fasting",
            isPresented: $showStartConfirmation,
            titleVisibility: .visible
        ) {
            Button("Start 16-Hour Fast") {
                startFasting()
            }
            Button("Cancel", role: .cancel) {}
        } message: {
            Text("Are you ready to begin your fasting period?")
        }
        // Confirmation dialog for ending a fast
        .confirmationDialog(
            "End Fasting",
            isPresented: $showEndConfirmation,
            titleVisibility: .visible
        ) {
            Button("End Fast", role: .destructive) {
                stopFasting()
                if elapsedTime >= 16 * 3600 {
                    showCongratulations = true
                }
            }
            Button("Cancel", role: .cancel) {}
        } message: {
            Text("Are you sure you want to end your current fast?")
        }
        // Congratulations alert
        .alert("Congratulations!", isPresented: $showCongratulations) {
            Button("Thanks!", role: .cancel) {}
        } message: {
            Text("You've completed your fasting session!")
        }
    }
    
    private func startFasting() {
        isFasting = true
        startTime = Date()
        UserDefaults.standard.set(true, forKey: isFastingKey)
        UserDefaults.standard.set(startTime, forKey: startTimeKey)
        startTimer()
    }
    
    private func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            
                elapsedTime = Date().timeIntervalSince(startTime)
            
        }
        RunLoop.current.add(timer!, forMode: .common)
    }
    
    private func stopFasting() {
        print("Start time: \(startTime)")
        print("Stop time: \(Date.now)")
        Task {
            await viewModel.uploadSession(startTime: startTime)
        }
        isFasting = false
        elapsedTime = 0
        UserDefaults.standard.set(false, forKey: isFastingKey)
        UserDefaults.standard.removeObject(forKey: startTimeKey)
        timer?.invalidate()
        timer = nil
    }
    
    private func formatTime(_ time: TimeInterval) -> String {
        let hours = Int(time) / 3600
        let minutes = Int(time) / 60 % 60
        let seconds = Int(time) % 60
        return String(format: "%02d:%02d:%02d", hours, minutes, seconds)
    }
}

// [Rest of the components (StatCard, FastingSessionCard, etc.) remain the same...]
