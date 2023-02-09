import UIKit

class OnboardingViewController: UIViewController {
    let stackView = UIStackView();
    let image = UIImageView();
    let label = UILabel();
    override func viewDidLoad() {
        super.viewDidLoad();
        style();
        layout();
    }
    
    init(imageName:String, titleText:String) {
        image.image = UIImage(named: imageName);
        label.text = titleText;
        super.init(nibName: nil, bundle: nil);
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension OnboardingViewController {
    
    func style() {
        view.backgroundColor = .systemBackground;
        stackView.translatesAutoresizingMaskIntoConstraints = false;
        stackView.axis = .vertical;
        stackView.spacing = 20;
        
        image.translatesAutoresizingMaskIntoConstraints = false;
        image.contentMode = .scaleAspectFit;
        
        label.translatesAutoresizingMaskIntoConstraints = false;
        label.textAlignment = .center;
        label.numberOfLines = 0;
        label.adjustsFontForContentSizeCategory = true;
        label.font = UIFont.preferredFont(forTextStyle: .title1);
    }
    
    func layout() {
        view.addSubview(stackView);
        stackView.addArrangedSubview(image);
        stackView.addArrangedSubview(label);
        
        NSLayoutConstraint.activate([
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 1),
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: stackView.trailingAnchor, multiplier: 1)
        ])
    }
}
