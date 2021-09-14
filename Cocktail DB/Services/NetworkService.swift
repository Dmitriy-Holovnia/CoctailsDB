//
//  NetworkService.swift
//  Cocktail DB
//
//  Created by Dmitiy Golovnia on 13.09.2021.
//

import Foundation
import Moya

protocol NetworkServiceProtocol {
    var provider: MoyaProvider<API> { get }
    
    func fetchCategories(completion: @escaping (Result<CategoryStack, Error>) -> ())
    func fetchDrinks(for category: String, completion: @escaping (Result<DrinksStack, Error>) -> ())
}

class NetworkService: NetworkServiceProtocol {
    var provider = MoyaProvider<API>()
    
    func fetchCategories(completion: @escaping (Result<CategoryStack, Error>) -> ()) {
        provider.request(.getCategories) { result in
            switch result {
            case .success(let response):
                do {
                    let results = try JSONDecoder().decode(CategoryStack.self, from: response.data)
                    completion(.success(results))
                } catch {
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func fetchDrinks(for category: String, completion: @escaping (Result<DrinksStack, Error>) -> ()) {
        provider.request(.getDrinks(category: category)) { result in
            switch result {
            case .success(let response):
                do {
                    let results = try JSONDecoder().decode(DrinksStack.self, from: response.data)
                    completion(.success(results))
                } catch {
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
