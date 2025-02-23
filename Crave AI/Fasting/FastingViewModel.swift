import Foundation

@MainActor
class FastingViewModel: ObservableObject {
    @Published var sessions: [SessionHistory] = []
    @Published var isLoading = false
    @Published var error: String? = nil
    
    var averageDurationFormatted: String {
        let totalDuration = sessions.reduce(0.0) { $0 + $1.duration }
        let averageDuration = sessions.isEmpty ? 0 : totalDuration / Double(sessions.count)
        
        let hours = Int(averageDuration) / 3600
        let minutes = Int(averageDuration.truncatingRemainder(dividingBy: 3600)) / 60
        
        return String(format: "%02d:%02d", hours, minutes)
    }
    
    func uploadSession(startTime: Date) async {
        let session = FastingSession(startTime: startTime, endTime: Date.now)
        do {
            let response = try await supabase
                .from("FastingSessions")
                .insert(session)
                .execute()
            print("Session saved successfully. Response: \(response)")
            
            // Refresh sessions after successful upload
            await fetchSessions()
            
        } catch {
            self.error = error.localizedDescription
            print("Error saving session: \(error)")
        }
    }
    
    func fetchSessions() async {
        print("Starting to fetch sessions...")
        isLoading = true
        error = nil
        
        do {
            print("Making Supabase request...")
            let fetchedSessions: [SessionHistory] = try await supabase
                .from("FastingSessions")
                .select()
                .execute()
                .value
            
            print("Successfully fetched \(fetchedSessions.count) sessions")
            print("Session data: \(fetchedSessions)")
            
            self.sessions = fetchedSessions
            self.isLoading = false
            print("Updated sessions array in ViewModel")
            
        } catch {
            print("⚠️ Error encountered while fetching sessions")
            print("Error details: \(error)")
            print("Error localized description: \(error.localizedDescription)")
            
            self.error = error.localizedDescription
            self.isLoading = false
        }
    }
}
