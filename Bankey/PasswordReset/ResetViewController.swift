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
    
    let passwordTextField = PasswordTextFieldView(placeholder: "New password");
    let confirmTextField = PasswordTextFieldView(placeholder: "Repeat new password");
    let passwordStatusView = PasswordStatusView();
//    let criteria = PasswordCriteriaView(text: "uppercase letter (A-Z)");
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
//        criteria.isCriteriaMet = false;
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
        
    }
}
//MARK: Actions
extension ResetViewController{
    @objc private func resetPressed(){
        
    }
    @objc private func backPressed(){
        delegate?.goToLogin();
    }
}
