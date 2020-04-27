//
//  StepsProgressBarView.swift
//  fit-swift-client
//
//  Created by admin on 30/12/2019.
//  Copyright © 2019 Dominik Urbaez Gomez. All rights reserved.
//

import Foundation
import UIKit
import EasyPeasy

class StepsProgressBarView : UIView {
    
    private let shapeLayer = CAShapeLayer()
    private let backgroundLayer = CAShapeLayer()
    private let container = UIView()
    private let backgroundTile = BasicTile(size: .big)
    
    public var manager: StepsProgressBarManager
    public var stepsAmount: Int = 0
    
    let stepsCountLabel: CountingLabel = {
        let label = CountingLabel(label: "0", fontSize: 40)
        label.textColor = UIColor.black
        label.textAlignment = .center
        return label
    }()
    
    override init(frame: CGRect) {
        manager = StepsProgressBarManager()
        super.init(frame: frame)
        self.setupBackground()
        setupClock()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc public func setupClock() {
        manager.provideStepsCount { steps in
            self.stepsAmount = steps
            DispatchQueue.main.async {
                self.setupProgressBar(stepsAmount: self.stepsAmount)
                self.setupLabels()
                self.animate()
            }
        }
    }
    
    private func setupBackground() {
        self.addSubview(backgroundTile)
        self.easy.layout(Width(337), Height(323))
        backgroundTile.easy.layout(Center())
        
        let center = CGPoint(x: 337/2, y: 323/2)
        
        let backgroundCircle = UIBezierPath(arcCenter: center, radius: 130, startAngle: -0.5 * .pi, endAngle: 1.5 * CGFloat.pi, clockwise: true)
        backgroundLayer.path = backgroundCircle.cgPath
        backgroundLayer.strokeColor = FithubUI.Colors.lightGray.cgColor
        backgroundLayer.fillColor = UIColor.clear.cgColor
        backgroundLayer.lineWidth = 10
        backgroundLayer.strokeEnd = 1
        backgroundTile.layer.addSublayer(backgroundLayer)
    }
    
    private func setupProgressBar(stepsAmount: Int){
        let progressView = UIView()
        progressView.easy.layout(Edges())
        let center = CGPoint(x: 337/2, y: 323/2)
        
        let endAngle = (CGFloat(stepsAmount) / 8000) * (2 * CGFloat.pi) - (0.5 * CGFloat.pi)
        let progressBar = UIBezierPath(arcCenter: center, radius: 130, startAngle: -0.5 * .pi, endAngle: endAngle, clockwise: true)
        shapeLayer.path = progressBar.cgPath
        shapeLayer.strokeColor = FithubUI.Colors.neonGreen.cgColor
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.lineWidth = 10
        shapeLayer.strokeEnd = 0
        shapeLayer.lineCap = CAShapeLayerLineCap.round
        
        backgroundTile.layer.addSublayer(shapeLayer)
        backgroundTile.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(setupClock)))
    }
    
    private func setupLabels() {
        let stepsLabel: Label = {
            let label = Label(label: "steps", fontSize: 39)
            label.textColor = FithubUI.Colors.classicWhite
            return label
        }()
        
        backgroundTile.addSubviews(subviews: [stepsCountLabel, stepsLabel])
        stepsCountLabel.easy.layout(CenterX(), Top(116))
        stepsLabel.easy.layout(CenterX(), Bottom(114))
    }
    
    private func animate(){
        let basicAnimation = CABasicAnimation(keyPath: "strokeEnd")
        
        basicAnimation.toValue = 1
        let duration = 4 * Double(stepsAmount)/8000
        basicAnimation.duration = duration
        basicAnimation.fillMode = CAMediaTimingFillMode.forwards
        basicAnimation.isRemovedOnCompletion = false
        shapeLayer.add(basicAnimation, forKey: "basicAnimation")
        
        stepsCountLabel.count(from: 0, to: CGFloat(stepsAmount), withDuration: duration, andAnimationType: .easeIn, andCounterType: .intType)
    }
}
