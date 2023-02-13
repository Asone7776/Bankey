//
//  SummaryTableCell.swift
//  Bankey
//
//  Created by Uzkassa on 10/02/23.
//

import UIKit

class SummaryTableCell: UITableViewCell{
    var viewModel: SummaryModel? = nil
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
        label.numberOfLines = 0;
        label.lineBreakMode = .byWordWrapping;
        label.text = "name text";
        label.adjustsFontSizeToFitWidth = true
        return label;
    }();
    
    let balanceStackView:UIStackView = {
        let stack = UIStackView();
        stack.translatesAutoresizingMaskIntoConstraints = false;
        stack.axis = .vertical;
        stack.distribution = .fillEqually
        return stack;
    }();
    
    let currentBalanceLabel: UILabel = {
        let label = UILabel();
        label.translatesAutoresizingMaskIntoConstraints = false;
        label.font = UIFont.systemFont(ofSize: 14);
        label.text = "Current balance";
        label.adjustsFontSizeToFitWidth = true
        return label;
    }();
    
    let amountLabel: UILabel = {
        let label = UILabel();
        label.numberOfLines = 0;
        label.translatesAutoresizingMaskIntoConstraints = false;
        label.font = UIFont.systemFont(ofSize: 14);
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
        amountLabel.attributedText = makeFormattedBalance(dollars: "929,466", cents: "23")
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
            balanceStackView.leadingAnchor.constraint(equalToSystemSpacingAfter:nameLabel.trailingAnchor, multiplier: 1),
            
            chevronImage.leadingAnchor.constraint(equalTo: balanceStackView.trailingAnchor, constant: 8),
            bottomAnchor.constraint(equalToSystemSpacingBelow: balanceStackView.bottomAnchor, multiplier: 1)
        ]);
    }
    
    private func makeFormattedBalance(dollars: String, cents: String) -> NSMutableAttributedString {
        let dollarSignAttributes: [NSAttributedString.Key: Any] = [.font: UIFont.preferredFont(forTextStyle: .callout), .baselineOffset: 8]
        let dollarAttributes: [NSAttributedString.Key: Any] = [.font: UIFont.preferredFont(forTextStyle: .title1)]
        let centAttributes: [NSAttributedString.Key: Any] = [.font: UIFont.preferredFont(forTextStyle: .footnote), .baselineOffset: 8]
        
        let rootString = NSMutableAttributedString(string: "$", attributes: dollarSignAttributes)
        let dollarString = NSAttributedString(string: dollars, attributes: dollarAttributes)
        let centString = NSAttributedString(string: cents, attributes: centAttributes)
        
        rootString.append(dollarString)
        rootString.append(centString)
        
        return rootString
    }
}

extension SummaryTableCell{
    func configure(with vm: SummaryModel){
        typeLabel.text = vm.accountType.rawValue;
        nameLabel.text = vm.accountName;
        amountLabel.attributedText = vm.balanceAsAttributedString;
        switch vm.accountType{
            case .Banking:
            underlineView.backgroundColor = appColor;
            currentBalanceLabel.text = "Current balance";
                break;
            case .CreditCard:
            underlineView.backgroundColor = .systemOrange;
            currentBalanceLabel.text = "Current balance";
                break;
            case .Investment:
            underlineView.backgroundColor = .systemPurple;
            currentBalanceLabel.text = "Value";
                break;
        }
    }
}
