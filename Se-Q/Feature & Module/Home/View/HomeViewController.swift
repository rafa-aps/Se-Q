//
//  HomeViewController.swift
//  Se-Q
//
//  Created by rahman fad on 06/05/20.
//  Copyright © 2020 rahman fad. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import Toast_Swift

class HomeViewController: BaseViewController {
    
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var categoryCollectionView: UICollectionView!
    @IBOutlet weak var productTableView: UITableView!
    
    let viewModel: HomeViewModel
    let router: HomeRouter
    let disposeBag = DisposeBag()
    var products: [Product] = []
    
    let activityInstance = Indicator()
    
    init(viewModel: HomeViewModel, router: HomeRouter) {
        self.viewModel = viewModel
        self.router = router
        super.init(nibName: "HomeViewController", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        viewModel.getList()
        setupCollectionView()
        setupTableView()
        setupSelectedOnTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavigationBar(titleString: "Home")
    }
    
    @IBAction func searchButtonDidPush(_ sender: UIButton) {
        guard !products.isEmpty else {
            self.view.makeToast("Product is Empty, Please Check Your Connection and Reload Again")
            return
        }
        let searchView = SearchBuilder.viewController(products: products)
        navigationController?.pushViewController(searchView, animated: true)
    }
    
    private func setupView(){
        likeButton.setImage(UIImage(named: "like"), for: .normal)
        
        categoryCollectionView.register(ProductCategoryCollectionViewCell.nib(), forCellWithReuseIdentifier: ProductCategoryCollectionViewCell.reuseIdentifier)
        productTableView.register(ProductListBottomTitleTableViewCell.nib(), forCellReuseIdentifier: ProductListBottomTitleTableViewCell.reuseIdentifier)
        
        viewModel.product.subscribe { [weak self] (products) in
            guard let weakSelf = self else {return}
            weakSelf.products = products.element ?? []
        }.disposed(by: disposeBag)
    }
    
    private func setupCollectionView(){
        viewModel.category.bind(to: categoryCollectionView.rx.items(cellIdentifier: ProductCategoryCollectionViewCell.reuseIdentifier, cellType: ProductCategoryCollectionViewCell.self)){ (row, model, cell) in
            
            cell.titleLabel.text = model.name
            if let url = URL(string: model.imageUrl ?? "") {
                cell.titleImageView.load(url: url)
            }
            
        }.disposed(by: disposeBag)
    }
    
    private func setupTableView(){
        viewModel.product.bind(to: productTableView.rx.items(cellIdentifier: ProductListBottomTitleTableViewCell.reuseIdentifier, cellType: ProductListBottomTitleTableViewCell.self)){ (row, model, cell) in
            
            cell.titleLabel.text = model.title
            if let url = URL(string: model.imageUrl ?? "") {
                cell.titleImageView.load(url: url)
            }
            
            let isLike = model.loved == 0 ? false : true
            
            if isLike {
                cell.likeButton.setImage(UIImage(named: "like"), for: .normal)
            } else {
                cell.likeButton.setImage(UIImage(named: "unlike"), for: .normal)
            }
            
        }.disposed(by: disposeBag)
    }
    
    private func setupSelectedOnTableView(){
        productTableView.rx.modelSelected(Product.self).subscribe { [weak self] model in
            guard let weakSelf = self else { return }
            guard let model = model.element else { return }
            weakSelf.router.navToDetailProduct(product: model)
        }.disposed(by: disposeBag)
    }
}
