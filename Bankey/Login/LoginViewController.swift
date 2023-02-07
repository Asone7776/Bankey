//
//  ViewController.swift
//  Bankey
//
//  Created by Arthur Obichkin on 08/02/23.
//

import UIKit

class LoginViewController: UIViewController {
    
    let loginView = LoginView();
    lazy var signInButton:UIButton = {
        let button = UIButton();
        button.configuration = .filled();
        button.layer.cornerRadius = 5;
        button.clipsToBounds = true;
        button.translatesAutoresizingMaskIntoConstraints = false;
        button.setTitle("Sign in", for: .normal);
        button.addTarget(self, action: #selector(signInPressed), for: .touchUpInside);
        return button;
    }();
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground;
        style();
        layout();
    }
    @objc func signInPressed() {
        print("Sign in");
    }
}

extension LoginViewController{
    func style(){
        
    }
    
    func layout(){
        view.addSubview(loginView);
        view.addSubview(signInButton)
        NSLayoutConstraint.activate([
            loginView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            loginView.leadingAnchor.constraint(equalToSystemSpacingAfter: view.safeAreaLayoutGuide.leadingAnchor, multiplier: 1),
//            loginView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -8),
            view.safeAreaLayoutGuide.trailingAnchor.constraint(equalToSystemSpacingAfter: loginView.trailingAnchor, multiplier: 1),
//            loginView.heightAnchor.constraint(equalToConstant: 200)
            signInButton.topAnchor.constraint(equalToSystemSpacingBelow: loginView.bottomAnchor, multiplier: 2),
            signInButton.leadingAnchor.constraint(equalToSystemSpacingAfter: view.safeAreaLayoutGuide.leadingAnchor, multiplier: 1),
            view.safeAreaLayoutGuide.trailingAnchor.constraint(equalToSystemSpacingAfter: signInButton.trailingAnchor, multiplier: 1),
        ])
    }
}


