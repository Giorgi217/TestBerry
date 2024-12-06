//
//  ProfilePageModel.swift
//  StayConnected
//
//  Created by Giorgi Amiranashvili on 06.12.24.
//

import Foundation

struct Profile: Codable {
    var userName: String
    var email: String
    var profilePicture: String?
    var score: Int
    var createdAt: String

    enum CodingKeys: String, CodingKey {
        case userName = "username"
        case email
        case profilePicture = "profile_picture"
        case score
        case createdAt = "created_at"
    }
}

