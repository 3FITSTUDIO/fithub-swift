//
//  SettingsViewController.swift
//  fit-swift-client
//
//  Created by admin on 18/05/2020.
//  Copyright © 2020 Dominik Urbaez Gomez. All rights reserved.
//

import Foundation
import UIKit

class SettingsViewController: BasicComponentViewController {
    
    enum Route: String {
        case back
    }
    
    private let router = SettingsRouter()
    private var viewModel = ProfileViewModel()
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        
    convenience init(viewModel: ProfileViewModel) {
        self.init()
        self.viewModel = viewModel
    }
    
    override func viewDidLoad() {
        componentName = "Settings"
        super.viewDidLoad()
        addBottomNavigationBar()
    }
    
    // MARK: Navigation
    
    @objc func saveSettingsTapped(_ sender: UITapGestureRecognizer? = nil) {
        generator.selectionChanged()
        viewModel.saveSettings() {
            self.router.route(to: Route.back.rawValue, from: self)
        }
    }
    
    @objc override func backButtonTapped(_ sender: UITapGestureRecognizer? = nil) {
        generator.selectionChanged()
        router.route(to: Route.back.rawValue, from: self)
    }
}
