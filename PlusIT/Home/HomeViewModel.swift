//
//  HomeViewModel.swift
//  PlusIT
//
//  Created by Diego Rodrigues Abdala Uthman on 28/02/22.
//

import UIKit
import RxSwift
import RxCocoa

class HomeViewModel {
    
    var spotlight = BehaviorRelay<[Spotlight?]>(value: [])
    var products = BehaviorRelay<[Product?]>(value: [])
    var cash = BehaviorRelay<Cash?>(value: nil)
    
    func fetchData() {
        let service = HomeService()
        service.fetchData {[spotlight, products, cash] response in
            spotlight.accept(response.spotlight)
            products.accept(response.products)
            cash.accept(response.cash)
        }
    }
}
