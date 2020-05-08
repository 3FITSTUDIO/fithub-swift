//
//  NewValueSelectionRouter.swift
//  fit-swift-client
//
//  Created by admin on 08/05/2020.
//  Copyright © 2020 Dominik Urbaez Gomez. All rights reserved.
//

import Foundation
import UIKit

class NewValueSelectionRouter: Router {
    func route(to routeID: String, from context: UIViewController, parameters: Any? = nil) {
        guard let route = NewValueSelectionViewController.Route(rawValue: routeID) else { return }
        let vc: UIViewController
        switch route {
        case .back:
            vc = DashboardViewController()
        case .selected:
            if let selectedType = parameters as? DataProvider.DataType {
                vc = AddNewValueViewController(type: selectedType)
            }
            else {
                vc = DashboardViewController()
            }
        }
        context.navigationController?.pushViewController(vc, animated: false)
    }
    
    
}
