//
//  NavigationBarCustomizable.swift
//  MindValley
//
//  Created by Kumar, Karthik on 29/05/20.
//  Copyright © 2020 Kumar, Karthik. All rights reserved.
//

import Foundation

import UIKit

protocol NavigationBarCustomizable where Self: UIViewController  {
    var navigationTitle: String { get }
//    var leftNavigationItem: NavigationItem? { get }
//    var rightNavigationItem: NavigationItem? { get }
    
    func setupNavigationBar()
}

extension NavigationBarCustomizable {
//    var leftNavigationItem: NavigationItem? {
//        return nil
//    }
    
//    var rightNavigationItem: NavigationItem? {
//        return nil
//    }
    
    func setupNavigationBar() {
        setupNavigationBar(with: navigationTitle)
        
        navigationController?.view.backgroundColor = AppColor.ViewController.backgroundColor
        navigationController?.navigationBar.barTintColor = AppColor.ViewController.backgroundColor
        
        navigationController?.navigationBar.isTranslucent = false
        
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: AppColor.NavigationBar.titleTextColor,
                                                                   NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20, weight: .bold)]
        navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: AppColor.NavigationBar.titleTextColor,
                                                                        NSAttributedString.Key.font: UIFont.systemFont(ofSize: 26, weight: .bold)]
        navigationController?.navigationBar.prefersLargeTitles = true
    }
}
