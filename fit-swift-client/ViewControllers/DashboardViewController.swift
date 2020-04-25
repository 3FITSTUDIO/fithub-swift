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
        case weights
        case kcal
        case progress
    }
    
    private var refreshControl = UIRefreshControl()
    
    private let router = DashboardRouter()
    private let viewModel = DashboardViewModel()
    
    private let weightTile = BasicTile(size: .small)
    private let kcalTile = BasicTile(size: .small)
    private let seeProgressTile = BasicTile(size: .wide)
    private let plusButton = BasicTile(size: .roundButton)
    private let healthClockTile = HealthClockView()
    
    private let logoutButton: UIView = {
        let gestureView = UIView()
        let logoutButton = UIImageView()
        gestureView.addSubview(logoutButton)
        gestureView.easy.layout(Size(50))
        logoutButton.easy.layout(Size(40), Center())
        logoutButton.image = UIImage(named: "logout")?.withTintColor(.white)
        return gestureView
    }()
    
    private let refreshButton: UIView = {
        let gestureView = UIView()
        let refreshButton = UIImageView()
        gestureView.addSubview(refreshButton)
        gestureView.easy.layout(Size(50))
        refreshButton.easy.layout(Size(40), Center())
        refreshButton.image = UIImage(named: "refresh")?.withTintColor(.white)
        return gestureView
    }()
     
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        navigationController?.interactivePopGestureRecognizer?.isEnabled = false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.interactivePopGestureRecognizer?.isEnabled = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupButtons()
//        viewModel.postStepsData(steps: healthClockTile.stepsAmount)
    }
    
    override func setup(){
        super.setup()
        
        container.addSubviews(subviews: [healthClockTile, weightTile, kcalTile, seeProgressTile, plusButton])
        healthClockTile.easy.layout(CenterX(), Top(15).to(notchBorder, .bottom))
        
        weightTile.easy.layout(Left(19), Top(22).to(healthClockTile, .bottom))
        kcalTile.easy.layout(Right(19), Top(22).to(healthClockTile, .bottom))
        seeProgressTile.easy.layout(CenterX(), Top(22).to(kcalTile, .bottom))
        plusButton.easy.layout(CenterX(), Top(20).to(seeProgressTile, .bottom))
        
        weightTile.topLabel.text = "Weight"
        weightTile.bottomLabel.text = "kg"
        kcalTile.topLabel.text = "Calories"
        kcalTile.bottomLabel.text = "kcal"
        seeProgressTile.wideLabel.text = "See progress"
        
        weightTile.mainLabel.text = viewModel.provideLastWeightRecord()
        kcalTile.mainLabel.text = viewModel.provideLastCaloriesRecord()
        
        container.addSubviews(subviews: [logoutButton, refreshButton])
        logoutButton.easy.layout(Top(40), Left(20), Size(40))
        refreshButton.easy.layout(Top(40), Right(20), Size(40))
    }
    
    private func setupButtons() {
        weightTile.addGesture(target: self, selector: #selector(self.weightsTapped(_:)))
        kcalTile.addGesture(target: self, selector: #selector(self.kcalTapped(_:)))
        logoutButton.addGesture(target: self, selector: #selector(self.logoutTapped(_:)))
        refreshButton.addGesture(target: self, selector: #selector(self.refresh(_:)))
        seeProgressTile.addGesture(target: self, selector: #selector(self.seeProgressTapped(_:)))
        plusButton.addGesture(target: self, selector: #selector(self.addNewTapped(_:)))
    }
}

// MARK: Routing

extension DashboardViewController {
    
    @objc private func refresh(_ sender: AnyObject) {
        viewModel.updateData()
         let rotation: CABasicAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
           rotation.toValue = Double.pi * 2
           rotation.duration = 0.5
           rotation.isCumulative = true
           rotation.repeatCount = 2
           refreshButton.layer.add(rotation, forKey: "rotationAnimation")
    }
    
    @objc private func weightsTapped(_ sender: UITapGestureRecognizer? = nil) {
        generator.selectionChanged()
        router.route(to: Route.weights.rawValue, from: self)
    }
    
    @objc private func kcalTapped(_ sender: UITapGestureRecognizer? = nil) {
        generator.selectionChanged()
        router.route(to: Route.kcal.rawValue, from: self)
    }
    
    @objc private func logoutTapped(_ sender: UITapGestureRecognizer? = nil) {
        generator.selectionChanged()
        viewModel.clearProfileOnLogout()
        router.route(to: Route.logout.rawValue, from: self)
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc private func seeProgressTapped(_ sender: UITapGestureRecognizer? = nil) {
        generator.selectionChanged()
        router.route(to: Route.progress.rawValue, from: self)
    }
    
    @objc private func addNewTapped(_ sender: UITapGestureRecognizer? = nil) {
        generator.selectionChanged()
        let popup = AddNewPopUp()
        present(popup, animated: true, completion: nil)
        popup.didMove(toParent: popup)
    }
}

