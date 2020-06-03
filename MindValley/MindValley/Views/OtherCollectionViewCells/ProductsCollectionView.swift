//
//  ProductsCollectionView.swift
//  MindValley
//
//  Created by Kumar, Karthik on 29/05/20.
//  Copyright © 2020 Kumar, Karthik. All rights reserved.
//

import UIKit

class BaseCollectionView: UICollectionView {
    
    init() {
        let layout = UICollectionViewFlowLayout()
        super.init(frame: .zero, collectionViewLayout: layout)
        
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        
    }
}

protocol ProductsCollectionViewDataSource: class {
    func numberOfItems(sender: ProductsCollectionView) -> Int
    func data(for indexPath: IndexPath, sender: ProductsCollectionView) -> ProductCellModel?
}

class ProductsCollectionView: BaseCollectionView {
    var style: Style {
        didSet {
            collectionViewLayout.invalidateLayout()
        }
    }
    
    weak var productsDataSource: ProductsCollectionViewDataSource?
    
    init(with style: Style) {
        self.style = style
        
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setupViews() {
        super.setupViews()
        
        showsHorizontalScrollIndicator = false
        
        backgroundColor = AppColor.ViewController.backgroundColor
        
        delegate = self
        dataSource = self
        prefetchDataSource = self
                
        register(ProductCell.self, forCellWithReuseIdentifier: ProductCell.identifier)
        
        if let flowLayout = collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.scrollDirection = .horizontal
            flowLayout.minimumLineSpacing = 20
        }
        
        contentInset = UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 20)
    }
}

extension ProductsCollectionView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return productsDataSource?.numberOfItems(sender: self) ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductCell.identifier, for: indexPath) as? ProductCell {
            cell.delegate = self
            
            return cell
        }
        
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if let model = productsDataSource?.data(for: indexPath, sender: self),
            let cell = cell as? ProductCell {
            cell.configure(with: model)
        }
    }
}

extension ProductsCollectionView: UICollectionViewDelegate {

}

extension ProductsCollectionView: UICollectionViewDataSourcePrefetching {
    func collectionView(_ collectionView: UICollectionView,
                        prefetchItemsAt indexPaths: [IndexPath]) {
        print("Prefetch: \(indexPaths)")
    }
}

extension ProductsCollectionView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return style.collectionViewSize        
    }
}

extension ProductsCollectionView {
    enum Style {
        case `default`
        case titleOnly
        case extendedImage
        
        var collectionViewSize: CGSize {
            switch self {
            case .default:
                return CGSize(width: 160, height: 370)
            case .titleOnly:
                return CGSize(width: 160, height: 320)
            case .extendedImage:
                return CGSize(width: 320, height: 240)
            }
        }
    }
}

extension ProductsCollectionView: ProductCellDataSource {
    var cellStyle: Style {
        return style
    }
}
