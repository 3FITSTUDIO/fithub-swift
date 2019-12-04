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
    private var borderView = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
        settings()
    }
    
    convenience init(placeholder: String = "") {
        self.init()
        setupLayout()
        settings()
        textField.placeholder = placeholder
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
        
        self.addSubviews(subviews: [borderView, textField])
        borderView.easy.layout(Edges())
        textField.easy.layout(Left(15), Right(15), Top(), Bottom())
        borderView.layer.borderWidth = 5
        borderView.layer.borderColor = FithubUI.Colors.whiteOneHundred.cgColor
        borderView.layer.cornerRadius = 20
    }
    
    private func settings() {
        textField.textColor = .white
        textField.autocapitalizationType = .none
    }
}
