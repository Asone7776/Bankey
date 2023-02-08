//
//  LoginView.swift
//  Bankey
//
//  Created by Arthur Obichkin on 08/02/23.
//

import UIKit

class LoginView:UIView {
    lazy var loginTextField:UITextField = {
        let textField = UITextField();
        textField.placeholder = "Username";
        textField.delegate = self;
        return textField;
    }();
    
    let divider: UIView = {
        let view = UIView();
        view.translatesAutoresizingMaskIntoConstraints = false;
        view.backgroundColor = .secondarySystemFill;
        return view;
    }();
    
    lazy var passwordTextField:UITextField = {
        let textField = UITextField();
        textField.placeholder = "Password";
        textField.delegate = self;
        textField.isSecureTextEntry = true;
        return textField;
    }();
    let stackView: UIStackView = {
        let stack = UIStackView();
        stack.axis = .vertical;
        stack.spacing = 8;
        stack.translatesAutoresizingMaskIntoConstraints = false;
        return stack;
    }();
    override init(frame: CGRect) {
        super.init(frame: frame);
        style();
        layout();
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
//    override var intrinsicContentSize: CGSize{
//        return CGSize(width: 200, height: 200);
//    }
}
extension LoginView{
    func style(){
        translatesAutoresizingMaskIntoConstraints = false;
        backgroundColor = .secondarySystemBackground;
        layer.cornerRadius = 5;
        clipsToBounds = true;
    }
    
    func layout(){
        stackView.addArrangedSubview(loginTextField);
        stackView.addArrangedSubview(divider);
        stackView.addArrangedSubview(passwordTextField);
        addSubview(stackView);
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalToSystemSpacingBelow: topAnchor, multiplier: 1),
            stackView.leadingAnchor.constraint(equalToSystemSpacingAfter: leadingAnchor, multiplier: 1),
            trailingAnchor.constraint(equalToSystemSpacingAfter: stackView.trailingAnchor, multiplier: 1),
            bottomAnchor.constraint(equalToSystemSpacingBelow: stackView.bottomAnchor, multiplier: 1),
            divider.heightAnchor.constraint(equalToConstant: 1)
        ]);
    }
}

extension LoginView: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        loginTextField.endEditing(true);
        passwordTextField.endEditing(true);
        return true;
    }
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        return true;
//        if textField.text != ""{
//            return true;
//        }else{
//            return false;
//        }
    }
}
