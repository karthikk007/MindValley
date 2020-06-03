//
//  UIViewExtension.swift
//  MindValley
//
//  Created by Kumar, Karthik on 29/05/20.
//  Copyright © 2020 Kumar, Karthik. All rights reserved.
//

import UIKit

extension UIView {
    // drop shadow performs corner radius as well.
    // this is for current implementation only.
    func dropShadow() {
        layer.cornerRadius = 10.0
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        layer.shadowRadius = 6.0
        layer.shadowOpacity = 0.7
        
        layer.rasterizationScale = UIScreen.main.scale
    }
    
    func roundedCorners() {
        layer.cornerRadius = 10.0
    }
}
