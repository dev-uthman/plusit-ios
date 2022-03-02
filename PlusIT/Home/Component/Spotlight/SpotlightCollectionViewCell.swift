//
//  SpotlightCollectionViewCell.swift
//  PlusIT
//
//  Created by Diego Rodrigues Abdala Uthman on 28/02/22.
//

import UIKit

class SpotlightCollectionViewCell: UICollectionViewCell {
    
    static let reuseIdentifier = String(describing: SpotlightCollectionViewCell.self)
    
    private lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
        
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    private func setupUI() {
        addSubview(containerView)
        containerView.leftAnchor.constraint(equalTo: leftAnchor, constant: 0).isActive = true
        containerView.rightAnchor.constraint(equalTo: rightAnchor, constant: 0).isActive = true
        containerView.topAnchor.constraint(equalTo: topAnchor, constant: 0).isActive = true
        containerView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0).isActive = true
        
        containerView.addSubview(imageView)
        imageView.topAnchor.constraint(equalTo: containerView.topAnchor).isActive = true
        imageView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor).isActive = true
        imageView.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 5).isActive = true
        imageView.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -5).isActive = true
    }
    
    internal func configImage(urlImage: String) {
        imageView.setDownloadImage(url: urlImage)
        imageView.makeRounded()
        setNeedsLayout()
    }
}

