//
//  OnboardingModel.swift
//  Crave AI
//
//  Created by Indraneel Varma on 24/02/25.
//
import Foundation

struct OnboardingUploadModel: Codable, Identifiable {
    let id = UUID()
    let email = UserDefaults.standard.string(forKey: "email") ?? ""
    let name: String
    let goal: String
    let fastSchedule: String
}

struct OnboardingDownloadModel: Codable, Identifiable {
    let id: UUID
    let name: String
    let goal: String
    let fastSchedule: String
}
