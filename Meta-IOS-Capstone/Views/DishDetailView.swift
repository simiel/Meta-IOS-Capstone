//
//  DishDetailView.swift
//  Meta-IOS-Capstone
//
//  Created by Samuel Mensa on 24/07/2024.
//

import SwiftUI

struct DishDetailView: View {
    let dish: Dish

    var body: some View {
        VStack(alignment: .leading) {
            Text(dish.title ?? "No Title")
                .font(.largeTitle)
                .padding(.bottom, 10)

            Text(dish.desc ?? "No Description")
                .padding(.bottom, 10)

            Text("Price: \(dish.price ?? "No Price")")
                .padding(.bottom, 10)

            if let imageUrlString = dish.image, let imageUrl = URL(string: imageUrlString) {
                AsyncImage(url: imageUrl) { image in
                    image.resizable()
                         .scaledToFit()
                         .frame(height: 200)
                } placeholder: {
                    ProgressView()
                }
            } else {
                Text("No Image")
            }

            Spacer()
        }
        .padding()
        .navigationTitle(dish.title ?? "Dish Details")
    }
}

struct DishDetailView_Previews: PreviewProvider {
    static var previews: some View {
        let persistenceController = PersistenceController.shared
        let viewContext = persistenceController.container.viewContext
        let dish = Dish(context: viewContext)
        dish.title = "Sample Dish"
        dish.desc = "This is a sample dish description."
        dish.price = "9.999"
        dish.image = "https://example.com/sample.jpg"

        return NavigationView {
            DishDetailView(dish: dish)
                .environment(\.managedObjectContext, viewContext)
        }
    }
}
