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

class ChartViewController: BasicComponentViewController, ChartViewDelegate {    
    enum Route: String {
        case back
    }
    
    private let router = ChartRouter()
    private let chartManager = ChartViewManager()
    private var chartView = UIView()
    
    var avgValueLabel = Label(label: "", fontSize: 30)
    private let avgInfLabel = Label(label: "avg", fontSize: 20)
    var selectedValueLabel = Label(label: "", fontSize: 70)
    private let selectedUnitLabel = Label(label: "kg", fontSize: 27)
    var selectedDateLabel = Label(label: "16.01.2020", fontSize: 20)
    
    private let weightButton = Button(type: .big, label: "Weight Progress")
    private let caloriesButton = Button(type: .big, label: "Calories Progress")
    
    override func setup() {
        super.setup()
        chartView = chartManager.container
        layout()
        addBottomNavigationBar()
        setupButtons()
    }
    
    override func viewDidLoad() {
        componentName = "Diagram"
        super.viewDidLoad()
        chartManager.delegate = self
        selectedValueLabel.text = String(chartManager.weightArray[0].value)
        avgValueLabel.text = String(chartManager.calculateAverage())
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
        
        container.addSubview(chartView)
        chartView.easy.layout(CenterX(), Top(10).to(selectedDateLabel))
    }
    
    private func setupButtons() {
        weightButton.addGesture(target: self, selector: #selector(weightButtonTapped(_:)))
        caloriesButton.addGesture(target: self, selector: #selector(caloriesButtonTapped(_:)))
    }
    
    // MARK: Routing
    @objc func weightButtonTapped(_ sender: UITapGestureRecognizer? = nil) {
        generator.selectionChanged()
        chartManager.changedUnit(toUnit: .weight)
        selectedUnitLabel.text = "kg"
        weightButton.changeBackgroundColor(toColor: .white)
        caloriesButton.changeBackgroundColor(toColor: UIColor.white.withAlphaComponent(0.5))
    }
    
    @objc func caloriesButtonTapped(_ sender: UITapGestureRecognizer? = nil) {
        generator.selectionChanged()
        chartManager.changedUnit(toUnit: .calories)
        selectedUnitLabel.text = "kcal"
        weightButton.changeBackgroundColor(toColor: UIColor.white.withAlphaComponent(0.5))
        caloriesButton.changeBackgroundColor(toColor: .white)
    }
    
    @objc override func backButtonTapped(_ sender: UITapGestureRecognizer? = nil) {
        generator.selectionChanged()
        router.route(to: Route.back.rawValue, from: self)
    }
}
