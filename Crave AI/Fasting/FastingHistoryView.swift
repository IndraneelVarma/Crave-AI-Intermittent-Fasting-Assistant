//
//  FastingHistoryView.swift
//  Crave AI
//
//  Created by Indraneel Varma on 22/02/25.
//


import SwiftUI


struct FastingHistoryView: View {
    @StateObject private var viewModel = FastingViewModel()
    
    var body: some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: [Color.blue.opacity(0.1), Color.purple.opacity(0.1)]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            
            if viewModel.sessions.isEmpty && viewModel.isLoading {
                ProgressView()
            }
            else {
                VStack(spacing: 20) {
                    // Summary card
                    VStack(spacing: 16) {
                        Text("Fasting Summary")
                            .font(.system(size: 24, weight: .bold))
                        
                        HStack(spacing: 40) {
                            VStack {
                                Text("\(viewModel.sessions.count)")
                                    .font(.system(size: 32, weight: .bold))
                                Text("Sessions")
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                            }
                            
                            VStack {
                                Text(viewModel.averageDurationFormatted)
                                    .font(.system(size: 32, weight: .bold))
                                Text("Avg. Duration")
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                            }
                        }
                    }
                    .padding(24)
                    .background(Color.white.opacity(0.9))
                    .clipShape(RoundedRectangle(cornerRadius: 16))
                    .shadow(color: Color.black.opacity(0.05), radius: 10)
                    .padding(.horizontal)
                    .padding(.top)
                    
                    if !viewModel.sessions.isEmpty
                    {
                        ScrollView {
                            LazyVStack(spacing: 16) {
                                ForEach(viewModel.sessions) { session in
                                    FastingSessionCard(session: session)
                                }
                            }
                            .padding()
                        }
                    }
                    else {
                        Text("No history")
                    }
                    
                    Spacer()
                }
            }
        }
        .onAppear {
            loadFastingHistory()
        }
    }
    
    private func loadFastingHistory() {
        Task{
            await viewModel.fetchSessions()
        }
    }
}
