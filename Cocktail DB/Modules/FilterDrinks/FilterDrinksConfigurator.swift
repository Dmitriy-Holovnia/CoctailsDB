//
//  FilterDrinksConfigurator.swift
//  Cocktail DB
//
//  Created by Dmitiy Golovnia on 13.09.2021.
//

import Foundation

protocol FilterDrinksConfiguratorProtocol {
    func configure(with viewController: FilterDrinksVC)
}

class FilterDrinksConfigurator: FilterDrinksConfiguratorProtocol {
    
    func configure(with viewController: FilterDrinksVC) {
        
        let presenter = FilterDrinksPresenter(view: viewController)
        viewController.presenter = presenter
        
        let interactor = FilterDrinksInteractor(presenter: presenter)
        presenter.interactor = interactor
        
        let router = FilterDrinksRouter(viewController: viewController)
        presenter.router = router
    }
}
