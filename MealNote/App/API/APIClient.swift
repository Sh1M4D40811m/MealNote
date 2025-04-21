//
//  APIClient.swift
//  MealNote
//
//  Created by shimadamio on 2025/04/16.
//

import Alamofire
import RxSwift

class APIClient {
    func request<T: Decodable>(_ urlRequest: URLRequestConvertible) -> Single<T> {
        return Single<T>.create { single in
            let request = AF.request(urlRequest)
                .validate()
                .responseDecodable(of: T.self) { response in
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
