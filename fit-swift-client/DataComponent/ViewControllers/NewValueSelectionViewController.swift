//
//  NewValueSelectionViewController.swift
//  fit-swift-client
//
//  Created by admin on 08/05/2020.
//  Copyright © 2020 Dominik Urbaez Gomez. All rights reserved.
//

import UIKit
import EasyPeasy

class NewValueSelectionViewController: BasicComponentViewController {
    enum Route: String {
        case selected
        case back
    }
    
    private let router = NewValueSelectionRouter()

    override func viewDidLoad() {
        componentName = "Select Type"
        super.viewDidLoad()
        addBottomNavigationBar()
        layout()
        setupButtonInteractions()
    }
    
    private let weightButton = Button(type: .nav, label: "Weight")
    private let caloriesButton = Button(type: .nav, label: "Calories")
    private let trainingButton = Button(type: .nav, label: "Training")
    private let sleepButton = Button(type: .nav, label: "Sleep")
    private let pulseButton = Button(type: .nav, label: "Pulse")
    private let stepsButton = Button(type: .nav, label: "Steps")
    private let measurementsButton = Button(type: .wide, label: "Measurements")
    
    private func layout() {
        let middleContainer = UIView()
        container.addSubview(middleContainer)
        middleContainer.easy.layout(Center(), Width(337), Height(314))
        middleContainer.addSubviews(subviews: [weightButton, caloriesButton, trainingButton, sleepButton, pulseButton, stepsButton, measurementsButton])
        weightButton.easy.layout(Left(), Top())
        caloriesButton.easy.layout(Right(), Top())
        trainingButton.easy.layout(Left(), Top(10).to(weightButton))
        sleepButton.easy.layout(Right(), Top(10).to(caloriesButton))
        pulseButton.easy.layout(Left(), Top(10).to(trainingButton))
        stepsButton.easy.layout(Right(), Top(10).to(sleepButton))
        measurementsButton.easy.layout(Center(), Top(10).to(pulseButton))
        
        let titleLabel = Label(label: "Choose value type:", fontSize: 30)
        container.addSubview(titleLabel)
        titleLabel.easy.layout(CenterX(), Top(170))
    }
    
    private func setupButtonInteractions() {
        let buttons = [weightButton, caloriesButton, trainingButton, sleepButton, pulseButton, stepsButton, measurementsButton]
        for index in buttons.indices {
            buttons[index].tag = index
        }
        buttons.forEach { $0.addGesture(target: self, selector: #selector(handleNewValuePath(_:))) }
    }

    // MARK: - Navigation

    @objc private func handleNewValuePath(_ sender: UITapGestureRecognizer? = nil) {
        generator.selectionChanged()
        var selectedType: DataProvider.DataType
        switch sender!.view!.tag {
        case 0:
            selectedType = .weights
        case 1:
            selectedType = .kcal
        case 2:
            selectedType = .training
        case 3:
            selectedType = .sleep
        case 4:
            selectedType = .pulse
        case 5:
            selectedType = .steps
        case 6:
            selectedType = .measurements
        default:
            return
        }
        router.route(to: Route.selected.rawValue, from: self, parameters: selectedType)
    }
    
    @objc override func backButtonTapped(_ sender: UITapGestureRecognizer? = nil) {
        generator.selectionChanged()
        router.route(to: Route.back.rawValue, from: self)
    }
}
