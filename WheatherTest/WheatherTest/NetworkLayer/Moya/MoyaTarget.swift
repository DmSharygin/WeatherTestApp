//
//  MoyaTarget.swift
//  WheatherTest
//
//  Created by Dmitry Sharygin on 16.05.2018.
//  Copyright © 2018 Dmitry Sharygin. All rights reserved.
//

import Foundation
import Moya

struct MoyaTarget: Moya.TargetType {
    var baseURL: URL
    
    var path: String {
        return apiRequest.path
    }
    
    var method: Moya.Method {
        
        switch apiRequest.method {
        case .get:
            return .get
            
        case .post:
            return .post
            
        case .put:
            return .put
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch apiRequest.method {
            
        case .get:
            return apiRequest.params.count == 0 ? .requestPlain: .requestCompositeData(bodyData: Data(), urlParameters: apiRequest.params)
            
        case .post:
            return .requestParameters(parameters: apiRequest.params, encoding: paramsEncoding)
            
        default:
            fatalError("Not implemented task for api method: \(apiRequest.method.rawValue)")
        }
    }
    
    var headers: [String: String]? {
        let headers = ["Content-Type": "application/json"]
        
        return headers
    }
    
    private var paramsEncoding: Moya.ParameterEncoding {
        switch method {
        case .get:
            return URLEncoding.default
        default:
            return JSONEncoding.default
        }
    }
    
    private let apiRequest: ApiRequest
    private let authToken: String?
    
    init(baseUrl: String, authToken: String?, apiRequest: ApiRequest) {
        self.baseURL = URL(string: baseUrl)!
        self.authToken = authToken
        self.apiRequest = apiRequest
        
    }
}
