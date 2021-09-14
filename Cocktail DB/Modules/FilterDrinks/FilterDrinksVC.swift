//
//  FilterDrinksVC.swift
//  Cocktail DB
//
//  Created by Dmitiy Golovnia on 13.09.2021.
//

import UIKit

protocol FilterDrinksViewProtocol {
    func applyFilterButtonTapped()
}

class FilterDrinksVC: UIViewController, FilterDrinksViewProtocol {
    
    //MARK: - Variables
    var categories: [Category] = []
    var selectedCategories: [Category] = []
    var presenter: FilterDrinksPresenterProtocol!
    private let configurator: FilterDrinksConfiguratorProtocol = FilterDrinksConfigurator()
    private let cellReuseId = "cell"
    
    
    //MARK: - UI Elements
    private lazy var tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .plain)
        table.register(UITableViewCell.self, forCellReuseIdentifier: cellReuseId)
        table.delegate = self
        table.dataSource = self
        table.rowHeight = 44
        table.contentInset.bottom = 100
        return table
    }()
    
    private lazy var applyFilterButton: UIButton = {
       let button = UIButton()
        button.addTarget(self, action: #selector(applyFilterButtonTapped), for: .touchUpInside)
        button.backgroundColor = UIColor.mainBlue
        button.layer.cornerRadius = 12
        button.setTitle("Apply Filter", for: .normal)
        button.setTitleColor(.white, for: .normal)
        return button
    }()
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configurator.configure(with: self)
        presenter.configureView()
        configureUI()
    }
    
    //MARK: - ConfigureUI
    func configureUI() {
        view.backgroundColor = .white
        view.addSubview(tableView)
        view.addSubview(applyFilterButton)
        
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        applyFilterButton.snp.makeConstraints { make in
            make.width.equalToSuperview().inset(16)
            make.height.equalTo(50)
            make.centerX.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-30)
        }
    }
    
    //MARK: - Routing
    func popVC() {
        if let drinksVC = navigationController?.viewControllers.first(where: { $0 is DrinksVC }) as? DrinksVC {
            drinksVC.presenter.selectedCategories = selectedCategories
        }
        navigationController?.popViewController(animated: true)
    }
    
    // MARK: - FilterDrinksPresenter methods
    @objc
    func applyFilterButtonTapped() {
        popVC()
        presenter.applyDrinksFilter()
    }
}

//MARK: - UITableViewDataSource
extension FilterDrinksVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let category = categories[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseId, for: indexPath)
        cell.textLabel?.text = category.strCategory
        cell.accessoryType = selectedCategories.contains(category) ? .checkmark : .none
        return cell
    }
}

//MARK: - UITableViewDelegate
extension FilterDrinksVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let category = categories[indexPath.row]
        if let cell = tableView.cellForRow(at: indexPath) {
            if selectedCategories.contains(category), let index = selectedCategories.firstIndex(where: {$0 == category }) {
                cell.accessoryType = .none
                selectedCategories.remove(at: index)
            } else {
                cell.accessoryType = .checkmark
                selectedCategories.append(category)
            }
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
