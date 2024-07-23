//
//  UserView.swift
//  Meta-IOS-Capstone
//
//  Created by Samuel Mensa on 23/07/2024.
//

import SwiftUI

struct UserView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @Binding var isOnboardingComplete: Bool
    
    
    let firstName = UserDefaults.standard.string(forKey: "firstName") ?? ""
       let lastName = UserDefaults.standard.string(forKey: "lastName") ?? ""
       let email = UserDefaults.standard.string(forKey: "email") ?? ""
    
    var body: some View {
        VStack{
            
            Text("Personal information")
                           .font(.largeTitle)
                           .padding()

                       Image("image")
                           .resizable()
                           .scaledToFit()
                           .frame(width: 150, height: 150)
                           .clipShape(Circle())
                           .padding()
            
            Text("First Name: \(firstName)")
                            .font(.headline)
                            .padding()

                        Text("Last Name: \(lastName)")
                            .font(.headline)
                            .padding()

                        Text("Email: \(email)")
                            .font(.headline)
                            .padding()
            
            Button(action: {
                           UserDefaults.standard.set(false, forKey: "IsLoggedIn")
                UserDefaults.standard.set(nil, forKey: "firstName")
                UserDefaults.standard.set(nil, forKey: "lastName")
                UserDefaults.standard.set(nil, forKey: "email")
                           isOnboardingComplete = false
                       }) {
                           Text("Logout")
                               .font(.headline)
                               .padding()
                               .background(Color.red)
                               .foregroundColor(.white)
                               .cornerRadius(10)
                       }
                       .padding()

                       Spacer()

        }
    }
}

#Preview {
    UserView(isOnboardingComplete: .constant(false))
}
