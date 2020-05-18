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
        setupLayout(FithubUI.Colors.whiteOneHundred.cgColor)
        settings()
    }
    
    convenience init(placeholder: String = "", borderColor: CGColor = FithubUI.Colors.whiteOneHundred.cgColor, width: CGFloat = 254) {
        self.init()
        setupLayout(widthProvided: width, borderColor)
        settings()
        textField.placeholder = placeholder
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout(widthProvided: CGFloat = 254, _ borderColor: CGColor) {
        let width: CGFloat = widthProvided
        let height: CGFloat = widthProvided == 254 ? 42 : 38
        self.easy.layout(
            Height(height),
            Width(width))
        
        self.addSubviews(subviews: [borderView, textField])
        borderView.easy.layout(Edges())
        textField.easy.layout(Left(15), Right(15), Top(), Bottom())
        borderView.layer.borderWidth = widthProvided == 254 ? 5 : 3
        borderView.layer.borderColor = borderColor
        borderView.layer.cornerRadius = 20
    }
    
    func settings() {
        textField.textColor = .white
        textField.autocapitalizationType = .none
    }
}
