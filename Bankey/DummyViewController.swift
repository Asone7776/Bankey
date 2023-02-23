//
//  DummyViewController.swift
//  Bankey
//
//  Created by Uzkassa on 23/02/23.
//

import UIKit

class DummyViewController: UIViewController {
    lazy var textField:UITextField = {
        let field = UITextField();
        field.delegate = self;
        field.placeholder = "Dummy";
        field.backgroundColor = .systemGray6;
        field.translatesAutoresizingMaskIntoConstraints = false;
        field.addTarget(self, action: #selector(textFieldEditingChanged), for: .editingChanged);
        return field;
    }();
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground;
        layout();
    }
}

extension DummyViewController{
    private func layout(){
        view.addSubview(textField);
        NSLayoutConstraint.activate([
            textField.leadingAnchor.constraint(equalToSystemSpacingAfter: view.safeAreaLayoutGuide.leadingAnchor, multiplier: 1),
            view.safeAreaLayoutGuide.trailingAnchor.constraint(equalToSystemSpacingAfter: textField.trailingAnchor, multiplier: 1),
            textField.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ]);
    }
    @objc private func textFieldEditingChanged(_ sender:UITextField){
        if let text = sender.text{
            print(text);
        }
    }
}

extension DummyViewController:UITextFieldDelegate{
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.endEditing(true);
        guard let text = textField.text else{
            return;
        }
        print(text);
    }
//    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
//        let word = textField.text ?? ""
//        let char = string
//        print("Default - shouldChangeCharactersIn: \(word) \(char)")
//        return true
//    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true);
        return true;
    }
}
