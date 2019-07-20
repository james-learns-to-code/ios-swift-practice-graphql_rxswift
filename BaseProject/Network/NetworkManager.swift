//
//  NetworkManager.swift
//  BaseProject
//
//  Created by dongseok lee on 15/06/2019.
//  Copyright © 2019 Good Effect. All rights reserved.
//

import Foundation

enum NetworkError: Error {
    case url
    case response(error: Error?)
    case data
    case jsonEncoding(error: Error?)
    case query
    case githubApi(errors: [GitHubResponseErrorModel]?)
 
    static let domain = "app.network"
}

class NetworkManager {
    
    static let defaultHeader: [String: String] = [
        "Content-Type": "application/json"
    ]
    
    // MARK: Request
    
    enum RequestType: String {
        case post = "POST"
        case get = "GET"
        
        var httpMethod: String {
            return self.rawValue
        }
    }
    
    typealias DataResult = Result<Data, NetworkError>
    typealias DataResultHandler = (DataResult) -> Void
    
    @discardableResult
    func request(
        with url: URL,
        type: RequestType,
        header: [String: String] = NetworkManager.defaultHeader,
        body: String? = nil,
        handler: @escaping DataResultHandler) -> URLSessionDataTask {
        
        var req = URLRequest(url: url)
        req.httpMethod = type.httpMethod
        req.allHTTPHeaderFields = header
        
        if let body = body {
            req.httpBody = body.data(using: .utf8)
        }
        
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        
        return request(with: session, req, handler)
    }
    
    @discardableResult
    func request(
        with session: URLSession,
        _ request: URLRequest,
        _ handler: @escaping DataResultHandler) -> URLSessionDataTask {
        
        let task = session.dataTask(with: request) {
            responseData, response, responseError in
            
            guard responseError == nil else {
                handler(.failure(.response(error: responseError)))
                return
            }
            guard let data = responseData else {
                handler(.failure(.data))
                return
            }
            handler(.success(data))
        }
        task.resume()
        return task
    }
 
    // MARK: Decoder
    struct ResponseType<Type: Decodable> {
        static func decodeResult(
            _ result: DataResult,
            handler: @escaping (Result<Type, NetworkError>) -> Void) {
            
            switch result {
            case .success(let data):
                do {
                    let decoder = JSONDecoder()
                    let value = try decoder.decode(Type.self, from: data)
                    handler(.success(value))
                } catch {
                    handler(.failure(.jsonEncoding(error: error)))
                }
            case .failure(let error):
                print(error)
                handler(.failure(error))
            }
        }
    }
}
