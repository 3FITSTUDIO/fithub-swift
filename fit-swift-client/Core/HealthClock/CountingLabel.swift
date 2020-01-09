//
//  CountingLabel.swift
//  TestCircle
//
//  Created by Quentin Cornu on 17/08/2018.
//  Copyright © 2018 Quentin. All rights reserved.
//

import UIKit

class CountingLabel: Label {
    
    let counterVelocity: CGFloat = 3.0
    
    enum CounterAnimationType {
        case linear
        case easeIn
        case easeOut
    }
    
    enum CounterType {
        case intType
        case CGFloatType
    }

    var startNumber: CGFloat = 0
    var endNumber: CGFloat = 0
    
    var progress: TimeInterval!
    var duration: TimeInterval!
    var lastUpdate: TimeInterval!

    var timer: Timer?
    
    var counterType: CounterType!
    var counterAnimationType: CounterAnimationType!
    
    var currentCounterValue: CGFloat {
        if progress >= duration {
            return endNumber
        }
        
        let percentage = CGFloat(progress / duration)
        let update = updateCounter(counterValue: percentage)
        
        return startNumber + (update * (endNumber - startNumber))
    }
    
    func count(from fromValue: CGFloat, to toValue: CGFloat, withDuration duration: TimeInterval, andAnimationType animationType: CounterAnimationType, andCounterType counterType: CounterType) {
        
        self.startNumber = fromValue
        self.endNumber = toValue
        self.duration = duration
        self.counterType = counterType
        self.counterAnimationType = animationType
        self.progress = 0
        self.lastUpdate = Date.timeIntervalSinceReferenceDate
        
        invalidateTimer()
        
        if duration == 0 {
            updateText(value: toValue)
            return
        }
        
        timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(CountingLabel.updateValue), userInfo: nil, repeats: true)
    }
    
    @objc func updateValue() {
        let now = Date.timeIntervalSinceReferenceDate
        progress = progress + (now - lastUpdate)
        lastUpdate = now
        
        if progress >= duration {
            invalidateTimer()
            progress = duration
        }
        
        updateText(value: currentCounterValue)
    }
    
    func updateText(value: CGFloat) {
        switch counterType! {
        case .intType:
            self.text = "\(Int(value))"
        case .CGFloatType:
            self.text = String(format: "%.2f", value)
        }
    }
    
    func updateCounter(counterValue: CGFloat) -> CGFloat {
        switch counterAnimationType! {
        case .linear:
            return counterValue
        case .easeIn:
            return pow(counterValue, counterVelocity)
        case .easeOut:
            return 1.0 - pow(1.0 - counterValue, counterVelocity)
        }
    }
    
    func invalidateTimer() {
        timer?.invalidate()
        timer = nil
    }
}
