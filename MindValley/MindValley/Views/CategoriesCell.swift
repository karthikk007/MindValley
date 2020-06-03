//
//  CategoriesCell.swift
//  MindValley
//
//  Created by Kumar, Karthik on 29/05/20.
//  Copyright © 2020 Kumar, Karthik. All rights reserved.
//

import UIKit

class BrowseByCategories: BaseCell {
    static let identifier = "CategoriesCell"
    
    let count = 10
    
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
        
        NSLayoutConstraint.activate([
            topSeparatorView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            topSeparatorView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            topSeparatorView.topAnchor.constraint(equalTo: topAnchor, constant: 0),
            topSeparatorView.heightAnchor.constraint(equalToConstant: 1)
        ])
        
        NSLayoutConstraint.activate([
            headerLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            headerLabel.topAnchor.constraint(equalTo: topAnchor, constant: 20)
        ])
    }
}

extension BrowseByCategories: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let identifier: String
        
        if indexPath.item == 0 {
            identifier = EpisodesCell.identifier
        } else if indexPath.item == count - 1 {
            identifier = BrowseByCategories.identifier
        } else {
            identifier = ChannelsCell.identifier
        }
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath)
                
        return cell
    }
}

extension BrowseByCategories: UICollectionViewDelegate {

}

extension BrowseByCategories: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (frame.width - 20 - 20 - 15) / 2, height: 60)
    }
}
