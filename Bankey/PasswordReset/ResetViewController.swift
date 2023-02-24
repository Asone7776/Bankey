//
//  ResetViewController.swift
//  Bankey
//
//  Created by Arthur Obichkin on 21/02/23.
//

import UIKit

protocol ResetViewControllerDelegate{
    func goToLogin()
}


class ResetViewController: UIViewController {
 
    typealias customValidation = PasswordTextField.CustomValidation?;
    var verticalStack: UIStackView = {
        let stack = UIStackView();
        stack.spacing = 4;
        stack.axis = .vertical;
        stack.translatesAutoresizingMaskIntoConstraints = false;
        return stack;
    }();
    let label:UILabel = {
        let view = UILabel();
        view.text = "test";
        view.translatesAutoresizingMaskIntoConstraints = false;
        return view;
    }();
    
    lazy var actionButton: UIButton = {
        let button = UIButton(configuration: .filled());
        button.setTitle("Reset", for: .normal);
        button.addTarget(self, action: #selector(resetPressed), for: .touchUpInside);
        return button;
    }();
    
    let passwordTextField = PasswordTextField(placeholder: "New password");
    let confirmTextField = PasswordTextField(placeholder: "Repeat new password");
    let passwordStatusView = PasswordStatusView();
    var delegate:ResetViewControllerDelegate?;
    lazy var backButton:UIButton = {
        let button = UIButton();
        button.configuration = .filled();
        button.setTitle("To Login", for: .normal);
        button.translatesAutoresizingMaskIntoConstraints = false;
        button.addTarget(self, action: #selector(backPressed), for: .touchUpInside);
        return button
    }();


    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground;
        passwordTextField.delegate = self;
        layout();
        setup();
    }
    
}

extension ResetViewController{
    private func layout(){
        view.addSubview(backButton);
        
        verticalStack.addArrangedSubview(passwordTextField);
        verticalStack.addArrangedSubview(passwordStatusView);
        verticalStack.addArrangedSubview(confirmTextField);
        verticalStack.addArrangedSubview(actionButton);
        view.addSubview(verticalStack)
        NSLayoutConstraint.activate([
            backButton.topAnchor.constraint(equalToSystemSpacingBelow: view.safeAreaLayoutGuide.topAnchor, multiplier: 1),
            backButton.leadingAnchor.constraint(equalToSystemSpacingAfter: view.safeAreaLayoutGuide.leadingAnchor, multiplier: 1),
            verticalStack.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            verticalStack.leadingAnchor.constraint(equalToSystemSpacingAfter: view.safeAreaLayoutGuide.leadingAnchor, multiplier: 2),
            view.safeAreaLayoutGuide.trailingAnchor.constraint(equalToSystemSpacingAfter: verticalStack.trailingAnchor, multiplier: 2)
        ]);
    }
    private func setup(){
        setupKeyboardDismissGesture();
        setupNewPassword();
    }
    private func setupNewPassword(){
        let newPasswordValidation: customValidation = {text in
            guard let text = text, !text.isEmpty else{
                self.passwordStatusView.reset()
                return (false,"Enter your password");
            }
            return (true,"");
        }
        passwordTextField.customValidation = newPasswordValidation;
    }
}
//MARK: Actions
extension ResetViewController{
    private func setupKeyboardDismissGesture(){
        let dissmissKeyboardTap = UITapGestureRecognizer(target: self, action: #selector(viewTapped));
        view.addGestureRecognizer(dissmissKeyboardTap);
    }
    @objc private func viewTapped(){
        view.endEditing(true);
    }
    @objc private func resetPressed(){
        
    }
    @objc private func backPressed(){
        delegate?.goToLogin();
    }
}
extension ResetViewController: PasswordTextFieldViewDelegate{
    func editingDidEnd(_ sender: PasswordTextField) {
        if sender === passwordTextField{
            _ = passwordTextField.validate()
        }
    }
    
    func editingChanged(_ sender: PasswordTextField) {
        if sender === passwordTextField{
            if let safeText = sender.textField.text{
                passwordStatusView.updateDisplay(safeText);
            }
        }
    }
}
