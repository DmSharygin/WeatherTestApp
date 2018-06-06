//
//  APIError.swift
//  WheatherTest
//
//  Created by Dmitry Sharygin on 12.05.2018.
//  Copyright © 2018 Dmitry Sharygin. All rights reserved.
//

import Foundation


protocol ApiError: Error {
    var statusCode: Int {get}
    var type: ApiErrorType {get}
    var errorCode: Int? {get}
    var description: String? {get}
    var message: String? {get}
    var plainBody: String? {get}
    
}

enum ApiErrorType {
    case noConnection
    case lostConnection
    case unauthorized
    case internalServerError
    case badRequest
    case cancelled
    case timedOut
    case notFound
    case forbidden
    case unspecified(statusCode: Int)
}

struct ApiErrorStruct: ApiError {
    
    public var statusCode: Int = 0
    public var type: ApiErrorType = .unspecified(statusCode: 0)
    public var errorCode: Int?
    public var description: String?
    public var message: String?
    public var plainBody: String?
    
    init(statusCode: Int?, data: Data?) {
        guard let statusCode = statusCode else {
            return
        }
        
        self.statusCode = statusCode
        
        setupErrorType(byCode: statusCode)
        parseData(data: data)
    }
    
    init(error: ApiError) {
        self.description = error.localizedDescription
        self.statusCode = error.statusCode
        self.type = error.type
        self.message = error.message
        self.errorCode = error.errorCode
        self.plainBody = error.plainBody
    }
    
    public func messageForError(itemDescription description: String? = nil) -> String {
        
        switch self.type {
        case .noConnection, .lostConnection:
            return "Нет подключения к интернету"
        case .timedOut:
            return "Не удалось загрузить данные с сервера! Попробуйте повторить запрос позже"
        case .notFound:
            let description = description ?? "элемент"
            return "Не удалось найти \(description)"
        default:
            return "Не удалось загрузить данные с сервера! Попробуйте повторить запрос позже"
        }
    }
    
    private mutating func setupErrorType(byCode code: Int) {
        var errorType: ApiErrorType
        
        switch code {
        case URLError.notConnectedToInternet.rawValue, URLError.cannotFindHost.rawValue, URLError.cannotConnectToHost.rawValue:
            errorType = .noConnection
            
        case URLError.timedOut.rawValue:
            errorType = .timedOut
            
        case URLError.networkConnectionLost.rawValue:
            errorType = .lostConnection
            
        case 400:
            errorType = .badRequest
            
        case 401:
            errorType = .unauthorized
            
        case 404:
            errorType = .notFound
            
        case 403:
            errorType = .forbidden
            
        case 500...599:
            errorType = .internalServerError
            
        default:
            errorType = .unspecified(statusCode: code)
        }
        
        self.type = errorType
    }
    
    private mutating func parseData(data: Data?) {
        guard let data = data else {
            return
        }
        
        self.plainBody = String.init(data: data, encoding: .utf8)
        
        do {
            let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
            
            self.errorCode = json?["ApiErrorCode"] as? Int
            self.description = json?["CommonDescription"] as? String
            self.message = json?["Message"] as? String
            
        } catch let error {
            print("Can't parse network error body: \(error)")
        }
    }
}
