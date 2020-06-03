//
//  EpisodesCell.swift
//  MindValley
//
//  Created by Kumar, Karthik on 29/05/20.
//  Copyright © 2020 Kumar, Karthik. All rights reserved.
//

import UIKit

class NewEpisodesCell: BaseCell {
    static let identifier = "EpisodesCell"
    
//    var episodes: Episodes? = DataManager.sharedInstance.episodes {
//        didSet {
//            self.productsCollectionView.reloadData()
//        }
//    }
    
    var episodes: Episodes? {
        return DataManager.sharedInstance.episodes
    }
    
    let headerLabel: UILabel = {
        $0.textColor = AppColor.Text.primaryColor
        $0.text = "New Episodes"
        $0.font = UIFont.systemFont(ofSize: 20, weight: .heavy)
        
        $0.translatesAutoresizingMaskIntoConstraints = false
        
       return $0
    }(UILabel())
    
    lazy var productsCollectionView: ProductsCollectionView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        
        $0.productsDataSource = self
        
        return $0
    }(ProductsCollectionView(with: .default))
    
    override func setupViews() {
        super.setupViews()
                
        addSubview(headerLabel)
        addSubview(productsCollectionView)
        
        NSLayoutConstraint.activate([
            headerLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            headerLabel.topAnchor.constraint(equalTo: topAnchor, constant: 20)
        ])
        
        NSLayoutConstraint.activate([
            productsCollectionView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
            productsCollectionView.topAnchor.constraint(equalTo: headerLabel.bottomAnchor, constant: 20),
            productsCollectionView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0),
            productsCollectionView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20),
        ])
        
        setupNotifications()
    }
    
    private func setupNotifications() {
//        subscribeToDataManagerEvents(for: [.episodesFetched])
    }
    
    override var intrinsicContentSize: CGSize {
        let verticalMargins: CGFloat = 60
        
        return CGSize(width: bounds.width, height: headerLabel.intrinsicContentSize.height + verticalMargins + ProductsCollectionView.Style.default.collectionViewSize.height + 20)
    }
    
    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        setNeedsLayout()
//        layoutIfNeeded()
        
        let size = contentView.systemLayoutSizeFitting(layoutAttributes.size)
        var frame = layoutAttributes.frame
        
        frame.size.height = intrinsicContentSize.height
        layoutAttributes.frame = frame
        
        return layoutAttributes
    }
}

extension NewEpisodesCell: ProductsCollectionViewDataSource {
    func numberOfItems(sender: ProductsCollectionView) -> Int {
        return episodes?.list.count ?? 0
    }
    
    func data(for indexPath: IndexPath, sender: ProductsCollectionView) -> ProductCellModel? {
        let item = episodes?.list[indexPath.item]
        let model = ProductCellModel(title: item?.title ?? "",
                                     subTitle: item?.channelTitle ?? "",
                                     assetUrl: item?.assetUrl ?? "")
        return model
    }
}
