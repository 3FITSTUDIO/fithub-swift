//
//  HealthClockView.swift
//  fit-swift-client
//
//  Created by admin on 30/12/2019.
//  Copyright © 2019 Dominik Urbaez Gomez. All rights reserved.
//

import Foundation
import UIKit
import EasyPeasy

class HealthClockView : UIView {
    
//    var coordinator: HealthClockCoordinator
    let shapeLayer = CAShapeLayer()
    let backgroundLayer = CAShapeLayer()
    let container = UIView()
    let backgroundTile = BasicTile(size: .big)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupBackground()
        setupProgressBar()
        setupLabels()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupBackground() {
        self.addSubview(backgroundTile)
        self.easy.layout(Width(337), Height(323))
        backgroundTile.easy.layout(Center())
        
        let center = CGPoint(x: 337/2, y: 323/2)

        let backgroundCircle = UIBezierPath(arcCenter: center, radius: 130, startAngle: -0.5 * .pi, endAngle: 1.5 * CGFloat.pi, clockwise: true)
        backgroundLayer.path = backgroundCircle.cgPath
        backgroundLayer.strokeColor = UIColor.gray.cgColor
        backgroundLayer.fillColor = UIColor.white.cgColor
        backgroundLayer.lineWidth = 30
        backgroundLayer.strokeEnd = 0
    }
    
    private func setupProgressBar(){
        let progressView = UIView()
        
        let center = CGPoint(x: 337/2, y: 323/2)
        
        progressView.easy.layout(Edges())
        let progressBar = UIBezierPath(arcCenter: center, radius: 130, startAngle: -0.5 * .pi, endAngle: 1.5 * CGFloat.pi, clockwise: true)
        shapeLayer.path = progressBar.cgPath
        shapeLayer.strokeColor = FithubUI.Colors.neonGreen.cgColor
        shapeLayer.fillColor = UIColor.white.cgColor
        shapeLayer.lineWidth = 30
        shapeLayer.strokeEnd = 0
        
        backgroundTile.layer.addSublayer(backgroundLayer)
        backgroundTile.layer.addSublayer(shapeLayer)
            
        backgroundTile.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleUpdateTap)))
    }
    
    func setupLabels() {
        let stepsCountLabel: Label = {
            let label = Label(label: "8000", fontSize: 40)
            label.textColor = .black
            return label
        }()
            
        let stepsLabel: Label = {
            let label = Label(label: "steps", fontSize: 39)
            label.textColor = FithubUI.Colors.lightishGreen
            return label
        }()
        
        backgroundTile.addSubviews(subviews: [stepsCountLabel, stepsLabel])
        stepsCountLabel.easy.layout(CenterX(), Top(116))
        stepsLabel.easy.layout(CenterX(), Bottom(114))
    }
    
    @objc private func handleUpdateTap(){
        let basicAnimation = CABasicAnimation(keyPath: "strokeEnd")
        
        basicAnimation.toValue = 1
        basicAnimation.duration = 2
        basicAnimation.fillMode = CAMediaTimingFillMode.forwards
        basicAnimation.isRemovedOnCompletion = false
        shapeLayer.add(basicAnimation, forKey: "basicAnimation")
    }
}
