//
//  Coordinator.swift
//  MindValley
//
//  Created by Kumar, Karthik on 29/05/20.
//  Copyright © 2020 Kumar, Karthik. All rights reserved.
//

import UIKit

protocol Coordinator {
    var childCoordinator: [Coordinator] { get set }
    var navigationController: UINavigationController { get set }
    
    func start()
}
