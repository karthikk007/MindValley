//
//  CategoriesCell.swift
//  MindValley
//
//  Created by Kumar, Karthik on 29/05/20.
//  Copyright © 2020 Kumar, Karthik. All rights reserved.
//

import UIKit

class BrowseByCategoriesCell: BaseCell {
    static let identifier = "BrowseByCategories"
    
    var categories: Categories? {
        return DataManager.sharedInstance.categories
    }
        
    let topSeparatorView: SeparatorView = {
        
        $0.translatesAutoresizingMaskIntoConstraints = false
        
        return $0
    }(SeparatorView())
    
    let headerLabel: UILabel = {
        $0.textColor = AppColor.Text.primaryColor
        
        $0.text = "Browse by categories"
        $0.font = UIFont.systemFont(ofSize: 20, weight: .heavy)
        
        $0.translatesAutoresizingMaskIntoConstraints = false
        
       return $0
    }(UILabel())
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        cv.backgroundColor = AppColor.ViewController.backgroundColor
        
        cv.dataSource = self
        cv.delegate = self
        
        cv.translatesAutoresizingMaskIntoConstraints = false
        
        return cv
    }()
    
    override func setupViews() {
        super.setupViews()
                
        addSubview(topSeparatorView)
        addSubview(headerLabel)
        addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            topSeparatorView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            topSeparatorView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            topSeparatorView.topAnchor.constraint(equalTo: topAnchor, constant: 0),
            topSeparatorView.heightAnchor.constraint(equalToConstant: 1)
        ])
        
        NSLayoutConstraint.activate([
            headerLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            headerLabel.topAnchor.constraint(equalTo: topAnchor, constant: 20),
//            headerLabel.heightAnchor.constraint(equalToConstant: 30)
        ])
        
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            collectionView.topAnchor.constraint(equalTo: headerLabel.bottomAnchor, constant: 20),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20)
        ])
        
        setupCollectionView()
    }
    
    private func setupCollectionView() {
        
        if let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.scrollDirection = .vertical
            flowLayout.minimumLineSpacing = 20
            
            flowLayout.itemSize = UICollectionViewFlowLayout.automaticSize
            flowLayout.estimatedItemSize = CGSize(width: (frame.width - 40 - 20) / 2, height: 60)
        }
        
        collectionView.register(CategoryCell.self, forCellWithReuseIdentifier: CategoryCell.identifier)
    }
    
    override var intrinsicContentSize: CGSize {
        var lineSpacing: CGFloat = 0.0
        
        if let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            lineSpacing = flowLayout.minimumLineSpacing
            flowLayout.estimatedItemSize = CGSize(width: (frame.width - 40 - 20) / 2, height: 60)
        }
        
        let cellsCount: Int = (collectionView.numberOfItems(inSection: 0) + 1)
        let rows: Int = (cellsCount / 2)
        let interimRows = (rows > 0) ? CGFloat(rows - 1) : CGFloat(0)
        let collectionViewHeight: CGFloat = CGFloat(rows * 60)
        let height: CGFloat = collectionViewHeight + interimRows * lineSpacing
        let labelHeight: CGFloat = headerLabel.intrinsicContentSize.height
        
        return CGSize(width: (frame.width - 40 - 20) / 2, height: height + 60 + labelHeight)
    }
    
    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        setNeedsLayout()
//        layoutIfNeeded()
        
        var frame = layoutAttributes.frame
        
        frame.size.height = intrinsicContentSize.height
        layoutAttributes.frame = frame
        
        return layoutAttributes
    }
    
    override func reloadCollectionView() {
        super.reloadCollectionView()
        
        collectionView.reloadData()
    }
}

extension BrowseByCategoriesCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories?.list.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCell.identifier, for: indexPath)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if let category = categories?.list[indexPath.item], let cell = cell as? CategoryCell {
            cell.configure(with: category)
        }
    }
}

extension BrowseByCategoriesCell: UICollectionViewDelegate {

}

extension BrowseByCategoriesCell: UICollectionViewDelegateFlowLayout {

}
