//
//  DetailsViewController.swift
//  PlusIT
//
//  Created by Diego Rodrigues Abdala Uthman on 01/03/22.
//

import UIKit

class DetailsViewController: UIViewController {
    
    lazy var descriptionLabel: UILabel = {
        $0.font = UIFont(name: "Courier Bold", size: 17)
        $0.textColor = .black
        $0.numberOfLines = 0
        $0.textAlignment = .left
        $0.sizeToFit()
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UILabel())
    
    lazy var imageView: UIImageView = {
        $0.contentMode = .scaleAspectFit
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIImageView())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    convenience init(title: String, description: String, urlImage: String) {
        self.init()
        self.descriptionLabel.text = description
        self.title = title
        self.imageView.setDownloadImage(url: urlImage)
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        view.addSubview(imageView)
        view.addSubview(descriptionLabel)
        
        imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
        imageView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 12.0).isActive = true
        imageView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -12.0).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 120).isActive = true
        
        descriptionLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 30).isActive = true
        descriptionLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 12.0).isActive = true
        descriptionLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -12.0).isActive = true
        descriptionLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
    }
}
