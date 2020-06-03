//
//  ProductCell.swift
//  MindValley
//
//  Created by Kumar, Karthik on 29/05/20.
//  Copyright © 2020 Kumar, Karthik. All rights reserved.
//

import UIKit

protocol ProductCellDataSource: class {
    var cellStyle: ProductsCollectionView.Style { get }
}

struct ProductCellModel {
    let title: String
    let subTitle: String
    let assetUrl: String
}

class ProductCell: BaseCell {
    static let identifier = "ProductCell"
    
    weak var delegate: ProductCellDataSource? {
        didSet {
            configureConstraints()
        }
    }
    
    var style: ProductsCollectionView.Style {
        return delegate?.cellStyle ?? .default
    }
    
    let imageView: CustomImageView = {
        $0.contentMode = .scaleAspectFill
        $0.layer.masksToBounds = true
        $0.layer.cornerRadius = 10
        
        $0.image = UIImage(named: "placeholder")
        
        $0.translatesAutoresizingMaskIntoConstraints = false
       
        return $0
    }(CustomImageView())
    
    let titleLabel: UILabel = {
        $0.textColor = AppColor.Text.secondaryColor
        $0.textAlignment = .left
        
        $0.text = "The Cure For Lonelin"
        $0.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        
        $0.numberOfLines = 2
        
        $0.translatesAutoresizingMaskIntoConstraints = false
        
       return $0
    }(UILabel())
    
    let descriptionLabel: UILabel = {
        $0.textColor = AppColor.Text.primaryColor
        $0.textAlignment = .left
        
        $0.text = "Mindvalley Mentoring"
        $0.font = UIFont.systemFont(ofSize: 13, weight: .bold)
        
        $0.numberOfLines = 2
        
        $0.translatesAutoresizingMaskIntoConstraints = false
        
       return $0
    }(UILabel())
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        roundedCorners()
    }
    
    override func setupViews() {
        super.setupViews()
        
        addSubview(imageView)
        addSubview(titleLabel)
        addSubview(descriptionLabel)
    }
    
    private func configureConstraints() {
                
        switch style {
        case .default:
            setupViewsForDefaultStyle()
        case .titleOnly:
            setupViewsForTitleOnly()
        case .extendedImage:
            setupViewsForExtendedImage()
        }
    }
    
    private func setupViewsForDefaultStyle() {
        descriptionLabel.isHidden = false
        
        NSLayoutConstraint.deactivate(imageView.constraints)
        NSLayoutConstraint.deactivate(titleLabel.constraints)
        
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0),
            imageView.topAnchor.constraint(equalTo: topAnchor, constant: 0),
            imageView.heightAnchor.constraint(equalToConstant: 240)
        ])
        
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 4),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -4),
            titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 10)
            //            titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20),
            //            titleLabel.heightAnchor.constraint(equalToConstant: 30)
        ])
        
//        titleLabel.setContentHuggingPriority(.required, for: .vertical)
//        titleLabel.setContentCompressionResistancePriority(.required, for: .vertical)
        
        NSLayoutConstraint.activate([
            descriptionLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 4),
            descriptionLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -4),
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            descriptionLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
        ])
        
        descriptionLabel.setContentHuggingPriority(.defaultHigh, for: .vertical)
        descriptionLabel.setContentCompressionResistancePriority(.required, for: .vertical)
        
        titleLabel.numberOfLines = 0
    }
    
    private func setupViewsForTitleOnly() {
        descriptionLabel.isHidden = true
        
        NSLayoutConstraint.deactivate(imageView.constraints)
        NSLayoutConstraint.deactivate(titleLabel.constraints)
        
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0),
            imageView.topAnchor.constraint(equalTo: topAnchor, constant: 0),
            imageView.heightAnchor.constraint(equalToConstant: 230)
        ])
        
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 4),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -4),
            titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 10)
            //            titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20),
            //            titleLabel.heightAnchor.constraint(equalToConstant: 30)
        ])
        
        titleLabel.setContentHuggingPriority(.defaultHigh, for: .vertical)
        titleLabel.setContentCompressionResistancePriority(.required, for: .vertical)
        
        titleLabel.numberOfLines = 0
    }
    
    private func setupViewsForExtendedImage() {
        descriptionLabel.isHidden = true
        
        NSLayoutConstraint.deactivate(imageView.constraints)
        NSLayoutConstraint.deactivate(titleLabel.constraints)
        
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0),
            imageView.topAnchor.constraint(equalTo: topAnchor, constant: 0),
            imageView.heightAnchor.constraint(equalToConstant: 180)
        ])
        
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 4),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -4),
            titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 10)
            //            titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20),
            //            titleLabel.heightAnchor.constraint(equalToConstant: 30)
        ])
        
        titleLabel.setContentHuggingPriority(.defaultHigh, for: .vertical)
        titleLabel.setContentCompressionResistancePriority(.required, for: .vertical)
        
        titleLabel.numberOfLines = 4
    }
    
    func configure(with model: ProductCellModel) {
        imageView.loadImage(with: model.assetUrl)
        
        switch style {
        case .default:
            titleLabel.text = model.title
            descriptionLabel.text = model.subTitle
        default:
            titleLabel.text = model.title
        }
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        imageView.image = UIImage(named: "placeholder")
    }
}
