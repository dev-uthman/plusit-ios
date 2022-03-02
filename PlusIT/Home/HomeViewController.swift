//
//  HomeViewController.swift
//  PlusIT
//
//  Created by Diego Rodrigues Abdala Uthman on 28/02/22.
//

import UIKit
import RxSwift

class HomeViewController: UIViewController {
    
    private var viewModel = HomeViewModel()
    private var disposBag = DisposeBag()
    
    var spotlightColectionView = SpotlightCollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout())
    
    var productCollectionView = ProductCollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout())
    
    lazy var cashComponentView: CashComponentView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.delegate = self
        return $0
    }(CashComponentView())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        viewModel.fetchData()
        bindRx()
    }
    
    private func setupUI() {
        setupCollectionView()
        setupCashComponentView()
        setupProductCollectionView()
    }
    
    private func setupCollectionView() {
        view.addSubview(spotlightColectionView)
        spotlightColectionView.delegate = self
        spotlightColectionView.dataSource = self
        spotlightColectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
        spotlightColectionView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0).isActive = true
        spotlightColectionView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0).isActive = true
        spotlightColectionView.heightAnchor.constraint(lessThanOrEqualToConstant: 240).isActive = true
    }
    
    private func setupCashComponentView() {
        view.addSubview(cashComponentView)
        cashComponentView.topAnchor.constraint(equalTo: spotlightColectionView.bottomAnchor, constant: 10).isActive = true
        cashComponentView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10).isActive = true
        cashComponentView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10).isActive = true
        cashComponentView.heightAnchor.constraint(equalToConstant: 160).isActive = true
    }
    
    private func setupProductCollectionView() {
        view.addSubview(productCollectionView)
        productCollectionView.delegate = self
        productCollectionView.dataSource = self
        productCollectionView.topAnchor.constraint(equalTo: cashComponentView.bottomAnchor, constant: 10).isActive = true
        productCollectionView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0).isActive = true
        productCollectionView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0).isActive = true
        productCollectionView.heightAnchor.constraint(lessThanOrEqualToConstant: 200).isActive = true
    }
    
    private func bindRx() {
        viewModel
            .spotlight
            .observe(on: MainScheduler.asyncInstance)
            .subscribe(onNext: { [spotlightColectionView] _ in
                spotlightColectionView.reloadData()
            }).disposed(by: disposBag)
        
        viewModel
            .cash
            .observe(on: MainScheduler.asyncInstance)
            .subscribe(onNext: { [cashComponentView] cash in
                cashComponentView.configImage(urlImage: cash?.bannerURL ?? "")
            }).disposed(by: disposBag)
        
        viewModel
            .products
            .observe(on: MainScheduler.asyncInstance)
            .subscribe(onNext: { [productCollectionView] _ in
                productCollectionView.reloadData()
            }).disposed(by: disposBag)
    }
}

extension HomeViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == spotlightColectionView {
            if let cell = spotlightColectionView.dequeueReusableCell(withReuseIdentifier: SpotlightCollectionViewCell.reuseIdentifier, for: indexPath) as? SpotlightCollectionViewCell {
                let spotlight = viewModel.spotlight.value
                cell.configImage(urlImage: spotlight[indexPath.row]?.bannerURL ?? "")
                return cell
            }
        }

        if collectionView == productCollectionView {
            if let cell = productCollectionView.dequeueReusableCell(withReuseIdentifier: ProductCollectionViewCell.reuseIdentifier, for: indexPath) as? ProductCollectionViewCell {
                let products = viewModel.products.value
                cell.configImage(urlImage: products[indexPath.row]?.imageURL ?? "")
                return cell
            }
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        var vc = UIViewController()
        if collectionView == productCollectionView {
            let product = viewModel.products.value[indexPath.row]
            vc = DetailsViewController(title: product?.name ?? "", description: product?.description ?? "", urlImage: product?.imageURL ?? "")
        }
        
        if collectionView == spotlightColectionView {
            let spotlight = viewModel.spotlight.value[indexPath.row]
            vc = DetailsViewController(title: spotlight?.name ?? "", description: spotlight?.description ?? "", urlImage: spotlight?.bannerURL ?? "")
        }
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension HomeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == productCollectionView {
            return viewModel.products.value.count
        }
        
        if collectionView == spotlightColectionView {
            return viewModel.spotlight.value.count
        }
        return 0
    }
}

extension HomeViewController: CashComponentViewProtocol {
    func tapGesture() {
        let vc = DetailsViewController(
            title: viewModel.cash.value?.title ?? "",
            description: viewModel.cash.value?.description ?? "",
            urlImage: viewModel.cash.value?.bannerURL ?? ""
        )
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
