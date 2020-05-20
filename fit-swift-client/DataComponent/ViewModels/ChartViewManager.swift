//
//  ProgressViewManager.swift
//  fit-swift-client
//
//  Created by admin on 18/01/2020.
//  Copyright © 2020 Dominik Urbaez Gomez. All rights reserved.
//

import Foundation
import UIKit
import EasyPeasy
import AudioToolbox

protocol ChartViewDelegate {
    var avgValueLabel: Label { get set }
    var selectedValueLabel: Label { get set }
    var selectedDateLabel: Label { get set }
}

class ChartViewManager {
    private var store: DataStore?
    var delegate: ChartViewDelegate?
    enum Unit {
        case weight
        case calories
    }
    
    let container: UIView = {
        let view = UIView()
        view.easy.layout(Height(222), Width(346))
        return view
    }()
    
    let barStackView = UIStackView()

    private let daySelector: UIView = {
        let gestureView = UIView()
        let view = UIView()
        gestureView.addSubview(view)
        gestureView.easy.layout(Height(200), Width(90))
        view.easy.layout(Height(200), Width(2), CenterX())
        view.backgroundColor = .orange
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        view.layer.cornerRadius = 3
        return gestureView
    }()
    
    private let swipeMeLabel: Label = {
        let label = Label(label: "swipe me! ->", fontSize: 10)
        return label
    }()
    
    var unit: Unit = .weight
    
    var xRange = 31
    var maxVal = 0
    var heightMultiplier = 200
    var values = [Float]()
    var bars = [UIView]()
    var barsSelected = [Bool]()

    var weightArray = [Record]()
    var calorieArray = [Record]()
    init() {
        store = mainStore.dataStore
        maxVal = unit == .weight ? 200 : 8000
        layout()
        if let store = store {
            weightArray = store.weightData
            calorieArray = store.caloriesData
            if store.weightData.count >= 31 {
                weightArray = Array(store.weightData[0..<31])
            }
            if store.caloriesData.count >= 31 {
                calorieArray = Array(store.caloriesData[0..<31])
            }
        }
        xRange = weightArray.count
        feedInitialData()
        setupStackViewSwipeGesture()
    }
    
    // MARK: UI
    private func layout() {
        container.addSubviews(subviews: [barStackView, daySelector, swipeMeLabel])
        barStackView.axis = .horizontal
        barStackView.alignment = .bottom
        barStackView.distribution = .equalSpacing
        barStackView.spacing = 5
        barStackView.easy.layout(Bottom(4), CenterX())
        daySelector.easy.layout(CenterX(), Bottom(4))
        swipeMeLabel.easy.layout(Top(80), Left(100))
    }
    
    private func setupStackViewSwipeGesture() {
        daySelector.isUserInteractionEnabled = true
        let gesture = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture(_:)))
        daySelector.addGestureRecognizer(gesture)
    }
    
    // MARK: Gestures
    var initialCenter = CGPoint()
    @objc private func handlePanGesture(_ gestureRecognizer : UIPanGestureRecognizer) {
        swipeMeLabel.removeFromSuperview()
        guard gestureRecognizer.view != nil else {return}
        let piece = gestureRecognizer.view!
        // Get the changes in the X and Y directions relative to
        // the superview's coordinate space.
        let translation = gestureRecognizer.translation(in: piece.superview)
        if gestureRecognizer.state == .began {
            // Save the view's original position.
            self.initialCenter = piece.center
        }
        // Update the position for the .began, .changed, and .ended states
        if gestureRecognizer.state != .cancelled {
            // Add the X and Y translation to the view's original position.
            
            let newX = initialCenter.x + translation.x
            if newX >= 172 - barStackView.frame.width/2 && newX <= 173 + barStackView.frame.width/2 {
                let newCenter = CGPoint(x: newX, y: initialCenter.y)
                piece.center = newCenter
                getCurrentSelection(selectorX: newX)
            }
        }
        else {
            // On cancellation, return the piece to its original location.
            piece.center = initialCenter
        }
    }
    
    var previousPredictedId = 0
    private func getCurrentSelection(selectorX: CGFloat) {
        let leftMargin = 172 - barStackView.frame.size.width / 2
        let predictedBarId = Int((selectorX - leftMargin)/11)
//        debugPrint("Predicted barID: \(predictedBarId)\n, selectorX: \(selectorX)")
        if predictedBarId != previousPredictedId {
            previousPredictedId = predictedBarId
            bars[predictedBarId].backgroundColor = .white
            generator.selectionChanged()
            for i in 0...xRange-1 {
                if i != predictedBarId {
                    bars[i].backgroundColor = UIColor.white.withAlphaComponent(0.5)
                }
            }
            delegate?.selectedValueLabel.text = unit == .weight ? String(weightArray[predictedBarId].value) : String(calorieArray[predictedBarId].value)
            delegate?.selectedDateLabel.text = unit == .weight ? weightArray[predictedBarId].date : calorieArray[predictedBarId].date
        }
    }
    
    // MARK: Data Feeding
    private func feedInitialData() {
        values = [Float]()
        bars = [UIView]()
        barStackView.subviews.forEach { $0.removeFromSuperview() }
        barStackView.arrangedSubviews.forEach { barStackView.removeArrangedSubview($0) }
        for _ in 1...xRange {
            bars.append(newBar(forValue: 1))
        }
        self.bars.forEach { self.barStackView.addArrangedSubview($0) }

        UIView.animate(withDuration: 0.2, animations: { () -> Void in
            for i in 1...self.xRange {
                let data = self.unit == .weight ? self.weightArray[i-1].value : self.calorieArray[i-1].value
                self.values.append(data)
                self.barsSelected.append(false)
                self.bars[i-1].easy.layout(Height(CGFloat(Float(data)/Float(self.maxVal) * Float(self.heightMultiplier))))
            }
            self.container.layoutIfNeeded()
        })
        delegate?.avgValueLabel.text = String(calculateAverage())
    }
    
    func changedUnit(toUnit unit: Unit) {
        self.unit = unit
        switch unit {
        case .weight:
            maxVal = 200
            heightMultiplier = 200
            xRange = weightArray.count
        case .calories:
            maxVal = 3000
            heightMultiplier = 120
            xRange = calorieArray.count
        }
        feedInitialData()
    
        delegate?.avgValueLabel.text = String(calculateAverage())
        delegate?.selectedValueLabel.text = unit == .weight ? String(weightArray[0].value) : String(calorieArray[0].value)
        getCurrentSelection(selectorX: daySelector.center.x)
    }

    private func newBar(forValue value: Int) -> UIView {
        let view = UIView()
        view.easy.layout(Height(CGFloat(value)), Width(6))
        view.layer.cornerRadius = 3
        view.backgroundColor = UIColor.white.withAlphaComponent(0.5)
        return view
    }
    
    func calculateAverage() -> Float {
        return Float(values.reduce(0, +)) / Float(values.count)
    }
}
