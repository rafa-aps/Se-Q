//
//  SearchViewController.swift
//  Se-Q
//
//  Created by rahman fad on 07/05/20.
//  Copyright © 2020 rahman fad. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class SearchViewController: BaseViewController {
    
    private let viewModel: SearchViewModel
    private let router: SearchRouter
    private let disposeBag = DisposeBag()
    
    init(viewModel: SearchViewModel, router: SearchRouter) {
        self.viewModel = viewModel
        self.router = router
        super.init(nibName: "SearchViewController", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var searchButton: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
      super.viewDidLoad()
      setupView()
      setupSearchBar()
      setupSelectedOnTableView()
    }
      
    override func viewWillAppear(_ animated: Bool) {
      super.viewWillAppear(animated)
      navigationController?.navigationBar.isHidden = true
      searchButton.becomeFirstResponder()
      Helper.keyboardObserver(self, selectorForKeyboardShow: #selector(keyboardWillShow(_:)), selectorForKeyboardDismiss: #selector(keyboardWillHide(_:)))
    }
      
      override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        Helper.removeKeyboardObserver(self)
      }
      
      private func setupView() {
        backButton.setImage(UIImage(named: "back"), for: .normal)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(ProductListRightTitleTableViewCell.nib(), forCellReuseIdentifier: ProductListRightTitleTableViewCell.reuseIdentifier)
      }
      
      private func setupSearchBar() {
          viewModel.productPubSub.bind(to: tableView.rx.items(cellIdentifier: ProductListRightTitleTableViewCell.reuseIdentifier, cellType: ProductListRightTitleTableViewCell.self)){ (row, product, cell) in
              if let url = URL.init(string: product.imageUrl ?? "") {
                  cell.titleImageView?.load(url: url)
              }
              cell.titleLabel.text = product.title
              cell.subtitleLabel.text = product.price
          }.disposed(by: disposeBag)
          
          viewModel.haveDataPubSub.observeOn(MainScheduler.instance).subscribe {[weak self] (success) in
              guard let weakSelf = self else {return}
              if success.element ?? false {
                weakSelf.view.makeToast("Have data")
              } else {
                  weakSelf.view.makeToast("No data")
              }
          }.disposed(by: disposeBag)
        
          searchButton.rx.text.orEmpty.subscribe {[weak self] (query) in
            guard let weakSelf = self else {return}
            weakSelf.viewModel.search(query: query.element ?? "")
          }.disposed(by: disposeBag)
        
      }
      
      private func setupSelectedOnTableView() {
          tableView.rx.modelSelected(Product.self).subscribe { [weak self] product in
              guard let weakSelf = self else {return}
              guard let product = product.element else {return}
              
              weakSelf.router.navToDetailProduct(product: product)
          }.disposed(by: disposeBag)
      }
      
      
      @IBAction func leftButtonDidPush(_ sender: UIButton) {
          navigationController?.popViewController(animated: true)
      }
      
      
      @objc private func keyboardWillShow(_ notification: Notification) {
          if let userInfo = notification.userInfo {
              if let keyboardHeight = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue.size.height {
                  tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardHeight, right: 0)
                  tableView.scrollIndicatorInsets = tableView.contentInset
              }
          }
      }
      
      @objc private func keyboardWillHide(_ notification: Notification) {
          tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
      }
      
      deinit {
          Helper.removeKeyboardObserver(self)
      }
  }
