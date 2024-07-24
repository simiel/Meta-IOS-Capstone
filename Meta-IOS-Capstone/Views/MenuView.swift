//
//  MenuView.swift
//  Meta-IOS-Capstone
//
//  Created by Samuel Mensa on 23/07/2024.
//

import SwiftUI
import CoreData

struct Menu: View {
    @Environment(\.managedObjectContext) private var viewContext
    @State private var menuItems: [MenuItem] = []
    
    @FetchRequest(
        entity: Dish.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \Dish.title, ascending: true)]
    ) var dishes: FetchedResults<Dish>
    
    
    var body: some View {
        NavigationView {
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
                
                
                if dishes.isEmpty {
                    Text("Loading menu...")
                } else {
                    List {
                        ForEach(dishes) { dish in
                            NavigationLink(destination: DishDetailView(dish: dish)) {
                                HStack {
                                    Text("\(dish.title ?? "") - \(dish.price ?? "")")
                                    
                                    Spacer()
                                    AsyncImage(url: URL(string: dish.image ?? "")) { image in
                                        image.resizable()
                                            .scaledToFit()
                                            .frame(width: 100, height: 100)
                                    } placeholder: {
                                        ProgressView()
                                    }
                                }
                            }
                        }
                    }
                }
            }
            .onAppear {
                getMenuData()
            }
        }
    }
    
    func getMenuData() {
        let urlString = "https://raw.githubusercontent.com/Meta-Mobile-Developer-PC/Working-With-Data-API/main/menu.json"
        guard let url = URL(string: urlString) else { return }
        
        let request = URLRequest(url: url)
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                let decoder = JSONDecoder()
                if let menuList = try? decoder.decode(MenuList.self, from: data) {
                    DispatchQueue.main.async {
                        self.menuItems = menuList.menu
                        saveMenuItemsToDatabase(menuItems: menuList.menu)
                    }
                }
            }
        }
        task.resume()
    }
    
    func saveMenuItemsToDatabase(menuItems: [MenuItem]) {
        // Clear existing data
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = Dish.fetchRequest()
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        
        do {
            try viewContext.execute(deleteRequest)
        } catch {
            print("Failed to delete existing records: \(error)")
        }
        
        // Save new data
        for menuItem in menuItems {
            let dish = Dish(context: viewContext)
            dish.title = menuItem.title
            dish.desc = menuItem.description
            dish.price = menuItem.price
            dish.image = menuItem.image
            dish.category = menuItem.category
        }
        
        do {
            try viewContext.save()
        } catch {
            print("Failed to save new records: \(error)")
        }
    }
}

struct Menu_Previews: PreviewProvider {
    static var previews: some View {
        let persistenceController = PersistenceController.shared
        
        Menu()
            .environment(\.managedObjectContext, persistenceController.container.viewContext)
    }
}
