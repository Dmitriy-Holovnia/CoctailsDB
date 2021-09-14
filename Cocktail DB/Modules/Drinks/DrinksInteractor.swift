//
//  DrinksInteractor.swift
//  Cocktail DB
//
//  Created by Dmitiy Golovnia on 13.09.2021.
//

import Foundation

protocol DrinksInteractorProtocol: AnyObject {
    var presenter: DrinksPresenterProtocol { get }
    var categories: [Category] { get }
    var drinks: [Category: [Drink]] { get }
    init(presenter: DrinksPresenterProtocol)

    func getAllDrinkFilters()
    func getDrinks(for category: Category)
}

class DrinksInteractor: DrinksInteractorProtocol {
    
    var presenter: DrinksPresenterProtocol
    let networkService = NetworkService()
    var drinks: [Category: [Drink]] = [:]
    var categories: [Category] = [] {
        didSet {
            if let firstCategory = categories.first {
                getDrinks(for: firstCategory)
                presenter.currentCategory = firstCategory
            }
        }
    }
    
    required init(presenter: DrinksPresenterProtocol) {
        self.presenter = presenter
    }
    
    func getAllDrinkFilters() {
        networkService.fetchCategories { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let response):
                self.categories = response.drinks
            case .failure(let error):
                debugPrint("fetchCategories error: ", error)
            }
        }
    }
    
    func getDrinks(for category: Category) {
        networkService.fetchDrinks(for: category.strCategory) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let response):
                self.drinks[category] = response.drinks
                self.presenter.updateView()
            case .failure(let error):
                debugPrint("fetchCategories error: ", error)
            }
        }
    }
}
