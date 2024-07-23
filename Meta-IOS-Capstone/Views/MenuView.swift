//
//  MenuView.swift
//  Meta-IOS-Capstone
//
//  Created by Samuel Mensa on 23/07/2024.
//

import SwiftUI

struct Menu: View {
    @State private var menuItems: [MenuItem] = []
        @Environment(\.managedObjectContext) private var viewContext
    
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
                ForEach(menuItems, id: \.self){
                    item in
                    Text(item.title)
                        
                }
            }
        }
        .padding()
        .onAppear {
                    getMenuData()
                }
    }
    
    private func getMenuData() {
            let urlString = "https://raw.githubusercontent.com/Meta-Mobile-Developer-PC/Working-With-Data-API/main/menu.json"
            guard let url = URL(string: urlString) else { return }
            
            let request = URLRequest(url: url)
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                if let data = data {
                    let decoder = JSONDecoder()
                    if let menuList = try? decoder.decode(MenuList.self, from: data) {
                        DispatchQueue.main.async {
                            self.menuItems = menuList.menu
//                            saveMenuItems(menuList.menu)
                        }
                    }
                }
            }
            task.resume()
        }
}

#Preview {
    Menu()
}
