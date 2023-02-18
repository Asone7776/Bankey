//
//  SummaryModel.swift
//  Bankey
//
//  Created by Arthur Obichkin on 12/02/23.
//

import Foundation

enum AccountType: String, Codable {
    case Banking
    case CreditCard
    case Investment
}
struct SummaryModel: Codable {
    let type: AccountType
    let name: String
    let amount: Decimal
    
    var balanceAsAttributedString: NSAttributedString {
        return CurrencyFormatter().makeAttributedCurrency(amount)
    }
    static func makeSkeleton()->SummaryModel {
        return SummaryModel(type: .Banking, name: "Blank name", amount: 0.0);
    }
}
