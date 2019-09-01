//
//  NetworkManager.swift
//  BaseProject
//
//  Created by dongseok lee on 15/06/2019.
//  Copyright © 2019 Good Effect. All rights reserved.
//

import Alamofire

enum NetworkError: Error {
    case undefined
    case url
    case response(error: Error?)
    case jsonDecoding(error: Error?)
}

class NetworkManager {
    
    // MARK: Session
    
    static let defaultHeader: HTTPHeaders = [
        "Content-Type": "application/json"
    ]
    
    private lazy var sessionManager: SessionManager = {
        let conf = URLSessionConfiguration.default
        conf.httpAdditionalHeaders = NetworkManager.defaultHeader
        return SessionManager(configuration: conf)
    }()

    func setAdapter(_ adapter: RequestAdapter) {
        sessionManager.adapter = adapter
    }
    func setRetrier(_ retrier: RequestRetrier) {
        sessionManager.retrier = retrier
    }
    
    // MARK: Request
    
    typealias DataResult = Swift.Result<Data, NetworkError>
    typealias DataResultHandler = (DataResult) -> Void
    
    @discardableResult
    func request(
        _ request: URLRequestConvertible,
        handler: @escaping DataResultHandler) -> DataRequest {
        return sessionManager.request(request)
            .responseData(queue: .global(qos: .background)) { response in
                switch response.result {
                case .success(let data):
                    handler(.success(data))
                case .failure(let error):
                    handler(.failure(.response(error: error)))
                }
        }
    }
}

// MARK: Decoder
extension NetworkManager {
    struct Decoder<Type: Decodable> {
        static func decodeResult(
            _ result: DataResult,
            handler: @escaping (Swift.Result<Type, NetworkError>) -> Void) {
            
            switch result {
            case .success(let data):
                do {
                    let decoder = JSONDecoder()
                    let value = try decoder.decode(Type.self, from: data)
                    handler(.success(value))
                } catch {
                    handler(.failure(.jsonDecoding(error: error)))
                }
            case .failure(let error):
                handler(.failure(error))
            }
        }
    }
}
