//
//  DrinksPresenter.swift
//  Cocktail DB
//
//  Created by Dmitiy Golovnia on 13.09.2021.
//

import Foundation
import UIKit

protocol DrinksPresenterProtocol: AnyObject {
    var router: DrinksRouterProtocol! { set get }
    var interactor: DrinksInteractorProtocol! { get set }
    var view: DrinksViewProtocol { get }
    var currentCategory: Category? { get set }
    
    init(view: DrinksViewProtocol)
    
    func configureView()
    func updateView()
    func numberOfDrinks(for section: Int) -> Int
    func titleForSection(section: Int) -> String
    func drink(for indexPath: IndexPath) -> Drink
    func fetchNewDrinks()
    func showHud()
    func hideHud()
    func filterButtonTapped()
}

class DrinksPresenter: DrinksPresenterProtocol {
    
    var router: DrinksRouterProtocol!
    var view: DrinksViewProtocol
    
    var isLoading: Bool = false
    var currentCategory: Category?
    var selectedCategories: [Category] = [] {
        didSet {
            updateView()
        }
    }
    
    required init(view: DrinksViewProtocol) {
        self.view = view
    }
    
    var isFilterApplied: Bool {
        selectedCategories.count > 0
    }
    
    var numberOfCategories: Int {
        if isFilterApplied {
            return selectedCategories.count
        } else {
            return interactor.drinks.count
        }
    }
    
    var interactor: DrinksInteractorProtocol!
    
    func configureView() {
        interactor.getAllDrinkFilters()
        view.showHud()
    }
    
    func updateView() {
        view.hideHud()
        isLoading = false
        view.updateFilterButton()
        view.reloadTableView()
    }
    
    func fetchNewDrinks() {
        if !isLoading {
            view.showHud()
            guard let category = currentCategory,
                  let index = interactor.categories.firstIndex(of: category),
                  index + 1 < interactor.categories.count else { return }
            let nextCategory = interactor.categories[index + 1]
            currentCategory = nextCategory
            interactor.getDrinks(for: nextCategory)
            isLoading = true
        }
    }
    
    func titleForSection(section: Int) -> String {
        isFilterApplied ? selectedCategories[section].strCategory : interactor.categories[section].strCategory
    }
    
    func numberOfDrinks(for section: Int) -> Int {
        if isFilterApplied {
            let category = selectedCategories[section]
            return interactor.drinks[category]?.count ?? 0
        } else {
            let category = interactor.categories[section]
            return interactor.drinks[category]?.count ?? 0
        }
    }
    
    func drink(for indexPath: IndexPath) -> Drink {
        let category: Category = isFilterApplied
            ? selectedCategories[indexPath.section]
            : interactor.categories[indexPath.section]
        let drink = interactor.drinks[category]![indexPath.row]
        return drink
    }
    
//    func getDrink(for category: Int) -> Drink {
//        interactor.drinks[index]
//    }
    
    func showHud() {
        view.showHud()
    }
    
    func hideHud() {
        view.hideHud()
    }
    
    func filterButtonTapped() {
        router.showFilterVC(with: interactor.categories, selectedCategories: selectedCategories)
    }
}
