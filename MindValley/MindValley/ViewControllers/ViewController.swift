//
//  ViewController.swift
//  MindValley
//
//  Created by Kumar, Karthik on 29/05/20.
//  Copyright © 2020 Kumar, Karthik. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var storedOffsets = [IndexPath: CGFloat]()
    
    var isDataChanged = false
    
    var count: Int {
        return 2 + (channels?.list.count ?? 0)
//        return 1
    }
    
    var categories: Categories? {
        return DataManager.sharedInstance.categories
    }
    
    var episodes: Episodes? {
        return DataManager.sharedInstance.episodes
    }
    
    var channels: Channels? {
        return DataManager.sharedInstance.channels
    }
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        cv.backgroundColor = AppColor.ViewController.backgroundColor
        
        cv.dataSource = self
        cv.delegate = self
        
        cv.translatesAutoresizingMaskIntoConstraints = false
        
        return cv
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupNavigationBar()
        setupViews()
        
        view.backgroundColor = AppColor.ViewController.backgroundColor
        
        subscribeToDataManagerEvents(for: [.fetchComplete])
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        DataManager.sharedInstance.refreshData()
    }
    
    private func setupViews() {
        view.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
                
        setupCollectionView()
    }
    
    private func setupCollectionView() {
        if let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.scrollDirection = .vertical
            flowLayout.minimumLineSpacing = 20
            
            flowLayout.itemSize = UICollectionViewFlowLayout.automaticSize
            flowLayout.estimatedItemSize = CGSize(width: UIScreen.main.bounds.width, height: 800)
        }
        
        for type in CellType.allCases {
            collectionView.register(type.cell(), forCellWithReuseIdentifier: type.identifier)
        }
    }
    
    private func cellType(for indexPath: IndexPath) -> CellType {
        var cellType: CellType
        
        if indexPath.item == 0 {
            cellType = .newEpisodes
        } else if indexPath.item == count - 1 {
            cellType = .category
        } else {
            cellType = .channelsEpisode
            
            if let channel = channels?.list[indexPath.item - 1] {
                if let count = channel.seriesList?.count, count > 0 {
                    cellType = .channelsSeries
                }
            }
        }
        
        return cellType
    }
}

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let type = cellType(for: indexPath)
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: type.identifier, for: indexPath)
                
        if let cell = cell as? ChannelsCell,
            let channel = channels?.list[indexPath.item - 1] {
            
            if type == .channelsSeries {
                cell.configure(with: .series, channel: channel)
            } else {
                cell.configure(with: .episode, channel: channel)
            }
            
        }
        
        if let cell = cell as? BrowseByCategoriesCell, isDataChanged {
            isDataChanged = false
            cell.reloadCollectionView()
        }
                
        return cell
    }
}

extension ViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        guard let cell = cell as? ChannelsCell else {
            return
        }
        
        cell.collectionViewOffset = storedOffsets[indexPath] ?? -20
    }
    
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard let cell = cell as? ChannelsCell else {
            return
        }
        
        storedOffsets[indexPath] = cell.collectionViewOffset
    }
}

extension ViewController: UICollectionViewDelegateFlowLayout {
}


extension ViewController: NavigationBarCustomizable {
    var navigationTitle: String {
        return "Channels"
    }
}

extension ViewController: DataManagerEventsObservable {
    func fetchCompelete(notification: Notification) {
//        collectionView.reloadData()
        isDataChanged = true
        collectionView.performBatchUpdates({
            collectionView.reloadSections(IndexSet(integer: 0))
            self.storedOffsets.removeAll()
        })
    }
}

extension ViewController {
    enum CellType: CaseIterable {
        case newEpisodes
        case channelsEpisode
        case category
        case channelsSeries
        
        func cell() -> UICollectionViewCell.Type {
            switch self {
            case .newEpisodes:
                return NewEpisodesCell.self
            case .channelsEpisode:
                return ChannelsCell.self
            case .channelsSeries:
                return ChannelsCell.self
            case .category:
                return BrowseByCategoriesCell.self
            }
        }
        
        var identifier: String {
            switch self {
            case .newEpisodes:
                return NewEpisodesCell.identifier
            case .channelsEpisode:
                return ChannelsCell.identifier
            case .channelsSeries:
                return "ChannelsCell-Series"
            case .category:
                return BrowseByCategoriesCell.identifier
            }
        }
    }
}
