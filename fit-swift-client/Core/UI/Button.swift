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
    enum ButtonType {
        case small, big, label
    }
    
    var type: ButtonType = .small

    let imageView = UIImageView()
    let buttonLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.setFont(fontName: FithubUI.Fonts.mainAvenir)
        label.fontSize(size: 20)
        label.textColor = FithubUI.Colors.buttonTextColorFullOpacity
        label.adjustsFontSizeToFitWidth = false
        label.numberOfLines = 1
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.isUserInteractionEnabled = true
    }
    
    convenience init(type: ButtonType = .small, label: String) {
        self.init()
        buttonLabel.text = label
        self.type = type
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(){
        let width: CGFloat = {
            switch type {
            case .small:
                return CommonUIConstants.ButtonConstants.smallButtonWidth
            case .big:
                return CommonUIConstants.ButtonConstants.bigButtonWidth
            case .label:
                return CommonUIConstants.ButtonConstants.labelButtonWidth
            }
        }()
        let height: CGFloat = {
            switch type {
            case .label:
                return CommonUIConstants.ButtonConstants.labelButtonHeight
            default:
                return CommonUIConstants.ButtonConstants.basicButtonHeight
            }
        }()
        
        if type == .label {
            buttonLabel.fontSize(size: 15)
            buttonLabel.textColor = .white
        }
        self.easy.layout(
            Height(height),
            Width(width))
        self.addSubviews(subviews: [imageView, buttonLabel])
        imageView.easy.layout(Edges())
        buttonLabel.easy.layout(Center())
        
        imageView.image = {
            return UIImage(named: "button-\(type)")
        }()
    }
}
