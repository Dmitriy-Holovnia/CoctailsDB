//
//  DrinkTableCell.swift
//  Cocktail DB
//
//  Created by Dmitiy Golovnia on 13.09.2021.
//

import UIKit
import SnapKit
import SDWebImage

class DrinkTableCell: UITableViewCell {
    
    //MARK: UI Elements
    private lazy var drinkImageView = UIImageView(UIImage(named: "image-placeholder"), contentMode: .scaleAspectFit)
    private lazy var titleLabel = UILabel()
    
    //MARK: Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        drinkImageView.image = UIImage(named: "image-placeholder")
    }
    
    func configureCell(with drink: Drink) {
        titleLabel.text = drink.strDrink
        if let imageUrl = URL(string: drink.strDrinkThumb) {
            drinkImageView.sd_setImage(with: imageUrl, placeholderImage: UIImage(named: "image-placeholder"))
        }
    }
    
    //MARK: ConfigureUI
    func configureUI() {
        contentView.addSubview(drinkImageView)
        contentView.addSubview(titleLabel)
        
        drinkImageView.snp.makeConstraints { make in
            make.height.width.equalTo(52)
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(16)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalTo(drinkImageView.snp.right).offset(10)
            make.right.equalToSuperview().inset(-10)
        }
    }
}
