//
//  Alerts.swift
//  Bankey
//
//  Created by Arthur Obichkin on 14/02/23.
//

import UIKit

protocol ConfirmAlertDelegate{
    func showConfirmDialog(alert: UIAlertController)
}


protocol ErrorAlertDelegate{
    func showErrorDialog(alert: UIAlertController)
}

struct ConfirmAlert{
    var delegate: ConfirmAlertDelegate?
    func presentAlert(title:String, message:String?, alertAction: @escaping () -> Void){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert);
        let confirmAction = UIAlertAction(title: "Yes", style: .default) { _ in
            alertAction();
        }
        let cancelAction = UIAlertAction(title: "No", style: .cancel);
        alert.addAction(confirmAction);
        alert.addAction(cancelAction);
        delegate?.showConfirmDialog(alert: alert);
    }
}

struct ErrorAlert{
    var delegate: ErrorAlertDelegate?
    func presentAlert(title:String, message:String?){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert);
        let cancelAction = UIAlertAction(title: "Close", style: .cancel);
        alert.addAction(cancelAction);
        delegate?.showErrorDialog(alert: alert);
    }
}
