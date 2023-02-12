//
//  SummaryModel.swift
//  Bankey
//
//  Created by Arthur Obichkin on 12/02/23.
//

import Foundation

enum AccountType: String{
    case Banking
    case CreditCard
    case Investment
}
struct SummaryModel {
    let accountType: AccountType
    let accountName: String
}
