//
//  ContentView.swift
//  Meta-IOS-Capstone
//
//  Created by Samuel Mensa on 23/07/2024.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @State private var isOnboardingComplete: Bool = false
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
        animation: .default)
    private var items: FetchedResults<Item>
    
    var body: some View {
        Group {
                    if isOnboardingComplete {
                        MainView()
                    } else {
                        OnboardingView(isOnboardingComplete: $isOnboardingComplete)
                    }
                }
                .onAppear {
                    checkOnboardingStatus()
                }
    }
    
    func checkOnboardingStatus() {
        let firstName = UserDefaults.standard.string(forKey: "firstName")
        let lastName = UserDefaults.standard.string(forKey: "lastName")
        let email = UserDefaults.standard.string(forKey: "email")
        
        isOnboardingComplete = firstName != nil && lastName != nil && email != nil
    }
    
    
}

struct MainView: View {
    var body: some View {
        Text("Main Content")
            .font(.largeTitle)
    }
}

#Preview {
    ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
