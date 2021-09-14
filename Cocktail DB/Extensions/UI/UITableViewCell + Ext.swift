//
//  UITableViewCell + Ext.swift
//  Cocktail DB
//
//  Created by Dmitiy Golovnia on 13.09.2021.
//

import UIKit

extension UITableViewCell {
    
    static var reuseId: String {
        String(describing: Self.self)
    }
    
}


