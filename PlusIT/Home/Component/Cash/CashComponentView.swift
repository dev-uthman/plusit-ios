//
//  CashComponentView.swift
//  PlusIT
//
//  Created by Diego Rodrigues Abdala Uthman on 01/03/22.
//

import UIKit

protocol CashComponentViewProtocol {
    func tapGesture()
}

class CashComponentView: UIView {
    
    internal var delegate: CashComponentViewProtocol?
    
    lazy var digioLabel: UILabel = {
        let label = UILabel()
        label.text = "Digio Cash"
        label.font = UIFont(name: "Courier Bold", size: 17)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        imageView.sizeToFit()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
        setupTapGesture()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout() {
        addSubview(digioLabel)
        addSubview(imageView)
        
        digioLabel.topAnchor.constraint(equalTo: topAnchor).isActive = true
        digioLabel.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        digioLabel.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        digioLabel.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        imageView.topAnchor.constraint(equalTo: digioLabel.bottomAnchor, constant: 5).isActive = true
        imageView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        imageView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 100).isActive = true
    }
    
    private func setupTapGesture() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapView))
        addGestureRecognizer(tap)
    }
    
    @objc func tapView() {
        delegate?.tapGesture()
    }
    
    internal func configImage(urlImage: String) {
        imageView.setDownloadImage(url: urlImage)
        imageView.makeRounded()
        setNeedsLayout()
    }
}
