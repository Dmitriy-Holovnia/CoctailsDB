//
//  API.swift
//  Cocktail DB
//
//  Created by Dmitiy Golovnia on 13.09.2021.
//

import Foundation
import Moya

enum API {
    
    case getCategories
    case getDrinks(category: String)
}

extension API: TargetType {
    
    var baseURL: URL {
        return URL(string: "https://www.thecocktaildb.com/api/json/v1/1")!
    }
    
    var path: String {
        switch self {
        case .getCategories:
            return "/list.php"
        case .getDrinks:
            return "/filter.php"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getCategories:
            return .get
        case .getDrinks:
            return .get
        }
    }
    
    var parameterEncoding : Moya.ParameterEncoding {
        return URLEncoding.default
    }
    
    var task: Task {
        switch self {
        case .getCategories:
            return .requestParameters(parameters: ["c" : "list"], encoding: URLEncoding.queryString)
        case .getDrinks(let category):
            return .requestParameters(parameters: ["c" : category], encoding: URLEncoding.queryString)
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var headers: [String : String]? {
        return nil
    }
}
