//
//  ApiEndPoints.swift
//  NetworkSwiftUi
//
//  Created by Sree Harsha Vaddi on 08/06/22.
//

import Foundation

/// Api End points
enum ApiEndPoints {
    /// `/users`
    case users
    /// /posts/?userId=`:id`
    case posts(userId: Int)

    /// Url path
    var path: String {
        switch self {
        case .users:
            return AppConstants.baseUrl + "/users"
        case let .posts(userId):
            return AppConstants.baseUrl + "/posts/?userId=\(userId)"
        }
    }

    /// file name : json file name
    var fileName: String {
        switch self {
        case .users:
            return "UserListSuccess"
        case .posts:
            return "PostListSuccess"
        }
    }
}
