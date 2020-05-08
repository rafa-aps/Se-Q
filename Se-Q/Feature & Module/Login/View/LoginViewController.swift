//
//  LoginViewController.swift
//  Se-Q
//
//  Created by rahman fad on 06/05/20.
//  Copyright © 2020 rahman fad. All rights reserved.
//

import UIKit
import Toast_Swift
import RxSwift
import RxCocoa
import GoogleSignIn


class LoginViewController: UIViewController {
    
    private let viewModel: LoginViewModel
    private let router: LoginRouter
    private let disposeBag = DisposeBag()
    
    init(viewModel: LoginViewModel, router: LoginRouter) {
        self.viewModel = viewModel
        self.router = router
        super.init(nibName: "LoginViewController", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var usernameView: TextFieldView!
    @IBOutlet weak var passwordView: TextFieldView!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var facebookButton: UIButton!
    @IBOutlet weak var googleButton: UIButton!
    @IBOutlet weak var rememberMeButton: UIButton!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupRememberMeButton()
        setupGoogleSignIn()
        setupFacebookLogin()
    }
    
    private func setupView(){
        facebookButton.backgroundColor = UIColor(red: 59/255.0, green: 89/255.0, blue: 152/255.0, alpha: 1.0)
        facebookButton.tintColor = .white
        facebookButton.layer.cornerRadius = 4.0
        
        googleButton.backgroundColor = UIColor(red: 23/255.0, green: 107/255.0, blue: 239/255.0, alpha: 1.0)
        googleButton.tintColor = .white
        googleButton.layer.cornerRadius = 4.0
        
        loginButton.tintColor = .white
        loginButton.backgroundColor = UIColor(red: 66/255.0, green: 66/255.0, blue: 66/255.0, alpha: 1.0)
        loginButton.layer.cornerRadius = 4.0
        
        usernameView.configureView(titleString: "Username", errorString: "Please input username", typeView: .default)
        passwordView.configureView(titleString: "Password", errorString: "Please input password", typeView: .password)
    }
    
    private func isRemeberButtonActive(isActive: Bool){
         rememberMeButton.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        if isActive {
            rememberMeButton.setImage(UIImage(named: "checkbox"), for: .normal)
        } else {
            rememberMeButton.setImage(UIImage(named: "uncheckbox"), for: .normal)
        }
    }
    
    private func setupGoogleSignIn() {
        viewModel.statusGoogleLogin.observeOn(MainScheduler.instance).subscribe { (status) in
            switch status.element {
            case .success:
                self.router.navToHome()
            case .failure(let message):
                self.view.makeToast(message)
            case .none:
                return
            }
        }.disposed(by: disposeBag)
    }
    
    private func setupFacebookLogin() {
        viewModel.statusFacebookLogin.observeOn(MainScheduler.instance).subscribe { (status) in
            switch status.element {
            case .success:
                self.router.navToHome()
            case .failure(let message):
                self.view.makeToast(message)
            case .none:
                return
            }
        }
        .disposed(by: disposeBag)
    }

    
    private func setupRememberMeButton(){
        rememberMeButton.rx.tap.bind {
            self.viewModel.rememberButtonPush()
        }.disposed(by: self.disposeBag)
        
        viewModel.rememberButton
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] (isActive) in
                guard let weakSelf = self else {return}
                weakSelf.isRemeberButtonActive(isActive: isActive)
            }, onError: nil, onCompleted: nil, onDisposed: nil)
            .disposed(by: self.disposeBag)
    }
    
    @IBAction func loginButtonDidPush(_ sender: UIButton) {
        if usernameView.isValid() && passwordView.isValid() {
            router.navToHome()
        }
    }
    
    @IBAction func facebookButtonDidPush(_ sender: UIButton) {
        viewModel.facebookLogin(viewController: self)
    }
    
    @IBAction func googleButtonDidPush(_ sender: UIButton) {
        viewModel.googleSignIn(viewController: self)
    }
    
}
