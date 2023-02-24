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
        verticalStack.addArrangedSubview(passwordTextField);
        verticalStack.addArrangedSubview(passwordStatusView);
        verticalStack.addArrangedSubview(confirmTextField);
        verticalStack.addArrangedSubview(actionButton);
        view.addSubview(verticalStack)
        NSLayoutConstraint.activate([
            verticalStack.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            verticalStack.leadingAnchor.constraint(equalToSystemSpacingAfter: view.safeAreaLayoutGuide.leadingAnchor, multiplier: 2),
            view.safeAreaLayoutGuide.trailingAnchor.constraint(equalToSystemSpacingAfter: verticalStack.trailingAnchor, multiplier: 2)
        ]);
    }
    private func setup(){
        setupKeyboardDismissGesture();
        setupNewPassword();
        setupConfirmPassword();

    }
    private func setupNewPassword(){
        let newPasswordValidation: customValidation = {text in
            guard let text = text, !text.isEmpty else{
                self.passwordStatusView.reset()
                return (false,"Enter your password");
            }
            
            // Valid characters
            let validChars = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789.,@:?!()$\\/#"
            
            let invalidSet = CharacterSet(charactersIn: validChars).inverted
            guard text.rangeOfCharacter(from: invalidSet) == nil else {
                self.passwordStatusView.reset()
                return (false, "Enter valid special chars (.,@:?!()$\\/#) with no spaces")
            }
            
            self.passwordStatusView.updateDisplay(text)
                  if !self.passwordStatusView.validate(text) {
                      return (false, "Your password must meet the requirements below")
                  }
            return (true,"");
        }
        
        passwordTextField.customValidation = newPasswordValidation;
    }
    private func setupConfirmPassword() {
        let confirmPasswordValidation: customValidation = { text in
            guard let text = text, !text.isEmpty else {
                return (false, "Enter your password.")
            }

            guard text == self.passwordTextField.text else {
                return (false, "Passwords do not match.")
            }

            return (true, "")
        }

        confirmTextField.customValidation = confirmPasswordValidation
        confirmTextField.delegate = self
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
            passwordStatusView.shouldResetCriteria = false
            _ = passwordTextField.validate()
        } else if sender == confirmTextField {
            _ = confirmTextField.validate()
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
