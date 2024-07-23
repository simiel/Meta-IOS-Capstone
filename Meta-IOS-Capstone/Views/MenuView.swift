//
//  MenuView.swift
//  Meta-IOS-Capstone
//
//  Created by Samuel Mensa on 23/07/2024.
//

import SwiftUI

struct Menu: View {
    var body: some View {
        VStack {
            Text("Little Lemon")
                .font(.largeTitle)
                .padding()
            
            Text("Location: East Legon Hills")
                .font(.headline)
                .padding()
            
            Text("Welcome to our restaurant! Enjoy our delicious menu.")
                .font(.subheadline)
                .padding()
            
            List {
                // Placeholder for menu items
            }
        }
        .padding()
    }
}

#Preview {
    Menu()
}
