//
//  BundleDecodable.swift
//  Moonshot
//
//  Created by Purnaman Rai (College) on 11/09/2025.
//

import Foundation

extension Bundle {
    func decode(_ fileName: String) -> [String: Astronaut] {
        guard let fileURL =  self.url(forResource: fileName, withExtension: nil) else {
            fatalError("Failed to locate \(fileName) in bundle.")
        }
        
        guard let loadedData = try? Data(contentsOf: fileURL) else {
            fatalError("Failed to load \(fileName) from bundle.")
        }
        
        
//        guard let decodedData = try? JSONDecoder().decode([String: Astronaut].self, from: loadedData) else {
//            fatalError("Failed to decode \(fileName) from bundle.")
//        }
//        return decodedData
        
        
        // Instead of just doing a generic catch, this code checks for specific decoding errors from Swift’s DecodingError enum:
        do {
            let decodedData = try JSONDecoder().decode([String: Astronaut].self, from: loadedData)
            return decodedData
        } catch DecodingError.keyNotFound(let key, let context) { // Example: JSON doesn’t contain "name" but the Astronaut struct expects it.
            fatalError("Failed to decode \(fileName) from bundle due to missing key '\(key.stringValue)' - \(context.debugDescription)")
        } catch DecodingError.valueNotFound(let type, let context) { // Example: JSON has "age": null but your struct requires an Int.
            fatalError("Failed to decode \(fileName) from bundle due to missing \(type) value - \(context.debugDescription)")
        } catch DecodingError.typeMismatch(_, let context) { // Example: JSON has "age": "thirty" but your struct expects an Int.
            fatalError("Failed to decode \(fileName) from bundle due to type mismatch - \(context.debugDescription)")
        } catch DecodingError.dataCorrupted(_) { // Example: JSON itself is invalid (broken formatting, etc.).
            fatalError("Failed to decode \(fileName) from bundle because it appears to be invalid JSON.")
        } catch {
            fatalError("Failed to decode \(fileName) from bundle: \(error.localizedDescription)")
        }
    }
}
