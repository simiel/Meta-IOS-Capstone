//
//  Menu.swift
//  Meta-IOS-Capstone
//
//  Created by Samuel Mensa on 23/07/2024.
//

import Foundation

struct MenuList: Decodable {
    let menu: [MenuItem]
}

struct MenuItem: Decodable, Hashable {
    let title: String
    let image: String
    let price: String
    let description: String
    let category: String
    
}
