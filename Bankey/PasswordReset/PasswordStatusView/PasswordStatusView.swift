//
//  PasswordStatusView.swift
//  Bankey
//
//  Created by Arthur Obichkin on 22/02/23.
//

import UIKit

class PasswordStatusView:UIView{
    let stackView: UIStackView = {
        let stack = UIStackView();
        stack.axis = .vertical;
        stack.spacing = 8;
        stack.distribution = .equalCentering;
        stack.translatesAutoresizingMaskIntoConstraints = false;
        return stack;
    }();
    
    lazy var criteriaLabel:UILabel = {
        let label = UILabel();
        label.numberOfLines = 0;
        label.lineBreakMode = .byWordWrapping;
        label.attributedText = makeCriteriaMessage();
        return label;
    }();
    
    let lengthCriteriaView = PasswordCriteriaView(text: "8-32 characters (no spaces)")
    let uppercaseCriteriaView = PasswordCriteriaView(text: "uppercase letter (A-Z)")
    let lowerCaseCriteriaView = PasswordCriteriaView(text: "lowercase (a-z)")
    let digitCriteriaView = PasswordCriteriaView(text: "digit (0-9)")
    let specialCharacterCriteriaView = PasswordCriteriaView(text: "special character (e.g. !@#$%^)")
    
    override init(frame: CGRect) {
        super.init(frame: frame);
        style();
        layout();
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
extension PasswordStatusView{
    private func style(){
        layer.cornerRadius = 5;
        clipsToBounds = true;
        translatesAutoresizingMaskIntoConstraints = false;
        backgroundColor = .tertiarySystemFill;
    }
    private func layout(){
        stackView.addArrangedSubview(lengthCriteriaView)
        stackView.addArrangedSubview(criteriaLabel)
        stackView.addArrangedSubview(uppercaseCriteriaView)
        stackView.addArrangedSubview(lowerCaseCriteriaView)
        stackView.addArrangedSubview(digitCriteriaView)
        stackView.addArrangedSubview(specialCharacterCriteriaView)
        addSubview(stackView);
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalToSystemSpacingAfter: leadingAnchor, multiplier: 1),
            stackView.topAnchor.constraint(equalToSystemSpacingBelow: topAnchor, multiplier: 1),
            trailingAnchor.constraint(equalToSystemSpacingAfter: stackView.trailingAnchor, multiplier: 1),
            bottomAnchor.constraint(equalToSystemSpacingBelow: stackView.bottomAnchor, multiplier: 1)
        ]);
    }
    private func makeCriteriaMessage() -> NSAttributedString {
        var plainTextAttributes = [NSAttributedString.Key: AnyObject]()
        plainTextAttributes[.font] = UIFont.preferredFont(forTextStyle: .subheadline)
        plainTextAttributes[.foregroundColor] = UIColor.secondaryLabel
        
        var boldTextAttributes = [NSAttributedString.Key: AnyObject]()
        boldTextAttributes[.foregroundColor] = UIColor.label
        boldTextAttributes[.font] = UIFont.preferredFont(forTextStyle: .subheadline)

        let attrText = NSMutableAttributedString(string: "Use at least ", attributes: plainTextAttributes)
        attrText.append(NSAttributedString(string: "3 of these 4 ", attributes: boldTextAttributes))
        attrText.append(NSAttributedString(string: "criteria when setting your password:", attributes: plainTextAttributes))

        return attrText
    }
}
