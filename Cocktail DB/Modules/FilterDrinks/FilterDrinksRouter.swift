//
//  FilterDrinksRouter.swift
//  Cocktail DB
//
//  Created by Dmitiy Golovnia on 13.09.2021.
//

import Foundation

protocol FilterDrinksRouterProtocol {
    var viewController: FilterDrinksVC { get }
    init(viewController: FilterDrinksVC)
    func popVC()
}

class FilterDrinksRouter: FilterDrinksRouterProtocol {
    
    var viewController: FilterDrinksVC
    
    required init(viewController: FilterDrinksVC) {
        self.viewController = viewController
    }
    
    func popVC() {
        viewController.popVC()
    }
    
    
}
