//
//  SceneDelegate.swift
//  Bankey
//
//  Created by Arthur Obichkin on 08/02/23.
//

import UIKit

let appColor: UIColor = .systemTeal;

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    var loginViewController = LoginViewController();
    var onBoardingContainerViewController = OnboardingContainerViewController(nibName: nil, bundle: nil);
    var mainViewController = MainViewController();
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let scene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: scene);
        window?.backgroundColor = .systemBackground
        loginViewController.delegate = self;
        onBoardingContainerViewController.delegate = self;
//                window?.rootViewController = onBoardingContainerViewController;
//        window?.rootViewController = mainViewController;
        window?.rootViewController = loginViewController;
        window?.makeKeyAndVisible();
        LocalState.hasOnboarded = false;
        registerForNotification();
    }
}
extension SceneDelegate:LoginViewControllerDelegate{
    func didLogin() {
        if LocalState.hasOnboarded {
            setRootViewController(mainViewController);
        }else{
            setRootViewController(onBoardingContainerViewController);
        }
    }
}

extension SceneDelegate: OnboardingContainerViewControllerDelegate{
    func didFinishOnboarding() {
        LocalState.hasOnboarded = true;
        setRootViewController(mainViewController);
    }
    func didCloseOnboarding(){
        setRootViewController(loginViewController);
    }
}

extension SceneDelegate: LogoutDelegate{
   @objc func didLogout() {
        setRootViewController(loginViewController);
    }
}
extension SceneDelegate {
    func registerForNotification(){
        NotificationCenter.default.addObserver(self, selector: #selector(didLogout), name: .logout, object: nil);
    }
    func setRootViewController(_ vc: UIViewController, animated: Bool = true) {
        guard animated, let window = self.window else {
            self.window?.rootViewController = vc
            self.window?.makeKeyAndVisible()
            return
        }
        
        window.rootViewController = vc
        window.makeKeyAndVisible()
        UIView.transition(with: window,
                          duration: 0.3,
                          options: .transitionCrossDissolve,
                          animations: nil,
                          completion: nil)
    }
}
