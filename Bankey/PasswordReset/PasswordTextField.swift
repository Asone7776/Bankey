
import UIKit

protocol PasswordTextFieldViewDelegate:AnyObject{
    func editingChanged(_ sender: PasswordTextField)
    func editingDidEnd(_ sender: PasswordTextField)
}


class PasswordTextField: UIView {
//    Alias for function as variable
    typealias CustomValidation = (_ textValue: String?) -> (Bool,String)?;
    var customValidation:CustomValidation?;
    weak var delegate:PasswordTextFieldViewDelegate?;
    let passwordToggleButton:UIButton = {
        let button = UIButton(type: .custom);
        return button;
    }();
    
    lazy var textField: TextFieldWithPadding = {
        let textField = TextFieldWithPadding(frame: .zero, textPadding: UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10));
        textField.leftView = UIImageView(image: UIImage(systemName: "lock.fill"));
        textField.leftViewMode = .always;
        textField.translatesAutoresizingMaskIntoConstraints = false;
        textField.isSecureTextEntry = true;
        textField.delegate = self;
        textField.addTarget(self, action: #selector(textFieldEditingChanged), for: .editingChanged);
        
        return textField;
    }();
    
    let errorLabel:UILabel = {
        let label = UILabel();
        label.font = .preferredFont(forTextStyle: .footnote);
        label.textColor = .systemRed;
        label.isHidden = true;
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
    
    var text: String? {
        get{
            return textField.text;
        }
        set{
            self.textField.text = newValue;
        }
    }
    
    init(placeholder:String) {
        super.init(frame: .zero)
        textField.placeholder = placeholder;
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

extension PasswordTextField {
    func style() {
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    func layout() {
        addSubview(textField);
        addSubview(divider);
        addSubview(errorLabel);
        NSLayoutConstraint.activate([
            textField.leadingAnchor.constraint(equalTo: leadingAnchor),
            textField.topAnchor.constraint(equalToSystemSpacingBelow: topAnchor, multiplier: 1),
            trailingAnchor.constraint(equalTo: textField.trailingAnchor),
            
            divider.leadingAnchor.constraint(equalTo: leadingAnchor),
            divider.topAnchor.constraint(equalToSystemSpacingBelow: textField.bottomAnchor, multiplier: 1),
            trailingAnchor.constraint(equalTo: divider.trailingAnchor),
            divider.heightAnchor.constraint(equalToConstant: 1),
            
            errorLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            errorLabel.topAnchor.constraint(equalToSystemSpacingBelow: divider.bottomAnchor, multiplier: 0.5),
            trailingAnchor.constraint(equalTo: errorLabel.trailingAnchor)
        ]);
    }
}
//MARK: Actions
extension PasswordTextField{
    @objc private func textFieldEditingChanged(_ sender:UITextField){
        delegate?.editingChanged(self);
    }
}
extension PasswordTextField: UITextFieldDelegate{
    func textFieldDidEndEditing(_ textField: UITextField) {
        delegate?.editingDidEnd(self);
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true);
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
extension PasswordTextField {
    
    func enablePasswordToggle(){
        passwordToggleButton.setImage(UIImage(systemName: "eye.fill"), for: .normal)
        passwordToggleButton.setImage(UIImage(systemName: "eye.slash.fill"), for: .selected)
        passwordToggleButton.addTarget(self, action: #selector(togglePasswordView), for: .touchUpInside)
        textField.rightView = passwordToggleButton
        textField.rightViewMode = .always
    }
    
    @objc func togglePasswordView(_ sender: Any) {
        textField.isSecureTextEntry.toggle()
        passwordToggleButton.isSelected.toggle()
    }
}

extension PasswordTextField {
    func validate() -> Bool {
        if let customValidation = customValidation,
            let customValidationResult = customValidation(text),
            customValidationResult.0 == false {
            showError(customValidationResult.1)
            return false
        }
        clearError()
        return true
    }
    
    private func showError(_ errorMessage: String) {
        errorLabel.isHidden = false
        errorLabel.text = errorMessage
    }

    private func clearError() {
        errorLabel.isHidden = true
        errorLabel.text = ""
    }
}
