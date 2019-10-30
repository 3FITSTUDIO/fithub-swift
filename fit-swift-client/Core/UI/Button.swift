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
    
    let basicHeight = CommonUIConstants.ButtonConstants.basicButtonHeight
    let basicWidth = CommonUIConstants.ButtonConstants.basicButtonWidth
    
    let image = UIImageView()

    let label: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.fontSize(size: 20)
        label.textColor = .white
        label.adjustsFontSizeToFitWidth = false
        label.numberOfLines = 1
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
        self.isUserInteractionEnabled = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(){
        self.easy.layout(
            Height(basicHeight),
            Width(basicWidth))
        
        image.easy.layout(Edges())
        image.image = UIImage(bundleName: "button-1")
        
       
        label.easy.layout(Center())
        
        label.text = "KASPER!"
        
        
        self.layer.cornerRadius = 15
        self.layer.borderColor = UIColor.white.cgColor
        self.layer.borderWidth = 2
        self.layer.masksToBounds = true
    }
}
