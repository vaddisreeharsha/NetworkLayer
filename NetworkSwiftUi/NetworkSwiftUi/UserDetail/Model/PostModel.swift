//
//  PostModel.swift
//  NetworkSwiftUi
//
//  Created by Sree Harsha Vaddi on 08/06/22.
//

import Foundation

/// Post Model
struct Post: Codable, Identifiable {
    /// UserId
    let userId: Int
    /// id
    let id: Int
    /// title
    let title: String
    /// body
    let body: String?
}
