//
//  ViewController.swift
//  Cocktail DB
//
//  Created by Dmitiy Golovnia on 13.09.2021.
//

import UIKit
import MBProgressHUD

protocol DrinksViewProtocol: AnyObject {
    func showHud()
    func hideHud()
    func setDrinksFilter()
    func reloadTableView()
    func updateFilterButton()
}

class DrinksVC: UIViewController, DrinksViewProtocol {

    //MARK: - Variables
    var presenter: DrinksPresenter!
    private let configurator: DrinksConfiguratorProtocol = DrinksConfigurator()
    
    //MARK: - UI Elements
    private lazy var tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .plain)
        table.register(DrinkTableCell.self, forCellReuseIdentifier: DrinkTableCell.reuseId)
        table.delegate = self
        table.dataSource = self
        table.rowHeight = 74
        return table
    }()
    
    private lazy var loadingHud: MBProgressHUD = {
        let hud = MBProgressHUD.showAdded(to: view, animated: true)
        hud.mode = .indeterminate
        hud.isSquare = true
        hud.label.text = "Loading"
        return hud
    }()
    
    
    //MARK: - UI Elements
    override func viewDidLoad() {
        super.viewDidLoad()
        configurator.configure(with: self)
        presenter.configureView()
        configureUI()
    }
    
    //MARK: - ConfigureUI
    func configureUI() {
        title = "Drinks"
        view.addSubview(tableView)
        view.backgroundColor = .white
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "filter-icon"),
                                                            style: .plain, target: self,
                                                            action: #selector(setDrinksFilter))
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

    // MARK: - DrinksPresenter methods
    func reloadTableView() {
        tableView.reloadData()
    }
    
    func updateFilterButton() {
        navigationItem.rightBarButtonItem?.image = presenter.isFilterApplied
            ? UIImage(named: "filter-with-badge")
            : UIImage(named: "filter-icon")
    }
    
    func showHud() {
        print(#function)
    }
    
    func hideHud() {
        print(#function)
    }
    
    @objc
    func setDrinksFilter() {
        presenter.filterButtonTapped()
    }
    
    //MARK: - Routing
    func push(to vc: UIViewController) {
        navigationController?.pushViewController(vc, animated: true)
    }
}

//MARK: - UITableViewDataSource
extension DrinksVC: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        presenter.numberOfCategories
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter.numberOfDrinks(for: section)
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        presenter.titleForSection(section: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let drink = presenter.drink(for: indexPath)
        let cell = tableView.dequeueReusableCell(withIdentifier: DrinkTableCell.reuseId,
                                                 for: indexPath) as! DrinkTableCell
        cell.configureCell(with: drink)
        return cell
    }
}

//MARK: - UITableViewDelegate
extension DrinksVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offset = scrollView.contentSize.height - scrollView.contentOffset.y - scrollView.frame.height
        if offset < 0 {
            presenter.fetchNewDrinks()
        }
    }
}

