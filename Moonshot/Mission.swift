//
//  Mission.swift
//  Moonshot
//
//  Created by Purnaman Rai (College) on 11/09/2025.
//

import Foundation

struct Mission: Codable, Identifiable {
    struct CrewRole: Codable {
        let name: String
        let role: String
    }
    
    let id: Int
    let launchDate: String? // if we mark a property as optional, Codable will automatically skip over it if the value is missing from our input JSON.
    let crew: [CrewRole]
    let description: String
}
