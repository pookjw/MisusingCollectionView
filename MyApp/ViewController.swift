//
//  ViewController.swift
//  MyApp
//
//  Created by Jinwoo Kim on 12/29/23.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    var count: Int = .zero
    
    let reg: UICollectionView.CellRegistration<UICollectionViewListCell, Int> = .init { cell, indexPath, itemIdentifier in
        var config: UIListContentConfiguration = cell.defaultContentConfiguration()
        config.text = itemIdentifier.description
        
        cell.contentConfiguration = config
    }
    
    var collectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let config: UICollectionLayoutListConfiguration = .init(appearance: .insetGrouped)
        let layout: UICollectionViewCompositionalLayout = .list(using: config)
        let collectionView: UICollectionView = .init(frame: view.bounds, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        view.addSubview(collectionView)
        
        self.collectionView = collectionView
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return collectionView.dequeueConfiguredReusableCell(using: reg, for: indexPath, item: indexPath.item)
    }
    
    @IBAction func crash_1(_ sender: Any) {
        count += 20
        
        for i in 0..<20 {
            collectionView.insertItems(at: [.init(item: i, section: .zero)])
        }
    }
    
    @IBAction func crash_2(_ sender: Any) {
        collectionView.reloadData()
        
        count += 20
        
        collectionView.performBatchUpdates {
            for i in 0..<20 {
                collectionView.insertItems(at: [.init(item: i, section: .zero)])
            }
        }
    }
}

// -[UICollectionView _endItemAnimationsWithInvalidationContext:tentativelyForReordering:animator:collectionViewAnimator:]
