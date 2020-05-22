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
        case weights, kcal, training, sleep, pulse, steps, measurements
        case profile
        case progress
        case addNew
        case notifications
    }
    
    private let router = DashboardRouter()
    private let viewModel = DashboardViewModel(dataStore: mainStore.dataStore, userStore: mainStore.userStore)
    
    // Collection View
    private let reuseIdentifier = "detailsDataButton"
    var detailDataViews = [UIView]()
    private let dataDetailsView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.register(DetailDataItem.self, forCellWithReuseIdentifier: "detailsDataButton")
        return cv
    }()
    
    // Buttons - collection view
    let weightDataButton = BasicTile(size: .small)
    let kcalDataButton = BasicTile(size: .small)
    let sleepDataButton = BasicTile(size: .small)
    let pulseDataButton = BasicTile(size: .small)
    let trainingsDataButton = BasicTile(size: .small)
    let measurementsDataButton = BasicTile(size: .small)
    let stepsDataButton = BasicTile(size: .small)
    let notificationsButton = BasicTile(size: .small)
    
    // Buttons - other
    private let seeDiagramsButton = Button(type: .wide, label: "See Diagrams")
    private let plusButton = BasicTile(size: .roundButton)
    private let stepsProgressView = StepsProgressBarView()
    
    private let profileButton: UIView = {
        let gestureView = UIView()
        let logoutButton = UIImageView()
        gestureView.addSubview(logoutButton)
        gestureView.easy.layout(Size(50))
        logoutButton.easy.layout(Size(40), Center())
        logoutButton.image = UIImage(named: "profile")?.withTintColor(.white)
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
        configureTileButtons()
        viewModel.vc = self
        viewModel.updateData(force: false)
    }
    
    // MARK: Setup
    override func setup(){
        super.setup()
        
        dataDetailsView.dataSource = self
        dataDetailsView.delegate = self
        
        container.addSubviews(subviews: [stepsProgressView, seeDiagramsButton, plusButton, profileButton, refreshButton, dataDetailsView])
        stepsProgressView.easy.layout(CenterX(), Top(15).to(notchBorder, .bottom))
        dataDetailsView.easy.layout(Left(19), Right(19), Top(22).to(stepsProgressView, .bottom), Height(152))
        seeDiagramsButton.easy.layout(CenterX(), Top(22).to(dataDetailsView, .bottom))
        plusButton.easy.layout(CenterX(), Top(20).to(seeDiagramsButton, .bottom))
        profileButton.easy.layout(Top(40), Left(20), Size(40))
        refreshButton.easy.layout(Top(40), Right(20), Size(40))
        dataDetailsView.backgroundColor = .clear
    }
    
    private func setupButtons() {
        if let bodyImage = UIImage(named: "body") {
            measurementsDataButton.setImage(image: bodyImage)
        }
        if let notifImage = UIImage(named: "notification-bell") {
            notificationsButton.setImage(image: notifImage)
        }
        
        // Data Buttons
        [weightDataButton,
         kcalDataButton,
         trainingsDataButton,
         sleepDataButton,
         pulseDataButton,
         measurementsDataButton,
         stepsDataButton,
         notificationsButton].forEach {
            $0.addGesture(target: self, selector: #selector(self.detailDataButtonTapped(_:)))
        }
        
        // Navigation
        seeDiagramsButton.addGesture(target: self, selector: #selector(self.seeDiagramsTapped(_:)))
        plusButton.addGesture(target: self, selector: #selector(self.addNewTapped(_:)))
        
        profileButton.addGesture(target: self, selector: #selector(self.profileTapped(_:)))
        refreshButton.addGesture(target: self, selector: #selector(self.refresh(_:)))
    }
    
    private func configureTileButtons() {
        weightDataButton.topLabel.text = "Weight"
        weightDataButton.bottomLabel.text = "kg"
        kcalDataButton.topLabel.text = "Calories"
        kcalDataButton.bottomLabel.text = "kcal"
        trainingsDataButton.topLabel.text = "Training"
        trainingsDataButton.bottomLabel.text = "kcal burned"
        sleepDataButton.topLabel.text = "Sleep"
        sleepDataButton.bottomLabel.text = "hours"
        pulseDataButton.topLabel.text = "Pulse"
        pulseDataButton.bottomLabel.text = "avg. BPM"
        measurementsDataButton.topLabel.text = "Body"
        measurementsDataButton.bottomLabel.text = "measurements"
        stepsDataButton.topLabel.text = "Steps"
        stepsDataButton.bottomLabel.text = "avg. per day"
        notificationsButton.topLabel.text = "See"
        notificationsButton.bottomLabel.text = "notifications"
        
        detailDataViews = [weightDataButton, kcalDataButton, trainingsDataButton, sleepDataButton, pulseDataButton, stepsDataButton, measurementsDataButton, notificationsButton]
        for i in 0...7 {
            detailDataViews[i].tag = i
        }
    }
    
    func rotateRefreshButton() {
        let rotation: CABasicAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
        rotation.toValue = Double.pi * 2
        rotation.duration = 0.5
        rotation.isCumulative = true
        rotation.repeatCount = 2
        refreshButton.layer.add(rotation, forKey: "rotationAnimation")
    }
}

extension DashboardViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 159, height: 152)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return detailDataViews.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! DetailDataItem
        cell.configure(view: detailDataViews[indexPath.row])
        return cell
    }
}

// MARK: Alert Display
extension DashboardViewController {
    enum AlertType {
        case noDiagramData
        
    }
    public func displayAlert(type: AlertType) {
        switch type {
        case .noDiagramData:
            let alertController = UIAlertController(title: "Oh no!", message: "No data to display, try updating first.", preferredStyle: .alert)
            let action1 = UIAlertAction(title: "Close", style: .default) { (action:UIAlertAction) in }
            alertController.addAction(action1)
            self.present(alertController, animated: true, completion: nil)
            return
        }
    }
}

// MARK: Routing

extension DashboardViewController {
    
    @objc private func refresh(_ sender: AnyObject) {
        viewModel.updateData(force: true)
    }
    
    @objc private func detailDataButtonTapped(_ sender: UITapGestureRecognizer? = nil) {
        generator.selectionChanged()
        switch sender!.view!.tag {
        case 0:
            router.route(to: Route.weights.rawValue, from: self)
        case 1:
            router.route(to: Route.kcal.rawValue, from: self)
        case 2:
            router.route(to: Route.training.rawValue, from: self)
        case 3:
            router.route(to: Route.sleep.rawValue, from: self)
        case 4:
            router.route(to: Route.pulse.rawValue, from: self)
        case 5:
            router.route(to: Route.steps.rawValue, from: self)
        case 6:
            router.route(to: Route.measurements.rawValue, from: self)
        case 7:
            router.route(to: Route.notifications.rawValue, from: self)
        default:
            return
        }
    }
    
    @objc private func profileTapped(_ sender: UITapGestureRecognizer? = nil) {
        generator.selectionChanged()
        router.route(to: Route.profile.rawValue, from: self)
    }
    
    @objc private func seeDiagramsTapped(_ sender: UITapGestureRecognizer? = nil) {
        generator.selectionChanged()
        if viewModel.diagramsCanBeShown() {
            router.route(to: Route.progress.rawValue, from: self)
        }
        else {
            displayAlert(type: .noDiagramData)
        }
    }
    
    @objc private func addNewTapped(_ sender: UITapGestureRecognizer? = nil) {
        generator.selectionChanged()
        router.route(to: Route.addNew.rawValue, from: self)
    }
}

