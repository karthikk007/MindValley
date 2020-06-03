//
//  ChannelsCell.swift
//  MindValley
//
//  Created by Kumar, Karthik on 29/05/20.
//  Copyright © 2020 Kumar, Karthik. All rights reserved.
//

import UIKit

class ChannelsCell: BaseCell {
    static let identifier = "ChannelsCell"
    
    var style: Style = .episode {
        didSet {
            productsCollectionView.style = style == .episode ? .titleOnly : .extendedImage
        }
    }
    
    var collectionViewOffset: CGFloat {
        set {
            productsCollectionView.contentOffset.x = newValue
        }

        get {
            return productsCollectionView.contentOffset.x
        }
    }
        
    var channel: Channel? {
        didSet {
            reloadCollectionView()
        }
    }
    
    let headerView: ChannelCellHeaderView = {
        
        $0.translatesAutoresizingMaskIntoConstraints = false
        
        return $0
    }(ChannelCellHeaderView())
    
    let topSeparatorView: SeparatorView = {
        
        $0.translatesAutoresizingMaskIntoConstraints = false
        
        return $0
    }(SeparatorView())
    
    lazy var productsCollectionView: ProductsCollectionView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        
        $0.productsDataSource = self
        
        return $0
    }(ProductsCollectionView(with: .titleOnly))
        
    override func setupViews() {
        super.setupViews()
        
        addSubview(topSeparatorView)
        addSubview(headerView)
        addSubview(productsCollectionView)
        
        NSLayoutConstraint.activate([
            topSeparatorView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            topSeparatorView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            topSeparatorView.topAnchor.constraint(equalTo: topAnchor, constant: 0),
            topSeparatorView.heightAnchor.constraint(equalToConstant: 1)
        ])
        
        NSLayoutConstraint.activate([
            headerView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            headerView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            headerView.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            headerView.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        NSLayoutConstraint.activate([
            productsCollectionView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
            productsCollectionView.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 20),
            productsCollectionView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0),
            productsCollectionView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20),
        ])
    }
    
    override var intrinsicContentSize: CGSize {
        let verticalMargins: CGFloat = 60
        return CGSize(width: bounds.width, height: headerView.intrinsicContentSize.height + verticalMargins + productsCollectionView.cellStyle.collectionViewSize.height + 20)
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
    
    func configure(with style: Style, channel: Channel) {
        self.channel = channel
        self.style = style
        
        headerView.configure(with: style, channel: channel)
    }
    
    override func reloadCollectionView() {
        super.reloadCollectionView()
        productsCollectionView.collectionViewLayout.invalidateLayout()
        
        productsCollectionView.reloadData()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        headerView.prepareForReuse()
    }
}

extension ChannelsCell: ProductsCollectionViewDataSource {
    func numberOfItems(sender: ProductsCollectionView) -> Int {
        if style == .series {
            return channel?.seriesList?.count ?? 0
        } else {
            return channel?.latestMediaList?.count ?? 0
        }
        
    }
    
    func data(for indexPath: IndexPath, sender: ProductsCollectionView) -> ProductCellModel? {
        var model: ProductCellModel?
        
        if style == .series {
            if let item = channel?.seriesList?[indexPath.item] {
                model = ProductCellModel(title: item.title ?? "",
                                         subTitle: "",
                                         assetUrl: item.assetUrl ?? "")
            }
        } else {
            if let item = channel?.latestMediaList?[indexPath.item] {
                model = ProductCellModel(title: item.title ?? "",
                                         subTitle: "",
                                         assetUrl: item.assetUrl ?? "")
            }
        }


        return model
    }
}

extension ChannelsCell {
    enum Style {
        case episode
        case series
    }
}

class ChannelCellHeaderView: BaseView {
    
    let imageView: CustomImageView = {
        $0.contentMode = .scaleAspectFill
        
        $0.image = UIImage(named: "placeholder")
        
        $0.translatesAutoresizingMaskIntoConstraints = false
       
        return $0
    }(CustomImageView())
    
    let titleLabel: UILabel = {
        $0.textColor = AppColor.Text.secondaryColor
        $0.text = "Mindvalley Mentoring"
        $0.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        
        $0.translatesAutoresizingMaskIntoConstraints = false
        
       return $0
    }(UILabel())
    
    let subtitleLabel: UILabel = {
        $0.textColor = AppColor.Text.primaryColor
        $0.text = "78 episodes"
        $0.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        
        $0.translatesAutoresizingMaskIntoConstraints = false
        
       return $0
    }(UILabel())
    
    override var intrinsicContentSize: CGSize {
        let verticalMargins: CGFloat = 0
        return CGSize(width: bounds.width, height: 50 + verticalMargins)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = imageView.bounds.width / 2
    }
    
    override func setupViews() {
        super.setupViews()
        
        addSubview(imageView)
        addSubview(titleLabel)
        addSubview(subtitleLabel)
        
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
            imageView.widthAnchor.constraint(equalToConstant: 50),
            imageView.heightAnchor.constraint(equalToConstant: 50),
            imageView.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
        
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 14),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0),
            titleLabel.bottomAnchor.constraint(equalTo: centerYAnchor, constant: 0)
        ])
        
        NSLayoutConstraint.activate([
            subtitleLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor, constant: 0),
            subtitleLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor, constant: 0),
            subtitleLabel.topAnchor.constraint(equalTo: centerYAnchor, constant: 0)
        ])
    }
    
    func configure(with style: ChannelsCell.Style, channel: Channel) {
        if let thumbnailUrl = channel.thumbnailUrl {
            imageView.loadImage(with: thumbnailUrl)
        } else if let assetUrl = channel.assetUrl {
            imageView.loadImage(with: assetUrl)
        }
        
        titleLabel.text = channel.title
        
        if style == .series {
            subtitleLabel.text = String(describing: channel.seriesList?.count ?? 0) + " series"
        } else {
            subtitleLabel.text = String(describing: channel.latestMediaList?.count ?? 0) + " episodes"
        }
    }
    
    func prepareForReuse() {
        imageView.image = UIImage(named: "placeholder")
    }
}

