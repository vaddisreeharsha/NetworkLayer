//
//  MockService.swift
//  NetworkSwiftUi
//
//  Created by Sree Harsha Vaddi on 08/06/22.
//

import Foundation

/// Mock service : Helps to load mock data for unit test cases
struct MockService {
    /// get the mock data from local json file
    /// - Parameters:
    /// - name : file name
    /// - model : data Model, eg :- User , Post
    static func mockDataFromFile<T: Codable>(name: String, model: T.Type) throws -> T? {
        let bundlePath = Bundle.main.url(forResource: name, withExtension: "json")
        guard let path = bundlePath else {
            return nil
        }
        let data = try? Data(contentsOf: path, options: .alwaysMapped)
        guard let dataResult = data else {
            return nil
        }
        return try JSONDecoder().decode(model.self, from: dataResult)
    }
}
