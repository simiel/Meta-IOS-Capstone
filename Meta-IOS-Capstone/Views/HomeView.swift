//
//  HomeView.swift
//  Meta-IOS-Capstone
//
//  Created by Samuel Mensa on 23/07/2024.
//

import SwiftUI

struct HomeView: View {
    @Binding var isOnboardingComplete: Bool
    
    var body: some View {
        TabView {
            Menu()
                .tabItem {
                    Label("Menu", systemImage: "list.dash")
                }
            
            UserView(isOnboardingComplete: $isOnboardingComplete)
                .tabItem {
                    Label("Profile", systemImage: "person.crop.circle")
                }
        }
        .navigationBarBackButtonHidden(true)
        
    }
}

#Preview {
    HomeView( isOnboardingComplete: .constant(true))
}
