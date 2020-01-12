//
//  DashboardViewController.swift
//  fit-swift-client
//
//  Created by admin on 05/11/2019.
//  Copyright © 2019 Dominik Urbaez Gomez. All rights reserved.
//

import Foundation
import UIKit
import EasyPeasy

class DashboardViewController: BasicComponentViewController {
    enum Route: String {
        case logout
    }
    private let router = DashboardRouter()
    private let viewModel = DashboardViewModel()
    
    
    private let container = UIView()
    
    override func setup(){
        super.setup()
        view.addSubview(container)
        container.easy.layout(Edges())
    
        let weightTile = BasicTile(size: .small)
        let kcalTile = BasicTile(size: .small)
        let measurementsTile = BasicTile(size: .wide)
        let plusButton = BasicTile(size: .roundButton)
        
        let healthClockTile = HealthClockView()
        
        container.addSubviews(subviews: [healthClockTile, weightTile, kcalTile, measurementsTile, plusButton])
        healthClockTile.easy.layout(CenterX(), Top(15).to(notchBorder, .bottom))
        
        weightTile.easy.layout(Left(19), Top(22).to(healthClockTile, .bottom))
        kcalTile.easy.layout(Right(19), Top(22).to(healthClockTile, .bottom))
        measurementsTile.easy.layout(CenterX(), Top(22).to(kcalTile, .bottom))
        plusButton.easy.layout(CenterX(), Top(20).to(measurementsTile, .bottom))
        
        weightTile.topLabel.text = "Weight"
        weightTile.bottomLabel.text = "kg"
        kcalTile.topLabel.text = "Calories"
        kcalTile.bottomLabel.text = "kcal"
        measurementsTile.wideLabel.text = "See measurements"
        
        weightTile.mainLabel.text = "75"
        kcalTile.mainLabel.text = "2490"
    }
}

// MARK: Routing

extension DashboardViewController {}

