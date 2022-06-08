//
//  MockPostService.swift
//  NetworkSwiftUi
//
//  Created by Sree Harsha Vaddi on 08/06/22.
//

import Foundation

struct MockPostService: PostServicePotocol {
    /// show error : by default it is `false` to hit the valid response
    /// when we want to check the falure response then keep it `true`
    var showError: Bool = false

    /// Init
    init(showError: Bool = false) {
        self.showError = showError
    }

    /// fetching the mock post data
    func fetchPosts(userId: Int, completion: @escaping (Result<[Post], ApiError>) -> Void) {
        if showError {
            completion(.failure(.badResponse(statusCode: 400)))
        } else {
            completion(.success(getUsersFromFile(fileName: ApiEndPoints.posts(userId: userId).fileName)))
        }
    }

    /// helper method to get the posts from json file
    private func getUsersFromFile(fileName: String) -> [Post] {
        let post1 = Post(
            userId: 1,
            id: 1,
            title: "sunt aut facere repellat provident occaecati excepturi optio reprehenderit",
            body: "quia et suscipit\nsuscipit recusandae consequuntur expedita et cum\nreprehenderit molestiae ut ut quas totam\nnostrum rerum est autem sunt rem eveniet architecto"
        )

        let post2 = Post(
            userId: 1,
            id: 2,
            title: "qui est esse",
            body: nil
        )
        do {
            let jsonData = try MockService.mockDataFromFile(name: fileName, model: [Post].self)
            guard let posts = jsonData else {
                return [post1, post2]
            }
            return posts
        } catch {
            return [post1, post2]
        }
    }
}
