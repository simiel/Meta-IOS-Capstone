//
//  OnboardingView.swift
//  Meta-IOS-Capstone
//
//  Created by Samuel Mensa on 23/07/2024.
//

//let kFirstName = "first name key"
//let kLastName = "last name key"
//let kEmail = "email key"

import SwiftUI

struct OnboardingView: View {
    @State private var firstName: String = ""
    @State private var lastName: String = ""
    @State private var email: String = ""
    @Binding var isOnboardingComplete: Bool
    
    var body: some View {
        NavigationView{
            VStack{
                
                NavigationLink(destination: HomeView(), isActive: $isOnboardingComplete) {
                    Text("jfjfj")
                }
                
                Text("Welcome to Little Lemon!")
                    .font(.largeTitle)
                    .padding()
                
                TextField("Enter your first name", text: $firstName )
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                
                TextField("Enter your last name", text: $lastName )
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                
                TextField("Enter your email address", text: $email )
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                    .keyboardType(.emailAddress)
                    .autocapitalization(.none)
                
                Button(action: {
                    if !firstName.isEmpty && !lastName.isEmpty && !email.isEmpty {
                        saveUserData()
                        isOnboardingComplete = true
                    } else {
                        print("All fields must be filled out.")
                    }
                }){
                    Text("Login")
                        .font(.headline)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding()
            }
            .padding()
            
        }
    }
    
    func saveUserData(){
        UserDefaults.standard.set(firstName, forKey: "firstName")
        UserDefaults.standard.set(lastName, forKey: "lastName")
        UserDefaults.standard.set(email, forKey: "email")
    }
}

#Preview {
    OnboardingView(isOnboardingComplete: .constant(false))
}
