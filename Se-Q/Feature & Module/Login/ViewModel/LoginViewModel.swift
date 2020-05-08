//
//  LoginViewModel.swift
//  Se-Q
//
//  Created by rahman fad on 06/05/20.
//  Copyright © 2020 rahman fad. All rights reserved.
//

import Foundation
import RxSwift
import FBSDKLoginKit
import GoogleSignIn

class LoginViewModel: NSObject {
    public enum StatusLogin {
        case success
        case failure(String)
    }
    
    let statusFacebookLogin: PublishSubject<StatusLogin> = PublishSubject()
    let statusGoogleLogin: PublishSubject<StatusLogin> = PublishSubject()
    let rememberButton: PublishSubject<Bool> = PublishSubject()
    
    var isRememberActive = false
    
    override init() {
        super.init()
        GIDSignIn.sharedInstance()?.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func facebookLogin(viewController: UIViewController) {
        let login = LoginManager()
        login.logOut()
        login.logIn(permissions: ["public_profile", "email"], from: viewController) { (result, error) in
            if error != nil || (result?.isCancelled ?? true) {
                self.statusFacebookLogin.onNext(.failure("Something Happen on Login"))
                return
            }
            
            self.statusFacebookLogin.onNext(.success)
        }
    }
    
    func googleSignIn(viewController: UIViewController) {
        GIDSignIn.sharedInstance()?.presentingViewController = viewController
        GIDSignIn.sharedInstance()?.signOut()
        GIDSignIn.sharedInstance()?.signIn()
        GIDSignIn.sharedInstance().shouldFetchBasicProfile = true
        GIDSignIn.sharedInstance().scopes = ["profile", "email"]
    }
    
    func rememberButtonPush() {
        rememberButton.onNext(!isRememberActive)
        isRememberActive = !isRememberActive
    }
}

extension LoginViewModel: GIDSignInDelegate {
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if error != nil {
            statusGoogleLogin.onNext(.failure("Something Happen on Sign In"))
            return
        }
        
        statusGoogleLogin.onNext(.success)
    }
}

