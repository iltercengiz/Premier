//
//  Request.swift
//  PremierSwift
//
//  Created by Ilter Cengiz on 19/02/2017.
//  Copyright © 2017 Deliveroo. All rights reserved.
//

import Alamofire

private let APIURL = URL(string: "https://api.themoviedb.org/3")!
private let APIKey = "e4f9e61f6ffd66639d33d3dde7e3159b"

protocol Request: URLRequestConvertible {
    var method: HTTPMethod              { get }
    var path: String                    { get }
    var parameters: [String: Any]       { get }
}

extension Request {
    var method: HTTPMethod              { return .get }
    var parameters: [String: Any]       { return [:] }
    
    func asURLRequest() throws -> URLRequest {
        let url = APIURL.appendingPathComponent(path)
        guard var components = URLComponents(url: url,
                                             resolvingAgainstBaseURL: false)
        else {
            fatalError("API URL cannot be resolved! Check API URL and/or path for this request.")
        }
        let apiKeyQueryItem = URLQueryItem(name: "api_key",
                                           value: APIKey)
        var queryItems = components.queryItems ?? []
        queryItems.append(apiKeyQueryItem)
        components.queryItems = queryItems
        guard let queriedURL = components.url else {
            fatalError("URL cannot be constructed from URL components!")
        }
        do {
            var request = URLRequest(url: queriedURL)
            request.httpMethod = method.rawValue
            return try URLEncoding.methodDependent.encode(request, with: parameters)
        } catch {
            // TODO: Error handling
            throw error
        }
    }
}
