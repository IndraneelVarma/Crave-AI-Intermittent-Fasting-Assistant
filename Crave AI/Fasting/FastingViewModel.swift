import Foundation

@MainActor
class FastingViewModel: ObservableObject {
    @Published var sessions: [SessionHistory] = []
    @Published var isLoading = false
    @Published var error: String? = nil
    
    var averageDurationFormatted: String {
        guard !sessions.isEmpty else { return "00:00" }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        
        let totalDuration = sessions.reduce(0.0) { partialResult, session in
            guard let startDate = dateFormatter.date(from: session.startTime),
                  let endDate = dateFormatter.date(from: session.endTime) else {
                return partialResult
            }
            return partialResult + endDate.timeIntervalSince(startDate)
        }
        
        let averageDuration = totalDuration / Double(sessions.count)
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
                .eq("email", value: UserDefaults.standard.string(forKey: "email"))
                .execute()
                .value
            
            print("Successfully fetched \(fetchedSessions.count) sessions")
            print("Session data: \(fetchedSessions)")
            
            self.sessions = fetchedSessions
            
            //fake sample data below
          /*  self.sessions.append(SessionHistory(startTime: "2025-02-23T16:22:56", endTime: "2025-02-24T10:20:56"))
            self.sessions.append(SessionHistory(startTime: "2025-02-24T16:22:56", endTime: "2025-02-25T08:40:56"))
            self.sessions.append(SessionHistory(startTime: "2025-02-25T16:22:56", endTime: "2025-02-26T06:40:56")) */
            
            
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
