//
//  UserDetailVM.swift
//  NetworkSwiftUi
//
//  Created by Sree Harsha Vaddi on 08/06/22.
//

import Foundation

/// User Detail View model
class UserDetailVM: ObservableObject {
    /// list of posts
    @Published var listOfPosts: [Post] = []
    /// `isLoading` : for progress view . If it is `true` then shows progress view other shows content
    @Published var isLoading = false
    /// Shows the error message when api failes
    @Published var errorMessage: String? = nil
    /// seleted user
    var user: User
    /// post service : Helps to communicate with network layer
    var postService: PostServicePotocol

    /// Initializer with dependency injection of postservice and selected user
    init(user: User, postService: PostServicePotocol = PostService()) {
        self.user = user
        self.postService = postService
        fetchPosts(userId: self.user.id)
    }

    /// fetch posts by selected user
    func fetchPosts(userId _: Int) {
        isLoading = true
        postService.fetchPosts(userId: user.id) { [weak self] result in
            DispatchQueue.main.async {
                guard let strongSelf = self else {
                    print("Non existing of self")
                    return
                }
                strongSelf.isLoading = false
                switch result {
                case let .failure(error):
                    strongSelf.errorMessage = error.localizedDescription
                case let .success(posts):
                    strongSelf.listOfPosts = posts
                }
            }
        }
    }
}
