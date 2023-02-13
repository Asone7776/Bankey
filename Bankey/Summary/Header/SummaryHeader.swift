//
//  SummaryHeader.swift
//  Bankey
//
//  Created by Arthur Obichkin on 10/02/23.
//

import UIKit

class SummaryHeader: UIView {
    
    let horizontalStack: UIStackView = {
        let stack = UIStackView();
        stack.axis = .horizontal;
        stack.distribution = .equalSpacing;
        stack.translatesAutoresizingMaskIntoConstraints = false;
        return stack;
    }();
    let verticalStack: UIStackView = {
        let stack = UIStackView();
        stack.axis = .vertical;
        stack.distribution = .equalSpacing;
        stack.translatesAutoresizingMaskIntoConstraints = false;
        stack.setContentHuggingPriority(UILayoutPriority.defaultHigh, for:.horizontal)
        return stack;
    }();
    let bankeyLabel: UILabel = {
        let label = UILabel();
        label.text = "Bankey";
        label.textColor = .label;
        label.font = UIFont.boldSystemFont(ofSize: 25);
        label.translatesAutoresizingMaskIntoConstraints = false;
        return label;
    }();
    
    let greetingsLabel: UILabel = {
        let label = UILabel();
        label.text = "Hello!";
        label.textColor = .label;
        label.font = UIFont.boldSystemFont(ofSize: 20);
        label.translatesAutoresizingMaskIntoConstraints = false;
        return label;
    }();
    
    var nameLabel: UILabel = {
        let label = UILabel();
        label.text = "-";
        label.textColor = .label;
        label.translatesAutoresizingMaskIntoConstraints = false;
        label.font = UIFont.boldSystemFont(ofSize: 18);
        return label;
    }();
    
    let dateLabel: UILabel = {
        let label = UILabel();
        let date = Date();
        let df = DateFormatter();
        df.dateFormat = "dd-MM-yyyy";
        label.text = df.string(from: date);
        label.textColor = .label;
        label.translatesAutoresizingMaskIntoConstraints = false;
        label.font = UIFont.boldSystemFont(ofSize: 16 );
        return label;
    }();
    
    let image: UIImageView = {
        let imageView = UIImageView();
        imageView.image = UIImage(systemName: "sun.max.fill");
        imageView.tintColor = .systemYellow;
        imageView.contentMode = .scaleAspectFit;
        imageView.translatesAutoresizingMaskIntoConstraints = false;
        imageView.setContentHuggingPriority(UILayoutPriority.defaultLow, for:.horizontal)
        return imageView;
    }();
    
    
    override init(frame: CGRect) {
        super.init(frame: frame);
        style();
        layout();
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder);
        style();
        layout();
    }
}

extension SummaryHeader{
    private func style(){
        backgroundColor = appColor;
    }
    
    private func layout(){
        verticalStack.addArrangedSubview(bankeyLabel);
        verticalStack.addArrangedSubview(greetingsLabel);
        verticalStack.addArrangedSubview(nameLabel);
        verticalStack.addArrangedSubview(dateLabel);
        horizontalStack.addArrangedSubview(verticalStack);
        horizontalStack.addArrangedSubview(image);
        addSubview(horizontalStack);
        NSLayoutConstraint.activate([
            horizontalStack.topAnchor.constraint(equalToSystemSpacingBelow: topAnchor, multiplier: 2),
            horizontalStack.leadingAnchor.constraint(equalToSystemSpacingAfter: leadingAnchor, multiplier: 2),
            trailingAnchor.constraint(equalToSystemSpacingAfter: horizontalStack.trailingAnchor,multiplier: 2),
            bottomAnchor.constraint(equalToSystemSpacingBelow: horizontalStack.bottomAnchor, multiplier: 2),
            image.widthAnchor.constraint(equalToConstant: 100),
        ])
    }
}
