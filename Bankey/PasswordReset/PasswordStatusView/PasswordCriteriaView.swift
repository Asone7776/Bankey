import UIKit

class PasswordCriteriaView:UIView{
    let stack:UIStackView = {
        let stack = UIStackView();
        stack.axis = .horizontal;
        stack.spacing = 8;
        stack.translatesAutoresizingMaskIntoConstraints = false;
        return stack;
    }();
    let imageView:UIImageView = {
        let view = UIImageView();
        view.image = UIImage(systemName: "circle")!.withTintColor(.tertiaryLabel, renderingMode: .alwaysOriginal)
        view.translatesAutoresizingMaskIntoConstraints = false;
        return view;
    }();
    
    let label:UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .preferredFont(forTextStyle: .subheadline)
        label.textColor = .secondaryLabel
        return label
    }();
    
    let checkmarkImage = UIImage(systemName: "checkmark.circle")!.withTintColor(.systemGreen, renderingMode: .alwaysOriginal)
    let xmarkImage = UIImage(systemName: "xmark.circle")!.withTintColor(.systemRed, renderingMode: .alwaysOriginal)
    let circleImage = UIImage(systemName: "circle")!.withTintColor(.tertiaryLabel, renderingMode: .alwaysOriginal)
        
    var isCriteriaMet: Bool = false {
        didSet {
            if isCriteriaMet {
                imageView.image = checkmarkImage
            } else {
                imageView.image = xmarkImage
            }
        }
    }

    func reset() {
        isCriteriaMet = false
        imageView.image = circleImage
    }
    
    init(text:String){
        super.init(frame: .zero);
        label.text = text;
        style();
        layout();
//        backgroundColor = .red;
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override var intrinsicContentSize: CGSize {
        return CGSize(width: 200, height: 40)
    }
}
extension PasswordCriteriaView{
    func style(){
        translatesAutoresizingMaskIntoConstraints = false;
        // CHCR
        imageView.setContentHuggingPriority(UILayoutPriority.defaultHigh, for: .horizontal)
        label.setContentHuggingPriority(UILayoutPriority.defaultLow, for: .horizontal)
    }
    func layout(){
        stack.addArrangedSubview(imageView);
        stack.addArrangedSubview(label);
        addSubview(stack);
        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalTo: topAnchor),
            stack.leadingAnchor.constraint(equalToSystemSpacingAfter: leadingAnchor, multiplier: 1),
            stack.trailingAnchor.constraint(equalToSystemSpacingAfter: trailingAnchor, multiplier: 1),
            stack.bottomAnchor.constraint(equalTo: bottomAnchor),
            imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor)
        ])
    }
}
