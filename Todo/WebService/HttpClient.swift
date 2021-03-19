//
//  HttpClient.swift
//  Todo
//
//  Created by Arthit Thongpan on 19/3/2564 BE.
//

import Alamofire

enum ApiResult<Value> {
    case success(Value?)
    case failure(Error)
}

class HttpClient {
    func request(_ url: URLConvertible, method: HTTPMethod, parameters: Parameters? = nil, encoding: ParameterEncoding = JSONEncoding.default, completionHandler: @escaping (ApiResult<Any?>) -> Void) {
        var headers = HTTPHeaders()
        if let token = AuthorizationManager.shared.token {
            headers["Authorization"] = "Bearer \(token)"
        }
        
        AF.request(url, method: method, parameters: parameters, encoding: encoding, headers: headers)
            .validate()
            .responseJSON { response in
                switch response.result {
                case .success:
                    completionHandler(.success(response.data))
                case .failure(let error):
                    completionHandler(.failure(error))
                }
            }
    }
}

