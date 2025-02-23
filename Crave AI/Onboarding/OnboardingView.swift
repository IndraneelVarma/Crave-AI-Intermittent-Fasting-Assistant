//
//  OnboardingView.swift
//  Crave AI
//
//  Created by Indraneel Varma on 22/02/25.
//


import SwiftUI

struct OnboardingView: View {
    @StateObject private var viewModel = OnboardingViewModel()
    
    var body: some View {
        VStack {
            if viewModel.currentStep == 0 {
                WelcomeScreen(viewModel: viewModel)
            } else if viewModel.currentStep == 1 {
                ProfileSetupScreen(viewModel: viewModel)
            } else {
                FastingScheduleScreen(viewModel: viewModel)
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView()
    }
}
