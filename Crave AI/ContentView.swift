//
//  ContentView.swift
//  Crave AI
//
//  Created by Indraneel Varma on 22/02/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack{
            if UserDefaults.standard.string(forKey: "email")?.count ?? 0 < 1 {
                AuthView()
            }
            else {
                HomeView()
            }
        }
    }
}

#Preview {
    ContentView()
}
