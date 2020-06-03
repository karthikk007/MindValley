//
//  CategoriesCell.swift
//  MindValley
//
//  Created by Kumar, Karthik on 29/05/20.
//  Copyright © 2020 Kumar, Karthik. All rights reserved.
//

import UIKit

class CategoryCell: BaseCell {
    static let identifier = "CategoriesCell"
    
    let titleLabel: UILabel = {
        $0.textColor = AppColor.Text.secondaryColor
        $0.textAlignment = .center
        
        $0.text = "Health & Fitness"
        $0.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        
        $0.numberOfLines = 2
        
        $0.translatesAutoresizingMaskIntoConstraints = false
        
       return $0
    }(UILabel())
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        layer.cornerRadius = bounds.height / 2
        layer.masksToBounds = true
        
        backgroundColor = AppColor.View.backgroundColor
    }
    
    override func setupViews() {
        super.setupViews()
        
        addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 0),
            titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0),
        ])
    }
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: frame.width, height: 60)
    }
    
    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        setNeedsLayout()
        layoutIfNeeded()
        
        var frame = layoutAttributes.frame
        
        frame.size.height = intrinsicContentSize.height
        layoutAttributes.frame = frame
        
        return layoutAttributes
    }
}
