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
    case data
    case jsonDecoding(error: Error?)
    case query
    case githubApi(errors: [GitHubResponseErrorModel]?)
 
    static let domain = "app.network"
    
    var localizedDescription: String {
        switch self {
        case .response(let error):
            return error?.localizedDescription ?? self.localizedDescription
        case .jsonDecoding(let error):
            return error?.localizedDescription ?? self.localizedDescription
        case .githubApi(let errors):
            return errors?.first?.message ?? self.localizedDescription
        default:
            return self.localizedDescription
        }
    }
}

class NetworkManager {
    
    typealias HeaderType = [String: String]
    
    static let defaultHeader: HeaderType = [
        "Content-Type": "application/json"
    ]
    
    // MARK: Request
    
    typealias DataResult = Swift.Result<Data, NetworkError>
    typealias DataResultHandler = (DataResult) -> Void
    
    @discardableResult
    func request(
        with url: URL,
        type: HTTPMethod,
        header: HeaderType = NetworkManager.defaultHeader,
        body: String? = nil,
        handler: @escaping DataResultHandler) -> DataRequest {

        var req = URLRequest(url: url)
        req.httpMethod = type.rawValue
        req.allHTTPHeaderFields = header
        req.setHttpBodyIfExist(body)

        return Alamofire
            .request(req)
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
                print(error)
                handler(.failure(error))
            }
        }
    }
}
