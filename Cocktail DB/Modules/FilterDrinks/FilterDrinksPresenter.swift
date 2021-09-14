//
//  FilterDrinksPresenter.swift
//  Cocktail DB
//
//  Created by Dmitiy Golovnia on 13.09.2021.
//

import Foundation

protocol FilterDrinksPresenterProtocol {
    var router: FilterDrinksRouterProtocol! { set get }
    var interactor: FilterDrinksInteractorProtocol! { get set }
    var view: FilterDrinksViewProtocol { get }
    
    init(view: FilterDrinksViewProtocol)
    
    func configureView()
    func backButtonTapped()
    func applyDrinksFilter()
    func filterSelected(at index: Int)
    func filterDeselected(at index: Int)
}

class FilterDrinksPresenter: FilterDrinksPresenterProtocol {
    
    var router: FilterDrinksRouterProtocol!
    var interactor: FilterDrinksInteractorProtocol!
    var view: FilterDrinksViewProtocol

    required init(view: FilterDrinksViewProtocol) {
        self.view = view
    }
    
    func configureView() {
        
    }
    
    func backButtonTapped() {
        
    }
    
    func applyDrinksFilter() {
        
    }
    
    func filterSelected(at index: Int) {
        
    }
    
    func filterDeselected(at index: Int) {
        
    }
}
