//
//  UserModel.swift
//  NetworkSwiftUi
//
//  Created by Sree Harsha Vaddi on 08/06/22.
//

import Foundation

// MARK: - User

/// User Model
struct User: Codable, Identifiable {
    /// User Id
    let id: Int
    /// Name of User
    let name: String?
    /// user name
    let username: String?
    /// Email-id
    let email: String
    /// Company
    let company: Company?
}

// MARK: - Company

/// Company Model
struct Company: Codable {
    /// Company Name
    let name: String
    /// Catch Phrase : optional `String`
    let catchPhrase: String?
    /// bs : optional `String`
    let bs: String?
}
