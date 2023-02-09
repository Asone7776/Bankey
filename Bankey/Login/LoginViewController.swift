//
//  ViewController.swift
//  Bankey
//
//  Created by Arthur Obichkin on 08/02/23.
//

import UIKit

protocol LogoutDelegate: AnyObject{
    func didLogout()
}

protocol LoginViewControllerDelegate: AnyObject{
    func didLogin()
}
class LoginViewController: UIViewController {
    
    let loginView = LoginView();
    weak var delegate:LoginViewControllerDelegate?
    var username: String? {
        return loginView.loginTextField.text;
    }
    
    var password: String? {
        return loginView.passwordTextField.text;
    }
    
    let titleLabel:UILabel = {
        let title = UILabel();
        title.translatesAutoresizingMaskIntoConstraints = false
        title.textAlignment = .center
        title.font = UIFont.preferredFont(forTextStyle: .largeTitle)
        title.adjustsFontForContentSizeCategory = true
        title.text = "Bankey"
        return title;
    }();
    
    let subTitleLabel:UILabel = {
        let title = UILabel();
        title.translatesAutoresizingMaskIntoConstraints = false
        title.textAlignment = .center
        title.font = UIFont.preferredFont(forTextStyle: .title3)
        title.adjustsFontForContentSizeCategory = true
        title.numberOfLines = 0
        title.text = "Your premium source for all things banking!"
        return title;
    }();
    
    let errorLabel:UILabel = {
        let label = UILabel();
        label.translatesAutoresizingMaskIntoConstraints = false;
        label.numberOfLines = 0;
        label.text = "Error";
        label.textAlignment = .center;
        label.isHidden = true;
        label.textColor = .systemRed;
        return label;
    }();
    lazy var signInButton: LoadedButton = {
        let button = LoadedButton();
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
}
//MARK: Actions
extension LoginViewController{
    @objc func signInPressed() {
        errorLabel.isHidden = true;
        signInButton.isLoading = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 2){
            self.login();
        }
    }
    private func login(){
        guard let username = username, let password = password else {
            assertionFailure("Username or password should never be empty");
            return;
        }
        if username.isEmpty || password.isEmpty{
            configureView(withMessage: "Username / Password cannot be blank");
            return;
        }
        if username == "Kevin" && password == "Welcome"{
            signInButton.isLoading = false;
            delegate?.didLogin();
        }else{
            configureView(withMessage: "Incorrect Username / Password");
        }
    }
    private func configureView(withMessage message:String){
        errorLabel.isHidden = false;
        errorLabel.text = message;
        signInButton.isLoading = false;
    }
}
//MARK: Style and Layout
extension LoginViewController{
    func style(){
        
    }
    
    func layout(){
        view.addSubview(titleLabel);
        view.addSubview(subTitleLabel);
        view.addSubview(loginView);
        view.addSubview(signInButton);
        view.addSubview(errorLabel);
        NSLayoutConstraint.activate([
            loginView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            loginView.leadingAnchor.constraint(equalToSystemSpacingAfter: view.safeAreaLayoutGuide.leadingAnchor, multiplier: 1),
//            loginView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -8),
            view.safeAreaLayoutGuide.trailingAnchor.constraint(equalToSystemSpacingAfter: loginView.trailingAnchor, multiplier: 1),
//            loginView.heightAnchor.constraint(equalToConstant: 200)
            signInButton.topAnchor.constraint(equalToSystemSpacingBelow: loginView.bottomAnchor, multiplier: 2),
            signInButton.leadingAnchor.constraint(equalToSystemSpacingAfter: view.safeAreaLayoutGuide.leadingAnchor, multiplier: 1),
            view.safeAreaLayoutGuide.trailingAnchor.constraint(equalToSystemSpacingAfter: signInButton.trailingAnchor, multiplier: 1),
            
            errorLabel.topAnchor.constraint(equalToSystemSpacingBelow: signInButton.bottomAnchor, multiplier: 2),
            errorLabel.leadingAnchor.constraint(equalToSystemSpacingAfter: view.safeAreaLayoutGuide.leadingAnchor, multiplier: 1),
            view.safeAreaLayoutGuide.trailingAnchor.constraint(equalToSystemSpacingAfter: errorLabel.trailingAnchor, multiplier: 1),
            
            loginView.topAnchor.constraint(equalToSystemSpacingBelow: subTitleLabel.bottomAnchor, multiplier: 3),
            subTitleLabel.leadingAnchor.constraint(equalTo: loginView.leadingAnchor),
            subTitleLabel.trailingAnchor.constraint(equalTo: loginView.trailingAnchor),
            
            subTitleLabel.topAnchor.constraint(equalToSystemSpacingBelow: titleLabel.bottomAnchor, multiplier: 3),
            titleLabel.leadingAnchor.constraint(equalTo: loginView.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: loginView.trailingAnchor),
        ])
    }
}


