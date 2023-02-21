//
//  LoadedButton.swift
//  Bankey
//
//  Created by Arthur Obichkin on 09/02/23.
//

import UIKit

class LoadedButton: UIButton{
    let activitiIndicator = UIActivityIndicatorView();
    
    var isLoading = false {
        didSet{
            updateView();
        }
    }
    override init(frame: CGRect) {
        super.init(frame: frame);
        setupView();
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func setupView(){
        activitiIndicator.hidesWhenStopped = true;
        activitiIndicator.color = .label;
        activitiIndicator.style = .medium;
        activitiIndicator.translatesAutoresizingMaskIntoConstraints = false;
        addSubview(activitiIndicator);
        NSLayoutConstraint.activate([
            activitiIndicator.centerXAnchor.constraint(equalTo: centerXAnchor),
            activitiIndicator.centerYAnchor.constraint(equalTo: centerYAnchor)
        ]);
    }
    
    private func updateView(){
        if isLoading{
            imageView?.alpha = 0;
            titleLabel?.alpha = 0;
            activitiIndicator.startAnimating();
            isEnabled = false;
        }else{
            activitiIndicator.stopAnimating();
            imageView?.alpha = 1;
            titleLabel?.alpha = 1;
            isEnabled = true;
        }
    }
}
