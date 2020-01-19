//
//  ProgressViewController.swift
//  fit-swift-client
//
//  Created by admin on 18/01/2020.
//  Copyright © 2020 Dominik Urbaez Gomez. All rights reserved.
//

import Foundation
import UIKit
import EasyPeasy

class ProgressViewController: BasicComponentViewController, ProgressViewDelegate {    
    enum Route: String {
        case back
    }
    
    private let router = ProgressRouter()
    private let progressManager = ProgressViewManager()
    private var progressView = UIView()
    
    var avgValueLabel = Label(label: "2350", fontSize: 30)
    private let avgInfLabel = Label(label: "avg", fontSize: 20)
    var selectedValueLabel = Label(label: "3060", fontSize: 70)
    private let selectedUnitLabel = Label(label: "kg", fontSize: 27)
    var selectedDateLabel = Label(label: "4.01.2020", fontSize: 20)
    
    private let weightButton = Button(type: .big, label: "Weight Progress")
    private let caloriesButton = Button(type: .big, label: "Calories Progress")
    
    override func setup() {
        super.setup()
        progressView = progressManager.container
        layout()
        addBottomNavigationBar()
        setupButtons()
    }
    
    override func viewDidLoad() {
        componentName = "Progress"
        super.viewDidLoad()
        progressManager.delegate = self
        selectedValueLabel.text = String(progressManager.weightArray[0].value[0])
    }
    
    private func layout() {
        container.addSubviews(subviews: [avgValueLabel, avgInfLabel, selectedValueLabel, selectedUnitLabel, selectedDateLabel, weightButton, caloriesButton])
        avgValueLabel.easy.layout(CenterX(), Top(26).to(notchBorder))
        avgInfLabel.easy.layout(Left(10).to(avgValueLabel, .rightMargin), Top(36).to(notchBorder))
        selectedValueLabel.easy.layout(CenterX(), Top(58).to(notchBorder))
        selectedUnitLabel.easy.layout(Left(10).to(selectedValueLabel, .rightMargin), Top(100).to(notchBorder))
        selectedDateLabel.easy.layout(CenterX(), Top(129).to(notchBorder))
        
        caloriesButton.easy.layout(CenterX(), Bottom(181))
        weightButton.easy.layout(CenterX(), Bottom(34).to(caloriesButton, .topMargin))
        caloriesButton.changeBackgroundColor(toColor: UIColor.white.withAlphaComponent(0.5))

        container.addSubview(progressView)
        progressView.easy.layout(CenterX(), Top(10).to(selectedDateLabel))
    }
    
    private func setupButtons() {
        weightButton.addGesture(target: self, selector: #selector(weightButtonTapped(_:)))
        caloriesButton.addGesture(target: self, selector: #selector(caloriesButtonTapped(_:)))
    }
    
// MARK: Routing
    @objc func weightButtonTapped(_ sender: UITapGestureRecognizer? = nil) {
        progressManager.changedUnit(toUnit: .weight)
        selectedUnitLabel.text = "kg"
        weightButton.changeBackgroundColor(toColor: .white)
        caloriesButton.changeBackgroundColor(toColor: UIColor.white.withAlphaComponent(0.5))
    }
    
    @objc func caloriesButtonTapped(_ sender: UITapGestureRecognizer? = nil) {
        progressManager.changedUnit(toUnit: .calories)
        selectedUnitLabel.text = "kcal"
        weightButton.changeBackgroundColor(toColor: UIColor.white.withAlphaComponent(0.5))
        caloriesButton.changeBackgroundColor(toColor: .white)
    }
    
    @objc override func backButtonTapped(_ sender: UITapGestureRecognizer? = nil) {
        router.route(to: Route.back.rawValue, from: self)
    }
}
