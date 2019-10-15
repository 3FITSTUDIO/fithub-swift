//
//  Button.swift
//  fit-swift-client
//
//  Created by admin on 09/10/2019.
//  Copyright © 2019 Dominik Urbaez Gomez. All rights reserved.
//

import Foundation
import UIKit
import EasyPeasy

class Button : UIView {
    
    enum Style {
        case regular, unavailable
    }
    
    let basicHeight = CommonUIConstants.ButtonConstants.basicButtonHeight
    let basicWidth = CommonUIConstants.ButtonConstants.basicButtonWidth
    let view = UIView()
    let button = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(){
        view.easy.layout(
        Height(basicHeight),
        Width(basicWidth))
    
    }
}
