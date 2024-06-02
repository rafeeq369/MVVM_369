//
//  PostModel.swift
//  MVVM_Snapay
//
//  Created by Rabeef Rahuman on 6/1/24.
//

import Foundation

// MARK: - PostModel
struct PostModel: Codable {
    let userID, id: Int?
    let title, body: String?

    enum CodingKeys: String, CodingKey {
        case userID = "userId"
        case id, title, body
    }
}
