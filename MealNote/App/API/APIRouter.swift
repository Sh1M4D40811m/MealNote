//
//  APIRouter.swift
//  MealNote
//
//  Created by shimadamio on 2025/04/16.
//

import Foundation
import Alamofire

enum APIRouter: URLRequestConvertible {
    case getDiaryTop(userID: Int, date: String)

    var method: HTTPMethod {
        switch self {
        case .getDiaryTop: return .get
        }
    }

    var path: String {
        switch self {
        case .getDiaryTop:
            return "/meals"
        }
    }

    func asURLRequest() throws -> URLRequest {
        var components = URLComponents(string: "http://localhost:3000")
        components?.path = path

        switch self {
        case .getDiaryTop(let userID, let date):
            components?.queryItems = [
                URLQueryItem(name: "id", value: "\(userID)"),
                URLQueryItem(name: "date", value: date)
            ]
        }

        guard let url = components?.url else {
            throw URLError(.badURL)
        }

        var request = URLRequest(url: url)
        request.method = method
        return request
    }
}

