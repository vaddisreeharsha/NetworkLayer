//
//  UserService.swift
//  NetworkSwiftUi
//
//  Created by Sree Harsha Vaddi on 08/06/22.
//

import Foundation

protocol UserServicePotocol {
    func fetchUsers(completion: @escaping (Result<[User], ApiError>) -> Void)
}

/// Intermediate layer between n/w call and view model
struct UserService: UserServicePotocol {
    func fetchUsers(completion: @escaping (Result<[User], ApiError>) -> Void) {
        let url = URL(string: ApiEndPoints.users.path)
        ApiService().fetchData([User].self, url: url) { result in
            completion(result)
        }
    }
}
