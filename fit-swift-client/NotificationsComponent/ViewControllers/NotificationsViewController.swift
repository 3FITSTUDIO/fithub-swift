//
//  NotificationsViewController.swift
//  fit-swift-client
//
//  Created by admin on 18/05/2020.
//  Copyright © 2020 Dominik Urbaez Gomez. All rights reserved.
//

import Foundation
import UIKit
import EasyPeasy

class NotificationsViewController: BasicComponentViewController, UITableViewDelegate, UITableViewDataSource {
    enum Route: String {
        case back
    }
    
    enum PresentingVCType {
        case dashboard, profile
    }
    
    private let router = NotificationsRouter()
    private let manager = mainStore.dataStore.notificationsManager
    
    private var presentingVC: PresentingVCType = .profile
    
    let tableView = UITableView()
    let cellReuseIdentifier = "reusableNotificationCellIdentifier"
    
    private let refreshButton: UIView = {
        let gestureView = UIView()
        let refreshButton = UIImageView()
        gestureView.addSubview(refreshButton)
        gestureView.easy.layout(Size(50))
        refreshButton.easy.layout(Size(40), Center())
        refreshButton.image = UIImage(named: "refresh")?.withTintColor(.white)
        return gestureView
    }()
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(from vc: PresentingVCType) {
        self.init()
        self.presentingVC = vc
    }
    
    override func viewDidLoad() {
        componentName = "Notifications"
        super.viewDidLoad()
        addBottomNavigationBar()
        setupTableView()
        setupRefreshButton()
    }
    
    private func setupTableView() {
        container.addSubview(tableView)
        tableView.easy.layout(Center(), Top(100), Bottom(100), Left(19), Right(19))
        tableView.backgroundColor = .clear
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(NotificationTableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
        tableView.separatorStyle = .none
        tableView.allowsSelection = true
        tableView.allowsMultipleSelection = true
    }
    
    private func setupRefreshButton() {
        container.addSubview(refreshButton)
        refreshButton.easy.layout(Top(40), Right(20), Size(40))
        refreshButton.addGesture(target: self, selector: #selector(self.refresh(_:)))
    }
    
    // MARK: UITableViewDelegate, UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return manager.notificationData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier, for: indexPath) as? NotificationTableViewCell else {
            fatalError("The dequeued cell is not an instance of NotificationTableViewCell.")
        }
        let data = manager.dataForNotification(forIndex: indexPath.row)
        cell.configure(withData: data)
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let closeAction = UIContextualAction(style: .normal, title:  "Mark as Read", handler: { (ac:UIContextualAction, view:UIView, success:(Bool) -> Void) in
            generator.selectionChanged()
            self.manager.markAsRead(atIndex: indexPath.row) {
                tableView.reloadData()
            }
            success(true)
        })
        closeAction.backgroundColor = FithubUI.Colors.weirdGreen
        return UISwipeActionsConfiguration(actions: [closeAction])
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let closeAction = UIContextualAction(style: .normal, title:  "Delete", handler: { (ac:UIContextualAction, view:UIView, success:(Bool) -> Void) in
            generator.selectionChanged()
            self.manager.deleteNotification(atIndex: indexPath.row) {
                tableView.reloadData()
            }
            success(true)
        })
        closeAction.backgroundColor = FithubUI.Colors.weirdGreen
        return UISwipeActionsConfiguration(actions: [closeAction])
    }
    
    // MARK: Navigation
    
    @objc override func backButtonTapped(_ sender: UITapGestureRecognizer? = nil) {
        generator.selectionChanged()
        router.route(to: Route.back.rawValue, from: self, parameters: presentingVC)
    }
    
    @objc private func refresh(_ sender: AnyObject) {
        manager.updateAllNotifications() { }
        let rotation: CABasicAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
        rotation.toValue = Double.pi * 2
        rotation.duration = 0.5
        rotation.isCumulative = true
        rotation.repeatCount = 2
        refreshButton.layer.add(rotation, forKey: "rotationAnimation")
    }
}
