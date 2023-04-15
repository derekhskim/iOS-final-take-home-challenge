//
//  Model.swift
//  ios-final-take-home-challenge
//
//  Created by Derek Kim on 2023-04-14.
//

import Foundation

// MARK: - Response
struct Response: Codable {
    let msg: String
    let msgCode: Int
    let data: DataClass

    enum CodingKeys: String, CodingKey {
        case msg
        case msgCode = "msg_code"
        case data
    }
}

// MARK: - DataClass
struct DataClass: Codable {
    let firstName, userName, lastName: String
}

// MARK: - ChangePasswordResponse
struct ChangePasswordResponse: Codable {
    let msg: String
    let msgCode: Int

    enum CodingKeys: String, CodingKey {
        case msg
        case msgCode = "msg_code"
    }
}
