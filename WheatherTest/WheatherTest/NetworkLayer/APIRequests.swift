//
//  APIRequests.swift
//  WheatherTest
//
//  Created by Dmitry Sharygin on 12.05.2018.
//  Copyright © 2018 Dmitry Sharygin. All rights reserved.
//

import Foundation

enum NetworkMethod: String {
    case post = "post"
    case get = "get"
    case put = "put"
}

protocol ApiRequest {
    var path: String {get}
    var method: NetworkMethod {get}
    var params: [String: Any] {get}
    //var authorized: Bool {get}
}

// MARK: - Post

protocol PostApiRequest: ApiRequest {}

extension PostApiRequest {
    public var method: NetworkMethod {
        return .post
    }
}

// MARK: - Get

protocol GetApiRequest: ApiRequest {}

extension GetApiRequest {
    public var method: NetworkMethod {
        return .get
    }
}
