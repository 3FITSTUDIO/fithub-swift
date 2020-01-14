//
//  PickerView.swift
//  fit-swift-client
//
//  Created by admin on 14/01/2020.
//  Copyright © 2020 Dominik Urbaez Gomez. All rights reserved.
//

import Foundation
import UIKit
import EasyPeasy

class PickerView: UIView {
    
    let label = Label(label: "Weight: ", fontSize: 34)
    let picker = UIPickerView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.easy.layout(Height(100), Width(170))
        label.textColor = .white
        picker.setValue(UIColor.white, forKey: "textColor")
        self.addSubviews(subviews: [label, picker])
        label.easy.layout(CenterY(), Left(24))
        picker.easy.layout(CenterY(), Left(30).to(label, .rightMargin), Width(100))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
