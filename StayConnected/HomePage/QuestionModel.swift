//
//  QuestionModel.swift
//  StayConnected
//
//  Created by Giorgi on 01.12.24.
//

import Foundation

struct QuestionModel: Decodable{
    let subject: String
    let text: String
    let tags: [String]
}
