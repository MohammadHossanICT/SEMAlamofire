//
//  School.swift
//  Alomafire-Project
//
//  Created by M A Hossan on 31/01/2023.
//

import Foundation

struct School: Codable {

    // Model with respective properties with coding key
    
    let schoolName, location, overviewParagraph: String

        enum CodingKeys: String, CodingKey {
            case schoolName = "school_name"
            case location = "location"
            case overviewParagraph = "overview_paragraph"
        }
}

