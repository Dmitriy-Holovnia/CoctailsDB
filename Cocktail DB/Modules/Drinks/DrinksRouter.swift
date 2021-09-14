//
//  DrinksRouter.swift
//  Cocktail DB
//
//  Created by Dmitiy Golovnia on 13.09.2021.
//

import Foundation

protocol DrinksRouterProtocol: AnyObject {
    var viewController: DrinksVC { get }
    init(viewController: DrinksVC)
    func showFilterVC(with categories: [Category], selectedCategories: [Category])
}

class DrinksRouter: DrinksRouterProtocol {
    
    var viewController: DrinksVC
    
    required init(viewController: DrinksVC) {
        self.viewController = viewController
    }
    
    func showFilterVC(with categories: [Category], selectedCategories: [Category]) {
        let dvc = FilterDrinksVC()
        dvc.categories = categories
        dvc.selectedCategories = selectedCategories
        viewController.push(to: dvc)
    }
}
