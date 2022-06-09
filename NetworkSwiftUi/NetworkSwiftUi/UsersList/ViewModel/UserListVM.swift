//
//  UserListVM.swift
//  NetworkSwiftUi
//
//  Created by Sree Harsha Vaddi on 08/06/22.
//

import Foundation

/// UserList View model
class UserListVM: ObservableObject {
    // MARK: - Properties

    /// list of users
    @Published var listOfUsers: [User] = []
    /// `isLoading` : for progress view . If it is `true` then shows progress view other shows content
    @Published var isLoading = false
    /// Shows the error message when api failes
    @Published var errorMessage: String? = nil
    /// user service : Helps to communicate with network layer
    private let userService: UserServicePotocol

    // MARK: - Initializer

    /// Initializer with dependency injection of userservice
    init(userService: UserServicePotocol = UserService()) {
        self.userService = userService
        fetchUsers()
    }

    // MARK: - Methods

    /// Fetch users
    func fetchUsers() {
        isLoading = true
        userService.fetchUsers { [weak self] result in
            DispatchQueue.main.async {
                guard let strongSelf = self else {
                    print("Non existing of self")
                    return
                }
                strongSelf.isLoading = false
                switch result {
                case let .failure(error):
                    strongSelf.errorMessage = error.localizedDescription
                case let .success(users):
                    strongSelf.listOfUsers = users
                }
            }
        }
    }
}
