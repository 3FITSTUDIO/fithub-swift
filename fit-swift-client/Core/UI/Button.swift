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
        case small, big, label, nav
    }
    
    private var type: ButtonType = .small

    private let backgroundView = UIView()
    private let buttonLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.setFont(fontName: FithubUI.Fonts.mainAvenir)
        label.fontSize(size: 20)
        label.textColor = FithubUI.Colors.highlight
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
    
    private func setup(){
        let width: CGFloat = {
            switch type {
            case .small:
                return CommonUIConstants.ButtonConstants.smallButtonWidth
            case .big:
                return CommonUIConstants.ButtonConstants.bigButtonWidth
            case .label:
                return CommonUIConstants.ButtonConstants.labelButtonWidth
            case .nav:
                return CommonUIConstants.ButtonConstants.navButtonWidth
            }
        }()
        let height: CGFloat = {
            switch type {
            case .label:
                return CommonUIConstants.ButtonConstants.labelButtonHeight
            case .nav:
                return CommonUIConstants.ButtonConstants.navButtonHeight
            default:
                return CommonUIConstants.ButtonConstants.basicButtonHeight
            }
        }()
        
        self.easy.layout(
            Height(height),
            Width(width))
        self.addSubviews(subviews: [backgroundView, buttonLabel])
        backgroundView.easy.layout(Edges())
        buttonLabel.easy.layout(Center())
        
        guard type != .label else {
            buttonLabel.fontSize(size: 15)
            buttonLabel.textColor = .white
            return
        }
        
        backgroundView.layer.borderWidth = 5
        backgroundView.layer.borderColor = FithubUI.Colors.whiteOneHundred.cgColor
        backgroundView.layer.cornerRadius = 20
        backgroundView.addShadow()       
    }
    
    func changeBackgroundColor(toColor: UIColor) {
        backgroundView.backgroundColor = toColor
    }
}
