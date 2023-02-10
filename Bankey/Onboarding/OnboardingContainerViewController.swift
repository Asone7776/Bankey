//
//  OnboardingContainerViewController.swift
//  Bankey
//
//  Created by jrasmusson on 2021-09-28.
//

import UIKit

protocol OnboardingContainerViewControllerDelegate: AnyObject{
    func didFinishOnboarding()
    func didCloseOnboarding()
}

class OnboardingContainerViewController: UIViewController {
    lazy var closeButton:UIButton = {
        let button = UIButton();
        button.configuration = .filled();
        button.setTitle("Close", for: .normal);
        button.translatesAutoresizingMaskIntoConstraints = false;
        button.addTarget(self, action: #selector(closePressed), for: .primaryActionTriggered);
        return button;
    }();
    
    lazy var doneButton:UIButton = {
        let button = UIButton();
        button.configuration = .filled();
        button.setTitle("Done", for: .normal);
        button.translatesAutoresizingMaskIntoConstraints = false;
        button.addTarget(self, action: #selector(donePressed), for: .primaryActionTriggered);
        return button;
    }();
    
    let pageViewController: UIPageViewController
    var pages = [UIViewController]()
    var currentVC: UIViewController
    weak var delegate: OnboardingContainerViewControllerDelegate?
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        self.pageViewController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        
        let page1 = OnboardingViewController(imageName: "delorean", titleText: "First slide")
        let page2 = OnboardingViewController(imageName: "world", titleText: "Second slide")
        let page3 = OnboardingViewController(imageName: "thumbs", titleText: "Third slide")
        
        pages.append(page1)
        pages.append(page2)
        pages.append(page3)
        
        currentVC = pages.first!
        
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup();
        layout();
    }
}
//MARK: Setup view
extension OnboardingContainerViewController{
    private func setup(){
        view.backgroundColor = .systemPurple
        
        addChild(pageViewController)
        view.addSubview(pageViewController.view)
        pageViewController.didMove(toParent: self)
        
        pageViewController.dataSource = self
        pageViewController.view.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo: pageViewController.view.topAnchor),
            view.leadingAnchor.constraint(equalTo: pageViewController.view.leadingAnchor),
            view.trailingAnchor.constraint(equalTo: pageViewController.view.trailingAnchor),
            view.bottomAnchor.constraint(equalTo: pageViewController.view.bottomAnchor),
        ])
        
        pageViewController.setViewControllers([pages.first!], direction: .forward, animated: false, completion: nil)
        currentVC = pages.first!
    }
    private func layout(){
        pageViewController.view.addSubview(closeButton);
        pageViewController.view.addSubview(doneButton);
        NSLayoutConstraint.activate([
            closeButton.topAnchor.constraint(equalToSystemSpacingBelow: pageViewController.view.safeAreaLayoutGuide.topAnchor, multiplier: 1),
            closeButton.leadingAnchor.constraint(equalToSystemSpacingAfter: pageViewController.view.safeAreaLayoutGuide.leadingAnchor, multiplier: 1),
            
            doneButton.topAnchor.constraint(equalToSystemSpacingBelow: pageViewController.view.safeAreaLayoutGuide.topAnchor, multiplier: 1),
            pageViewController.view.safeAreaLayoutGuide.trailingAnchor.constraint(equalToSystemSpacingAfter: doneButton.trailingAnchor, multiplier: 1),
        ]);
    }
}
//MARK: Actions
extension OnboardingContainerViewController{
    @objc private func closePressed(){
        delegate?.didCloseOnboarding();
    }
    @objc private func donePressed(){
        delegate?.didFinishOnboarding();
    }
    
}

// MARK: - UIPageViewControllerDataSource
extension OnboardingContainerViewController: UIPageViewControllerDataSource {

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        return getPreviousViewController(from: viewController)
    }

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        return getNextViewController(from: viewController)
    }

    private func getPreviousViewController(from viewController: UIViewController) -> UIViewController? {
        guard let index = pages.firstIndex(of: viewController), index - 1 >= 0 else { return nil }
        currentVC = pages[index - 1]
        return pages[index - 1]
    }

    private func getNextViewController(from viewController: UIViewController) -> UIViewController? {
        guard let index = pages.firstIndex(of: viewController), index + 1 < pages.count else { return nil }
        currentVC = pages[index + 1]
        return pages[index + 1]
    }

    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return pages.count
    }

    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return pages.firstIndex(of: self.currentVC) ?? 0
    }
}

