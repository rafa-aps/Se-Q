//
//  TextFieldView.swift
//  Se-Q
//
//  Created by rahman fad on 06/05/20.
//  Copyright © 2020 rahman fad. All rights reserved.
//

import UIKit

class TextFieldView: UIView {
    
    enum StateButton: Int {
        case show = 1
        case hide = 0
    }
    
    enum TypeView {
        case password
        case `default`
    }
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var errorLabel: UILabel!
    
    var errorString: String?
    var typeView: TypeView?
    private let rightButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: ""), for: .normal)
        button.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        button.addTarget(self, action: #selector(showCharacter(_:)), for: .touchUpInside)
        button.tag = StateButton.hide.rawValue
        button.sizeToFit()
        return button
    }()
    
    // MARK: - Responder
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.commonInit()
    }
    
    // MARK: - Setup
    private func commonInit() {
        let view = Bundle.main.loadNibNamed("TextFieldView", owner: self, options: nil)?.first as! UIView
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        view.fillSuperView()
    }
    
    func configureView(titleString: String,
                       placeholder: String? = nil,
                       errorString: String,
                       typeView: TypeView){
        titleLabel.text = titleString
        textField.placeholder = placeholder
        self.errorString = errorString
        self.typeView = typeView
        
        switch typeView {
        case .password:
            textField.isSecureTextEntry = true
            textField.rightView = rightButton
            textField.rightViewMode = .always
        case .default:
            return
        }
    }
    
    @objc private func showCharacter(_ sender: UIButton){
        if sender.tag == StateButton.hide.rawValue {
            sender.tag = StateButton.show.rawValue
            sender.setImage(UIImage(named: ""), for: .normal)
            textField.isSecureTextEntry = false
        } else {
            sender.tag = StateButton.show.rawValue
            sender.setImage(UIImage(named: ""), for: .normal)
            textField.isSecureTextEntry = true
        }
    }
    
    func isValid(text: String? = nil) -> Bool{
        errorLabel.text = ""
        if textField.text?.count == 0 {
            errorLabel.text = errorString
            return false
        }
        return true
    }

}

extension TextFieldView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
