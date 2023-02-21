
import UIKit

class PasswordTextFieldView: UIView {
    let passwordToggleButton:UIButton = {
        let button = UIButton(type: .custom);
        return button;
    }();
    
    lazy var passwordTextField: TextFieldWithPadding = {
        let textField = TextFieldWithPadding(frame: .zero, textPadding: UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10));
        textField.leftView = UIImageView(image: UIImage(systemName: "lock.fill"));
        textField.leftViewMode = .always;
        textField.translatesAutoresizingMaskIntoConstraints = false;
        textField.isSecureTextEntry = true;
        textField.delegate = self;
        return textField;
    }();
    
    let errorLabel:UILabel = {
        let label = UILabel();
        label.font = .preferredFont(forTextStyle: .footnote);
        label.textColor = .systemRed;
        label.isHidden = false;
        label.translatesAutoresizingMaskIntoConstraints = false;
        label.text = "Your password must meet the requirements below";
        label.numberOfLines = 0;
        label.minimumScaleFactor = 0.8
        label.adjustsFontSizeToFitWidth = true;
        label.lineBreakMode = .byWordWrapping
        return label;
    }();
    
    let divider:UIView = {
        let view = UIView();
        view.backgroundColor = .systemGray;
        view.translatesAutoresizingMaskIntoConstraints = false;
        return view;
    }();
    
    init(placeholder:String) {
        super.init(frame: .zero)
        passwordTextField.placeholder = placeholder;
        style()
        layout()
        enablePasswordToggle();
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override var intrinsicContentSize: CGSize {
        return CGSize(width: UIView.noIntrinsicMetric, height: 60)
    }
    
}

extension PasswordTextFieldView {
    func style() {
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    func layout() {
        addSubview(passwordTextField);
        addSubview(divider);
        addSubview(errorLabel);
        NSLayoutConstraint.activate([
            passwordTextField.leadingAnchor.constraint(equalToSystemSpacingAfter: leadingAnchor, multiplier: 1),
            passwordTextField.topAnchor.constraint(equalToSystemSpacingBelow: topAnchor, multiplier: 1),
            trailingAnchor.constraint(equalToSystemSpacingAfter: passwordTextField.trailingAnchor, multiplier: 1),
            
            divider.leadingAnchor.constraint(equalToSystemSpacingAfter: leadingAnchor, multiplier: 1),
            divider.topAnchor.constraint(equalToSystemSpacingBelow: passwordTextField.bottomAnchor, multiplier: 1),
            trailingAnchor.constraint(equalToSystemSpacingAfter: divider.trailingAnchor, multiplier: 1),
            divider.heightAnchor.constraint(equalToConstant: 1),
            
            errorLabel.leadingAnchor.constraint(equalToSystemSpacingAfter: leadingAnchor, multiplier: 1),
            errorLabel.topAnchor.constraint(equalToSystemSpacingBelow: divider.bottomAnchor, multiplier: 0.5),
            trailingAnchor.constraint(equalToSystemSpacingAfter: errorLabel.trailingAnchor, multiplier: 1),
        ]);
    }
}
extension PasswordTextFieldView: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        passwordTextField.endEditing(true);
        return true;
    }
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        return true;
//        if textField.text != ""{
//            return true;
//        }else{
//            return false;
//        }
    }
}


//MARK: Enable password toggle
extension PasswordTextFieldView {
    
    func enablePasswordToggle(){
        passwordToggleButton.setImage(UIImage(systemName: "eye.fill"), for: .normal)
        passwordToggleButton.setImage(UIImage(systemName: "eye.slash.fill"), for: .selected)
        passwordToggleButton.addTarget(self, action: #selector(togglePasswordView), for: .touchUpInside)
        passwordTextField.rightView = passwordToggleButton
        passwordTextField.rightViewMode = .always
    }
    
    @objc func togglePasswordView(_ sender: Any) {
        passwordTextField.isSecureTextEntry.toggle()
        passwordToggleButton.isSelected.toggle()
    }
}
