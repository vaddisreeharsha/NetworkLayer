//
//  ApiService.swift
//  NetworkSwiftUi
//
//  Created by Sree Harsha Vaddi on 08/06/22.
//

import Foundation
import SwiftUI

/// Api Service
public struct ApiService {
    /// Fetch Data
    /// - Parameters :
    /// - Type : Model
    /// - Url : Api Url
    /// - Return : Completion handler of result
    public func fetchData<T: Decodable>(_ type: T.Type, url: URL?, completion: @escaping (Result<T, ApiError>) -> Void) {
        guard let url = url else {
            let error = ApiError.badUrl
            completion(Result.failure(error))
            return
        }
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error as? URLError {
                completion(Result.failure(ApiError.url(error)))
            } else if let response = response as? HTTPURLResponse, !(200 ... 299).contains(response.statusCode) {
                completion(Result.failure(ApiError.badResponse(statusCode: response.statusCode)))
            } else if let data = data {
                let decoder = JSONDecoder()
                do {
                    let result = try decoder.decode(type, from: data)
                    completion(Result.success(result))
                } catch {
                    completion(Result.failure(ApiError.parsing(error as? DecodingError)))
                }
            }
        }
        task.resume()
    }
}
