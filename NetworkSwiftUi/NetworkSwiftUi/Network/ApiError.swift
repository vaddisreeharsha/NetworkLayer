//
//  ApiError.swift
//  NetworkSwiftUi
//
//  Created by Sree Harsha Vaddi on 08/06/22.
//

import Foundation

/// Api Error : Different kind of api errors with description
public enum ApiError: Error, CustomStringConvertible {
    /// Bad url
    case badUrl
    /// Invalid response
    case badResponse(statusCode: Int)
    /// Url error
    case url(URLError?)
    /// Josn parsing error
    case parsing(DecodingError?)
    /// Unknown
    case unknown

    /// Localized description for UI
    public var localizedDescription: String {
        switch self {
        case .badUrl, .parsing, .unknown:
            return "Something went wrong."
        case .badResponse:
            return "Server Error"
        case let .url(error):
            return error?.localizedDescription ?? "Something went wrong."
        }
    }

    /// Description for debugging
    public var description: String {
        switch self {
        case .unknown: return "unknown error"
        case .badUrl: return "invalid URL"
        case let .url(error):
            return error?.localizedDescription ?? "url session error"
        case let .parsing(error):
            return "Parsing error \(error?.localizedDescription ?? "")"
        case let .badResponse(statusCode: statusCode):
            return "bad response with status code : \(statusCode)"
        }
    }
}
