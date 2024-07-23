//
//  HomeView.swift
//  Meta-IOS-Capstone
//
//  Created by Samuel Mensa on 23/07/2024.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        TabView {
            Menu()
                .tabItem {
                    Label("Menu", systemImage: "list.dash")
                }
        }
//        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    HomeView()
}
