//
//  PostService.swift
//  NetworkSwiftUi
//
//  Created by Sree Harsha Vaddi on 08/06/22.
//

import Foundation

protocol PostServicePotocol {
    func fetchPosts(userId: Int, completion: @escaping (Result<[Post], ApiError>) -> Void)
}

/// Intermediate layer between n/w call and view model
struct PostService: PostServicePotocol {
    func fetchPosts(userId: Int, completion: @escaping (Result<[Post], ApiError>) -> Void) {
        let url = URL(string: ApiEndPoints.posts(userId: userId).path)
        ApiService().fetchData([Post].self, url: url) { result in
            completion(result)
        }
    }
}
