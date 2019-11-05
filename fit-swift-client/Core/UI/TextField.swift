//
//  TextField.swift
//  fit-swift-client
//
//  Created by admin on 30/10/2019.
//  Copyright © 2019 Dominik Urbaez Gomez. All rights reserved.
//

import Foundation
import UIKit
import EasyPeasy

class TextField : UIView {
    
    let textField = UITextField()
    var borderView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
        settings()
    }
    
    convenience init(placeholder: String = "") {
        self.init()
        setupLayout()
        settings()
        self.textField.placeholder = placeholder
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout() {
        let width: CGFloat = 254
        let height: CGFloat = 42
        self.easy.layout(
            Height(height),
            Width(width))
        
        self.addSubviews(subviews: [textField, borderView])
        borderView.easy.layout(Edges())
        textField.easy.layout(Left(15), Right(15), Top(), Bottom())
        self.borderView.image = UIImage(named: "textfield")
    }
    
    func settings() {
        self.textField.textColor = .white
        self.textField.autocapitalizationType = .none
    }
}
