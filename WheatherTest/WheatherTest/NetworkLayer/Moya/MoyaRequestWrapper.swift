//
//  MoyaRequestWrapper.swift
//  WheatherTest
//
//  Created by Dmitry Sharygin on 16.05.2018.
//  Copyright © 2018 Dmitry Sharygin. All rights reserved.
//

import Foundation
import Moya
import Alamofire

class MoyaRequestWrapper: NetworkRequestWrapper {
    
    func runRequest(_ request: ApiRequest, baseUrl: String, token: String?, completion: @escaping (Int, Data?, ApiError?) -> Void) {
        let target = MoyaTarget(baseUrl: baseUrl, authToken: token, apiRequest: request)
        
        runWith(target: target) { (statusCode, data, error) -> Void in
            
            let body: String? = data != nil ? String.init(data: data!, encoding: .utf8): ""
            
            print("Request body: \(String(describing: body))")
            print("Request error code \(String(describing: error?.errorCode)) body: \(String(describing: error?.plainBody))")
            
            guard let error = error else {
                completion(statusCode, data, nil)
                return
            }
            
            completion(statusCode, data, error)
        }
    }
    
    private func runWith(target: MoyaTarget, completion:@escaping (Int, Data?, ApiError?) -> Void) {
        
        //        MoyaProvider<MoyaTarget>().request(target) { (result) in
        MoyaProvider<MoyaTarget>(plugins: [NetworkLoggerPlugin()]).request(target) { (result) in
            
            guard let responseValue = result.value else {
                
                var statusCode: Int = 0
                var errorData: Data? = nil
                
                if let moyaError = result.error as MoyaError? {
                    switch moyaError {
                    case .underlying(let nsErr as NSError, let response):
                        statusCode = nsErr.code
                        errorData = response?.data
                        
                    default:
                        break
                    }
                }
                
                let error = ApiErrorStruct(statusCode: statusCode, data: errorData)
                completion(statusCode, nil, error)
                
                return
            }
            
            if 200...299 ~= responseValue.statusCode {
                
                completion(responseValue.statusCode, responseValue.data, nil)
                return
            }
            
            let error = ApiErrorStruct(statusCode: responseValue.statusCode, data: responseValue.data)
            completion(responseValue.statusCode, nil, error)
        }
    }
}
