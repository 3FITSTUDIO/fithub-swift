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
        case logout
        case progress
        case addNew
    }
    
    private let router = DashboardRouter()
    private let viewModel = DashboardViewModel()
    
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

    // Buttons - other
    private let seeProgressButton = Button(type: .wide, label: "See Progress")
    private let plusButton = BasicTile(size: .roundButton)
    private let stepsProgressView = StepsProgressBarView()
    
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
        configureTileButtons()
        viewModel.vc = self
        viewModel.updateData()
    }
    
    // MARK: Setup
    override func setup(){
        super.setup()
        
        dataDetailsView.dataSource = self
        dataDetailsView.delegate = self
        
        container.addSubviews(subviews: [stepsProgressView, seeProgressButton, plusButton, logoutButton, refreshButton, dataDetailsView])
        stepsProgressView.easy.layout(CenterX(), Top(15).to(notchBorder, .bottom))
        dataDetailsView.easy.layout(Left(19), Right(19), Top(22).to(stepsProgressView, .bottom), Height(152))
        seeProgressButton.easy.layout(CenterX(), Top(22).to(dataDetailsView, .bottom))
        plusButton.easy.layout(CenterX(), Top(20).to(seeProgressButton, .bottom))
        logoutButton.easy.layout(Top(40), Left(20), Size(40))
        refreshButton.easy.layout(Top(40), Right(20), Size(40))
        dataDetailsView.backgroundColor = .clear
    }
    
    private func setupButtons() {
        // Data Buttons
        [weightDataButton,
         kcalDataButton,
         trainingsDataButton,
         sleepDataButton,
         pulseDataButton,
         measurementsDataButton,
         stepsDataButton].forEach {
            $0.addGesture(target: self, selector: #selector(self.detailDataButtonTapped(_:)))
        }
    
        // Navigation
        /// TODO: Fix array indexing in StepsProgressManager.swift
//        seeProgressButton.addGesture(target: self, selector: #selector(self.seeProgressTapped(_:)))
        plusButton.addGesture(target: self, selector: #selector(self.addNewTapped(_:)))

        logoutButton.addGesture(target: self, selector: #selector(self.logoutTapped(_:)))
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
            
        detailDataViews = [weightDataButton, kcalDataButton, trainingsDataButton, sleepDataButton, pulseDataButton, stepsDataButton, measurementsDataButton]
        for i in 0...6 {
            detailDataViews[i].tag = i
        }
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
        default:
            return
        }
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
        router.route(to: Route.addNew.rawValue, from: self)
    }
}

