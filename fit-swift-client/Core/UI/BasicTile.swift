//
//  BasicTile.swift
//  fit-swift-client
//
//  Created by admin on 03/12/2019.
//  Copyright © 2019 Dominik Urbaez Gomez. All rights reserved.
//

import Foundation
import UIKit
import EasyPeasy

class BasicTile: UIView {
    
    //TODO: Move wide option to Button class
    
    enum TileSize {
        case small, big, wide, cell, roundButton, custom
    }
    
    private var size: TileSize = .small
    private var customHeight: CGFloat = 0
    private var customWidth: CGFloat = 0
    
    let topLabel = Label(label: "", fontSize: 20)
    let bottomLabel = Label(label: "", fontSize: 30)
    let mainLabel = Label(label: "", fontSize: 50)
    let plusLabel = Label(label: "+", fontSize: 60)
    let counterTopLabel = Label(label: "", fontSize: 40)
    let wideLabel = Label(label: "", fontSize: 30)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.isUserInteractionEnabled = true
    }
    
    convenience init(size: TileSize = .small) {
        self.init()
        self.size = size
        setup()
    }
    
    convenience init(customHeight: CGFloat, customWidth: CGFloat) {
        self.init()
        self.customHeight = customHeight
        self.customWidth = customWidth
        size = .custom
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup(){
        let height: CGFloat = {
            switch size {
            case .small: return 152
            case .big: return 323
            case .wide: return 73
            case .cell: return 104
            case .roundButton: return 80
            case .custom: return customHeight
            }
        }()
        let width: CGFloat = {
            switch size {
            case .small: return 159
            case .big: return 337
            case .wide: return 337
            case .cell: return 337
            case .roundButton: return 80
            case .custom: return customWidth
            }
        }()
        
        setupLabels()
        
        self.addShadow()
        self.layer.cornerRadius = size == .roundButton ? 40 : 20
        self.easy.layout(Height(height), Width(width))
        self.layer.borderColor = FithubUI.Colors.whiteOneHundred.cgColor
        self.layer.borderWidth = 5
    }
    
    private func setupLabels() {
        [topLabel, bottomLabel, wideLabel, plusLabel, mainLabel, counterTopLabel].forEach { $0.textColor = FithubUI.Colors.classicWhite }
        
        if size == .small {
            self.addSubviews(subviews: [topLabel, bottomLabel, mainLabel])
            topLabel.easy.layout(CenterX(), Top(11))
            mainLabel.easy.layout(Center())
            bottomLabel.easy.layout(CenterX(), Bottom(13))
        }
        else if size == .big {
            self.addSubviews(subviews: [counterTopLabel])
            counterTopLabel.easy.layout(CenterX(), Top(116))
        }
        else if size == .roundButton {
            self.addSubview(plusLabel)
            plusLabel.easy.layout(Center())
        }
        else if size == .wide {
            self.addSubview(wideLabel)
            wideLabel.easy.layout(Center())
        }
        
    }
}
