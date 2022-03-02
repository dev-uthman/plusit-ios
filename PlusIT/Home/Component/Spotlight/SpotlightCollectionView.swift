//
//  SpotlightCollectionView.swift
//  PlusIT
//
//  Created by Diego Rodrigues Abdala Uthman on 01/03/22.
//

import UIKit

class SpotlightCollectionView: UICollectionView {
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width, height: 240)
        super.init(frame: frame, collectionViewLayout: layout)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout() {
        showsHorizontalScrollIndicator = false
        register(SpotlightCollectionViewCell.self, forCellWithReuseIdentifier: SpotlightCollectionViewCell.reuseIdentifier)
        translatesAutoresizingMaskIntoConstraints = false
    }

}
