//
//  ProfilePageModel.swift
//  StayConnected
//
//  Created by Giorgi Amiranashvili on 06.12.24.
//

import Foundation

struct Profile: Codable {
    let userName: String
    let email: String
    let profilePicture: String?
    let score: Int
    let createdAt: String

    enum CodingKeys: String, CodingKey {
        case userName = "username"
        case email
        case profilePicture = "profile_picture"
        case score
        case createdAt = "created_at"
    }
}

