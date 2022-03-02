//
//  UIImageView.swift
//  PlusIT
//
//  Created by Diego Rodrigues Abdala Uthman on 01/03/22.
//

import UIKit

extension UIImageView {
    func setDownloadImage(url: String) {
        if let url = URL(string: url) {
            if let data = try? Data(contentsOf: url) {
                self.image  = UIImage(data: data)
            }
        }
    }
    
    func makeRounded() {
        self.layer.masksToBounds = false
        self.layer.cornerRadius = 10.0
        self.clipsToBounds = true
    }
}
