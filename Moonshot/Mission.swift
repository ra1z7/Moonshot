//
//  Mission.swift
//  Moonshot
//
//  Created by Purnaman Rai (College) on 11/09/2025.
//

import Foundation

struct Mission: Codable, Hashable, Identifiable {
    struct CrewRole: Codable, Hashable {
        let name: String
        let role: String
    }
    
    let id: Int
    let launchDate: Date? // if we mark a property as optional, Codable will automatically skip over it if the value is missing from our input JSON.
    let crew: [CrewRole]
    let description: String
    
    var displayName: String {
        "Apollo \(id)"
    }
    
    var imageName: String {
        "apollo\(id)"
    }
    
    var formattedLaunchDate: String {
        launchDate?.formatted(date: .abbreviated, time: .omitted) ?? "N/A"
    }
}
