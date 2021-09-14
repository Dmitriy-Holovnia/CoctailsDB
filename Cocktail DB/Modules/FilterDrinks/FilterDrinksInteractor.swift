//
//  FilterDrinksInteractor.swift
//  Cocktail DB
//
//  Created by Dmitiy Golovnia on 13.09.2021.
//

import Foundation

protocol FilterDrinksInteractorProtocol {
    var presenter: FilterDrinksPresenterProtocol { get }
    init(presenter: FilterDrinksPresenterProtocol)
}

class FilterDrinksInteractor: FilterDrinksInteractorProtocol {

    var presenter: FilterDrinksPresenterProtocol
    
    required init(presenter: FilterDrinksPresenterProtocol) {
        self.presenter = presenter
    }
    
    
}
