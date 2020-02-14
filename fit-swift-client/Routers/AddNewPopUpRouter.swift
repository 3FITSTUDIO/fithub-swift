//
//  AddNewPopUpRouter.swift
//  fit-swift-client
//
//  Created by admin on 14/01/2020.
//  Copyright © 2020 Dominik Urbaez Gomez. All rights reserved.
//

import Foundation
import UIKit

class AddNewPopUpRouter: Router {
    
    func route(to routeID: String, from context: UIViewController, parameters: Any? = nil) {
        guard let route = AddNewPopUp.Route(rawValue: routeID) else { return }
        let vc: UIViewController
        switch route {
        case .newWeight:
            vc = AddNewValueViewController(type: .weight)
        case .newCalories:
            vc = AddNewValueViewController(type: .calories)
        }
        context.present(vc, animated: true, completion: nil)
    }
}
