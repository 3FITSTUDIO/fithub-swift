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

protocol ProgressViewDelegate {
    var avgValueLabel: Label { get set }
    var selectedValueLabel: Label { get set }
    var selectedDateLabel: Label { get set }
}

class ProgressViewManager {
    var delegate: ProgressViewDelegate?
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
    
    var unit: Unit = .weight
    
    var xRange = 31
    var maxVal = 0
    var values = [Int]()
    var bars = [UIView]()
    var barsSelected = [Bool]()

    init() {
        maxVal = unit == .weight ? 200 : 8000
        layout()
        stubWeightArray()
        stubRecordArray()
        feedInitialData()
        setupStackViewSwipeGesture()
    }
    
    var weightArray = [Record]()
    private func stubWeightArray() {
        for i in 0...31 {
            let randWeight = Int.random(in: 95...99)
            weightArray.append(Record(id: i, value: [randWeight], type: .weight))
        }
    }
    
    var recordArray = [Record]()
    private func stubRecordArray() {
        for i in 0...31 {
            let randWeight = Int.random(in: 2300...3000)
            recordArray.append(Record(id: i, value: [randWeight], type: .weight))
        }
    }
    
    private func layout() {
        container.addSubviews(subviews: [barStackView, daySelector])
        barStackView.axis = .horizontal
        barStackView.alignment = .bottom
        barStackView.distribution = .equalSpacing
        barStackView.spacing = 5
        barStackView.easy.layout(Bottom(4), CenterX())
        daySelector.easy.layout(CenterX(), Bottom(4))
    }
    
    private func setupStackViewSwipeGesture() {
        daySelector.isUserInteractionEnabled = true
        let gesture = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture(_:)))
        daySelector.addGestureRecognizer(gesture)
    }
    
    var initialCenter = CGPoint()
    @objc private func handlePanGesture(_ gestureRecognizer : UIPanGestureRecognizer) {
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
            if newX >= 6.0 && newX <= 339.0 {
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
        let left = selectorX - 6
        let predictedBarId = Int((left / 11).rounded() + 0.5)
        if predictedBarId != previousPredictedId {
            previousPredictedId = predictedBarId
            bars[predictedBarId].backgroundColor = .white
            let generator = UISelectionFeedbackGenerator()
            generator.selectionChanged()
            for i in 0...xRange-1 {
                if i != predictedBarId {
                    bars[i].backgroundColor = UIColor.white.withAlphaComponent(0.5)
                }
            }
            delegate?.selectedValueLabel.text = unit == .weight ? String(weightArray[predictedBarId].value[0]) : String(recordArray[predictedBarId].value[0])
        }
    }
    
    private func feedInitialData() {
        for i in 1...xRange {
            let data = unit == .weight ? weightArray[i-1].value[0] : recordArray[i-1].value[0]
            self.values.append(data/maxVal * 200)
            barsSelected.append(false)
            bars.append(newBar(forValue: data))
        }
        bars.forEach { barStackView.addArrangedSubview($0) }
    }
    
    private func feedNewData() {
        for i in 1...xRange {
            let data = unit == .weight ? weightArray[i-1].value[0] : recordArray[i-1].value[0]
            self.values[i-1] = Int(data)
            UIView.animate(withDuration: 0.2, animations: { () -> Void in
                self.bars[i-1].easy.layout(Height(CGFloat((Double(data)/Double(self.maxVal)) * 200)))
                self.container.layoutIfNeeded()
            })
        }
    }
    
    func changedUnit(toUnit unit: Unit) {
        self.unit = unit
        switch unit {
        case .weight:
            maxVal = 200
        case .calories:
            maxVal = 3000
        }
        feedNewData()
        
        let avg = values.reduce(0, +) / values.count
        delegate?.avgValueLabel.text = String(avg)
        getCurrentSelection(selectorX: daySelector.center.x)
    }

    private func newBar(forValue value: Int) -> UIView {
        let view = UIView()
        view.easy.layout(Height(CGFloat(value)), Width(6))
        view.layer.cornerRadius = 3
        view.backgroundColor = UIColor.white.withAlphaComponent(0.5)
        return view
    }
}
