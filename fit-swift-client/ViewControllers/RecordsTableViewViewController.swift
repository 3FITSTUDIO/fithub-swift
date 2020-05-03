//
//  RecordsTableViewViewController.swift
//  fit-swift-client
//
//  Created by admin on 28/04/2020.
//  Copyright © 2020 Dominik Urbaez Gomez. All rights reserved.
//

import Foundation
import UIKit
import EasyPeasy

class RecordsTableViewViewController: BasicComponentViewController, UITableViewDelegate, UITableViewDataSource {
    enum Route: String {
        case back
    }
    private let router = RecordsTableViewRouter()
    private var viewModel: DataSourceViewModel?
    private var dataType: DataProvider.DataType = .weights
    
    private var tableView: UITableView = UITableView()
    let cellReuseIdentifier = "reusableIdentifier"
    
    convenience init(viewModel: DataSourceViewModel, dataType type: DataProvider.DataType) {
        self.init()
        self.viewModel = viewModel
        self.componentName = type.rawValue
        dataType = type
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setup() {
        super.setup()
        addBottomNavigationBar()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        container.addSubview(tableView)
        tableView.easy.layout(CenterX(), Top(90), Bottom(120), Left(19), Right(19))
        setupTableView()
        
        viewModel?.vc = self
        
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
        guard let viewModel = viewModel else { return 0 }
        let recordsToDisplayCount = viewModel.data.count
        return recordsToDisplayCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier, for: indexPath) as? SimpleRecordTableViewCell else {
            fatalError("The dequeued cell is not an instance of SimpleRecordTableViewCell.")
        }
        guard let viewModel = viewModel else {
            fatalError("Data view model error: no view model found!")
        }
        let data = viewModel.fetchDataForCell(forIndex: indexPath.row)
        cell.configure(type: self.dataType, recordData: data)
        
        return cell
    }

// MARK: Routing
    @objc override func backButtonTapped(_ sender: UITapGestureRecognizer? = nil) {
        generator.selectionChanged()
        router.route(to: Route.back.rawValue, from: self)
    }
}
