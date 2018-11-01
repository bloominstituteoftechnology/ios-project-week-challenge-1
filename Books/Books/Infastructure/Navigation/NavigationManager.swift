import UIKit

class NavigationManager: ManagerProtocol {
    
    // MARK: - Menu Logic Properties
    var window: UIWindow?
    
    // MARK: - ManagerProtocol Methods
    func startup(completion: ((ManagerProtocol?, ErrorAPI?) -> Void)?) {
        completion?(self, nil)
    }
    
    // MARK: - Load Methods
    func loadRoot(viewController: UIViewController) {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.backgroundColor = UIColor.white
        window?.rootViewController = viewController
        window?.makeKeyAndVisible()
    }
    
    func loadRootWithNavigation(viewController: UIViewController) {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.backgroundColor = UIColor.white
        window?.rootViewController = UINavigationController(rootViewController: viewController)
        window?.makeKeyAndVisible()
    }
    
    // MARK: - Navigation Methods
    func push(viewController: UIViewController,
              from fromViewController: UIViewController? = nil,
              animated: Bool = false) {
        let fromViewController = fromViewController ?? topViewController()
        fromViewController?.navigationController?.pushViewController(viewController, animated: animated)
    }
    
    @discardableResult
    func pop(from fromViewController: UIViewController? = nil,
             animated: Bool = false) -> UIViewController? {
        let fromViewController = fromViewController ?? topViewController()
        return fromViewController?.navigationController?.popViewController(animated: animated)
    }
    
    @discardableResult
    func pop(toViewController: UIViewController,
             from fromViewController: UIViewController? = nil,
             animated: Bool = false) -> [UIViewController]? {
        let fromViewController = fromViewController ?? topViewController()
        return fromViewController?.navigationController?.popToViewController(toViewController, animated: animated)
    }
    
    @discardableResult
    func popToRoot(from fromViewController: UIViewController? = nil,
                   animated: Bool = false) -> [UIViewController]? {
        let fromViewController = fromViewController ?? topViewController()
        return fromViewController?.navigationController?.popToRootViewController(animated: animated)
    }
    
    func setNavigationRoot(viewControllers: [UIViewController],
                           from fromViewController: UIViewController? = nil,
                           animated: Bool = false) {
        guard viewControllers.count > 0 else { return }
        if let fromViewController = fromViewController ?? topViewController(), fromViewController.presentingViewController == nil {
            fromViewController.navigationController?.setViewControllers(viewControllers, animated: animated)
        }
    }
    
    func setRoot(viewController: UIViewController) {
        let transition = CATransition()
        transition.type = CATransitionType.fade
        window?.set(rootViewController: viewController, transition: transition)
    }
    
    func setRootWithNavigation(viewControllers: [UIViewController]) {
        guard viewControllers.count > 0 else { return }
        let mainVC = UINavigationController(rootViewController: viewControllers[0])
        mainVC.setViewControllers(viewControllers, animated: false)
        let transition = CATransition()
        transition.type = CATransitionType.fade
        window?.set(rootViewController: mainVC, transition: transition)
    }
    
    func present(viewController: UIViewController,
                 from fromViewController: UIViewController? = nil,
                 transitionStyle: UIModalTransitionStyle = .crossDissolve,
                 animated: Bool = false,
                 completion: (() -> Void)? = nil) {
        viewController.modalPresentationStyle = .overCurrentContext
        viewController.modalPresentationCapturesStatusBarAppearance = true
        viewController.modalTransitionStyle = transitionStyle
        let fromViewController = fromViewController ?? topViewController()
        fromViewController?.present(viewController, animated: animated, completion: completion)
    }
    
    func presentNavigation(viewController: UIViewController,
                           from fromViewController: UIViewController? = nil,
                           transitionStyle: UIModalTransitionStyle = .crossDissolve,
                           animated: Bool = false,
                           completion: (() -> Void)? = nil) {
        guard let fromViewController = fromViewController ?? topViewController() else {
            completion?()
            return
        }
        let mainVC = UINavigationController(rootViewController: viewController)
        mainVC.modalPresentationStyle = .overCurrentContext
        mainVC.modalTransitionStyle = transitionStyle
        fromViewController.present(mainVC, animated: animated, completion: completion)
    }
    
    func dismiss(viewController: UIViewController?,
                 animated: Bool = false,
                 completion: (() -> Void)? = nil) {
        viewController?.dismiss(animated: animated, completion: completion)
    }
    
    // MARK: - Helper Methods
    func getPresentingViewController(of viewController: UIViewController?) -> UIViewController? {
        if let navigationController = viewController?.presentingViewController as? UINavigationController {
            guard var viewController = navigationController.viewControllers.last else { return nil }
            while viewController is UINavigationController {
                guard let lastNavigationController = viewController as? UINavigationController,
                    let lastViewController = lastNavigationController.viewControllers.last else { return nil }
                viewController = lastViewController
            }
            return viewController
        } else if let viewController = viewController?.presentingViewController {
            return viewController
        } else {
            return nil
        }
    }
    
    func topViewController(from: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        if let nav = from as? UINavigationController {
            return topViewController(from: nav.visibleViewController)
        }
        if let tab = from as? UITabBarController {
            let moreNavigationController = tab.moreNavigationController
            
            if let top = moreNavigationController.topViewController, top.view.window != nil {
                return topViewController(from: top)
            } else if let selected = tab.selectedViewController {
                return topViewController(from: selected)
            }
        }
        if let presented = from?.presentedViewController {
            return topViewController(from: presented)
        }
        return from
    }
    
    func presentInNavigationViewController(viewController: UIViewController,
                                           from fromViewController: UIViewController? = nil,
                                           transitionStyle: UIModalTransitionStyle = .crossDissolve,
                                           animated: Bool = false,
                                           completion: (() -> Void)? = nil) {
        // set up new view controller
        viewController.modalPresentationCapturesStatusBarAppearance = true
        // create a navigation controller
        let navVC = UINavigationController(rootViewController: viewController)
        navVC.view.backgroundColor = UIColor.clear
        // present the new navigation controller
        let fromViewController = fromViewController ?? topViewController()
        present(viewController: navVC,
                from: fromViewController,
                transitionStyle: transitionStyle,
                animated: animated,
                completion: completion)
    }
    
    func openURLIfPossible(url: URL) {
        if UIApplication.shared.canOpenURL(url) {
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            } else {
                UIApplication.shared.openURL(url)
            }
        }
    }
}
