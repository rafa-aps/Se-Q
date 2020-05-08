//
//  ProductDetailViewController.swift
//  Se-Q
//
//  Created by rahman fad on 07/05/20.
//  Copyright © 2020 rahman fad. All rights reserved.
//

import Toast_Swift
import UIKit
import RxSwift
import RxCocoa

class ProductDetailViewController: BaseViewController {
    
    private let viewModel: ProductDetailViewModel
    private let router: ProductDetailRouter
    private let disposeBag = DisposeBag()
    
    init(viewModel: ProductDetailViewModel, router: ProductDetailRouter) {
        self.viewModel = viewModel
        self.router = router
        super.init(nibName: "ProductDetailViewController", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @IBOutlet weak private var productImageView: UIImageView!
    @IBOutlet weak private var likeButton: UIButton!
    @IBOutlet weak private var titleLabel: UILabel!
    @IBOutlet weak private var descriptionLabel: UILabel!
    @IBOutlet weak private var buyButton: UIButton!
    @IBOutlet weak private var priceLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupProduct()
        setupLikeButton()
        setupBuy()
        viewModel.getDetail()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavigationBar(leftButton: true, rightButton: true, titleString: "Detail Product")
    }
    
    private func setupView() {
        buyButton.layer.cornerRadius = 4.0
        likeButton.setImage(UIImage(named: "like"), for: .normal)
    }
    
    private func likeButtonActive(isActive: Bool) {
        if isActive {
            likeButton.setImage(UIImage(named: "like"), for: .normal)
        } else {
            likeButton.setImage(UIImage(named: "unlike"), for: .normal)
        }
    }
    
    private func setupProduct() {
        viewModel.productPubSub.bind { product in
            if let url = URL.init(string: product.imageUrl ?? "") {
                self.productImageView.load(url: url)
            }
            
            self.titleLabel.text = product.title
            self.descriptionLabel.text = product.description
            self.priceLabel.text = product.price
            let productLoved = product.loved == 0 ? false : true
            self.likeButtonActive(isActive: productLoved)
        }.disposed(by: disposeBag)
    }
    
    private func setupLikeButton() {
        likeButton.rx.tap.bind {
            self.viewModel.likeButtonPush()
        }.disposed(by: disposeBag)
        
        viewModel.likeButton.observeOn(MainScheduler.instance).subscribe { (isActive) in
            self.likeButtonActive(isActive: isActive.element ?? false)
        }.disposed(by: disposeBag)
    }
    
    private func setupBuy() {
        viewModel.canBuyNow.subscribe { (success) in
            if success.element ?? true {
                self.view.makeToast("Product in cart: Successfull")
                self.router.navToPurchaseHistory()
            } else {
                self.presentPurchaseAlert()
            }
        }.disposed(by: disposeBag)
    }
    
    private func presentPurchaseAlert() {
        let alert = UIAlertController.init(title: "", message: "Produk already set", preferredStyle: .alert)
        let cancelAction = UIAlertAction.init(title: "Cancel", style: .cancel, handler: nil)
        let historyAction = UIAlertAction.init(title: "History", style: .destructive) { (alert) in
            self.router.navToPurchaseHistory()
        }
        alert.addAction(cancelAction)
        alert.addAction(historyAction)
        navigationController?.present(alert, animated: true, completion: nil)
    }
    
    override func leftBarButtonDidPush() {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func buyButtonDidPush(_ sender: UIButton) {
        viewModel.saveToHistory()
    }
    
}
