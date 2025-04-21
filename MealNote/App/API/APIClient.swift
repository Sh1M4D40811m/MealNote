//
//  APIClient.swift
//  MealNote
//
//  Created by shimadamio on 2025/04/16.
//

import Foundation
import Alamofire
import RxSwift

class APIClient {
    private let decoder: JSONDecoder
    
    init() {
        self.decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        decoder.dateDecodingStrategy = .iso8601
    }
    
    func request<T: Decodable>(_ urlRequest: URLRequestConvertible) -> Single<T> {
        return Single<T>.create { single in
            let request = AF.request(urlRequest)
                .validate()
                .responseDecodable(of: T.self, decoder: self.decoder) { response in
                    switch response.result {
                    case .success(let value):
                        single(.success(value))
                    case .failure(let error):
                        single(.failure(error))
                    }
                }
            
            return Disposables.create {
                request.cancel()
            }
        }
    }
}
