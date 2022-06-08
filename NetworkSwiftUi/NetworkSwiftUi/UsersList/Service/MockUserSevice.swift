//
//  MockUserSevice.swift
//  NetworkSwiftUi
//
//  Created by Sree Harsha Vaddi on 08/06/22.
//

import Foundation

/// Mock user service : used for unit test cases to hit mock data
struct MockUserSevice: UserServicePotocol {
    /// show error : by default it is `false` to hit the valid response
    /// when we want to check the falure response then keep it `true`
    var showError: Bool = false

    /// Init
    init(showError: Bool = false) {
        self.showError = showError
    }

    /// fetching the mock users data
    func fetchUsers(completion: @escaping (Result<[User], ApiError>) -> Void) {
        if showError {
            completion(.failure(.badResponse(statusCode: 400)))
        } else {
            completion(.success(getUsersFromFile(fileName: ApiEndPoints.users.fileName)))
        }
    }

    /// helper method to get the users from json file
    private func getUsersFromFile(fileName: String) -> [User] {
        let user1 = User(
            id: 1,
            name: "Leanne Graham",
            username: "Bret",
            email: "Sincere@april.biz",
            company: nil
        )
        let user2 = User(
            id: 2,
            name: "Ervin Howell",
            username: "Bret",
            email: "Sincere@april1.biz",
            company: nil
        )
        do {
            let jsonData = try MockService.mockDataFromFile(name: fileName, model: [User].self)
            guard let users = jsonData else {
                return [user1, user2]
            }
            return users
        } catch {
            return [user1, user2]
        }
    }
}
