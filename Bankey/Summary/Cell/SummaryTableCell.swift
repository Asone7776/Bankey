//
//  SummaryTableCell.swift
//  Bankey
//
//  Created by Uzkassa on 10/02/23.
//

import UIKit

class SummaryTableCell: UITableViewCell{
    
    static let cellHeight: CGFloat = 100;
    static let reuseId = "summaryCell";
    
    let typeLabel:UILabel = {
        let label = UILabel();
        label.translatesAutoresizingMaskIntoConstraints = false;
        label.font = UIFont.systemFont(ofSize: 14);
        label.text = "type text";
        return label;
    }();
    
    let underlineView:UIView = {
        let view = UIView();
        view.translatesAutoresizingMaskIntoConstraints = false;
        view.backgroundColor = appColor;
        return view;
    }();
    
    let nameLabel:UILabel = {
        let label = UILabel();
        label.translatesAutoresizingMaskIntoConstraints = false;
        label.font = UIFont.systemFont(ofSize: 16);
        label.text = "name text";
        return label;
    }();
    
    let balanceStackView:UIStackView = {
        let stack = UIStackView();
        stack.translatesAutoresizingMaskIntoConstraints = false;
        stack.axis = .vertical;
//        stack.spacing = 20;
        stack.distribution = .fillEqually
        return stack;
    }();
    
    let currentBalanceLabel: UILabel = {
        let label = UILabel();
        label.translatesAutoresizingMaskIntoConstraints = false;
        label.font = UIFont.systemFont(ofSize: 14);
        label.text = "Current balance";
        return label;
    }();
    
    let amountLabel: UILabel = {
        let label = UILabel();
        label.translatesAutoresizingMaskIntoConstraints = false;
        label.font = UIFont.systemFont(ofSize: 14);
        label.text = "17$";
        return label;
    }();
    
    let chevronImage: UIImageView = {
        let imageView = UIImageView();
        imageView.translatesAutoresizingMaskIntoConstraints = false;
        let image = UIImage(systemName: "chevron.right");
        imageView.contentMode = .scaleAspectFit;
        imageView.image = image;
        imageView.tintColor = appColor;
        return imageView;
    }();

    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier);
        self.style();
        self.setup();
        self.layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
extension SummaryTableCell{
    private func style(){
        
    }
    
    private func setup(){
        balanceStackView.addArrangedSubview(currentBalanceLabel);
        balanceStackView.addArrangedSubview(amountLabel);
    }
    
    private func layout(){
        addSubview(typeLabel);
        addSubview(underlineView);
        addSubview(nameLabel);
        addSubview(balanceStackView);
        addSubview(chevronImage);
        NSLayoutConstraint.activate([
            typeLabel.topAnchor.constraint(equalToSystemSpacingBelow: topAnchor, multiplier: 1),
            typeLabel.leadingAnchor.constraint(equalToSystemSpacingAfter: leadingAnchor, multiplier: 2),
            
            underlineView.topAnchor.constraint(equalToSystemSpacingBelow: typeLabel.bottomAnchor, multiplier: 1),
            underlineView.leadingAnchor.constraint(equalToSystemSpacingAfter: leadingAnchor, multiplier: 2),
            underlineView.heightAnchor.constraint(equalToConstant: 4),
            underlineView.widthAnchor.constraint(equalToConstant: 60),
            
            nameLabel.topAnchor.constraint(equalToSystemSpacingBelow: underlineView.bottomAnchor, multiplier: 2),
            nameLabel.leadingAnchor.constraint(equalToSystemSpacingAfter: leadingAnchor, multiplier: 2),
            
            trailingAnchor.constraint(equalToSystemSpacingAfter: chevronImage.trailingAnchor, multiplier: 1),
            chevronImage.centerYAnchor.constraint(equalTo: centerYAnchor),
            chevronImage.widthAnchor.constraint(equalToConstant: 32),
            
            balanceStackView.topAnchor.constraint(equalToSystemSpacingBelow:topAnchor, multiplier: 1),
            chevronImage.leadingAnchor.constraint(equalTo: balanceStackView.trailingAnchor, constant: 8),
            bottomAnchor.constraint(equalToSystemSpacingBelow: balanceStackView.bottomAnchor, multiplier: 1)
        ]);
    }
}
