//
//  DummyViewController.swift
//  Bankey
//
//  Created by Arthur Obichkin on 10/02/23.
//

import UIKit


class DummyViewController: UIViewController {
    let stack:UIStackView = {
        let view = UIStackView();
        view.axis = .vertical;
        view.spacing = 10;
        view.translatesAutoresizingMaskIntoConstraints = false;
        return view;
    }();
    
    let label:UILabel = {
        let view = UILabel();
        view.text = "Welcome";
        view.textAlignment = .center
        view.font = UIFont.boldSystemFont(ofSize: 18);
        view.translatesAutoresizingMaskIntoConstraints = false;
        return view;
    }();
    
    lazy var button:UIButton = {
        let view = UIButton();
        view.configuration = .filled();
        view.setTitle("Logout", for: .normal);
        view.translatesAutoresizingMaskIntoConstraints = false;
        view.addTarget(self, action: #selector(logout), for: .primaryActionTriggered);
        return view;
    }();
    weak var delegate:LogoutDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad();
        style()
        layout()
    }
    @objc func logout(){
        delegate?.didLogout();
    }
}

extension DummyViewController {
    func style() {
        view.backgroundColor = .systemBackground;
    }
    
    func layout() {
        view.addSubview(stack);
        stack.addArrangedSubview(label);
        stack.addArrangedSubview(button);
        
        NSLayoutConstraint.activate([
            stack.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stack.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5)
        ]);
    }
}

