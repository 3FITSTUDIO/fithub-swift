//
//  CaloriesViewController.swift
//  fit-swift-client
//
//  Created by admin on 13/01/2020.
//  Copyright © 2020 Dominik Urbaez Gomez. All rights reserved.
//

import Foundation
import UIKit
import EasyPeasy

class CaloriesViewController: BasicComponentViewController, UITableViewDelegate, UITableViewDataSource {
    enum Route: String {
        case back
    }
    private let router = CaloriesRouter()
    private let viewModel = CaloriesViewModel()
    
    private var tableView: UITableView = UITableView()
    let cellReuseIdentifier = "reusableIdentifier"

    override func setup() {
        super.setup()
        addBottomNavigationBar()
    }
    
    override func viewDidLoad() {
        componentName = "Calories"
        super.viewDidLoad()
        container.addSubview(tableView)
        tableView.easy.layout(CenterX(), Top(90), Bottom(120), Left(19), Right(19))
        setupTableView()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(SimpleRecordTableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
    }
    
    private func setupTableView() {
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.allowsMultipleSelection = false
    }

// MARK: TableViewDelegate
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let recordsToDisplayCount = viewModel.fetchCaloriesData().count
        return recordsToDisplayCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier, for: indexPath) as? SimpleRecordTableViewCell else {
            fatalError("The dequeued cell is not an instance of SimpleRecordTableViewCell.")
        }
        
        let caloriesData = viewModel.fetchCaloriesDataForCell(forIndex: indexPath.row)
        cell.configure(type: componentName, recordData: caloriesData)
        
        return cell
    }

// MARK: Routing
    @objc override func backButtonTapped(_ sender: UITapGestureRecognizer? = nil) {
        router.route(to: Route.back.rawValue, from: self)
    }
}
