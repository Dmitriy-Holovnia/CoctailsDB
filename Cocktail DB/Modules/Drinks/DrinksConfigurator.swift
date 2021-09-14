//
//  DrinksConfigurator.swift
//  Cocktail DB
//
//  Created by Dmitiy Golovnia on 13.09.2021.
//

import Foundation

protocol DrinksConfiguratorProtocol {
    func configure(with viewController: DrinksVC)
}

class DrinksConfigurator: DrinksConfiguratorProtocol {
    
    func configure(with viewController: DrinksVC) {
        
        let presenter = DrinksPresenter(view: viewController)
        viewController.presenter = presenter
        
        let interactor = DrinksInteractor(presenter: presenter)
        presenter.interactor = interactor
        
        let router = DrinksRouter(viewController: viewController)
        presenter.router = router
    }
}
