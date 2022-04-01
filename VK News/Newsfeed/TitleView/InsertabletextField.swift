//
//  InsertabletextField.swift
//  VK News
//
//  Created by Валентина Лучинович on 01.04.2022.
//

import Foundation
import UIKit

class InsertabletextField: UITextField {
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = #colorLiteral(red: 0.9467977881, green: 0.9467977881, blue: 0.9467977881, alpha: 1)
        placeholder = "Поиск"
        font = UIFont.systemFont(ofSize: 14)
        clearButtonMode = .whileEditing
        borderStyle = .none
        layer.cornerRadius = 10
        layer.masksToBounds = true
        
       
        
        let image = UIImage(systemName: "magnifyingglass")
        leftView = UIImageView(image: image)
        leftView?.tintColor = #colorLiteral(red: 0.6823529412, green: 0.6823529412, blue: 0.6980392157, alpha: 1)
        leftView?.contentMode = .scaleAspectFill
        leftView?.frame = CGRect(x: 0, y: 0, width: 14, height: 14)
        leftViewMode = .always
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: 36, dy: 0)
    }
    
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: 36, dy: 0)
    }
    
    override func leftViewRect(forBounds bounds: CGRect) -> CGRect {
        var rect = super.leftViewRect(forBounds: bounds)
        rect.origin.x += 12
        return rect
    }
}
