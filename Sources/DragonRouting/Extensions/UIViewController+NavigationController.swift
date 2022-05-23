//
//  UIViewController+NavigationController.swift
//  DragonRouting
//
//  Created by Thimo Bess on 19.05.22.
//

import UIKit

extension UIViewController {
    func findNestedUINavigationController() -> UINavigationController? {
        // Check if a modal view is presenred, if so, use the NavigationController
        // inside the modal view
        if let lastPresentedViewController = findLastPresentedViewController() {
            return lastPresentedViewController.findNestedUINavigationController()
        }

        if let nvc = self as? UINavigationController { return nvc }
        else if let tbc = self as? UITabBarController {
            // if we have a tabbar search for a navigation controller inside the active
            // tab
            return tbc.selectedViewController?.findNestedUINavigationController()
        }

        // if no navigation controller or tabbar with a navigation controller can be found
        // check the children
        for child in children {
            return child.findNestedUINavigationController()
        }

        // if this also result in an navigation controller, then we can't return one
        return nil
    }

    private func findLastPresentedViewController() -> UIViewController? {
        if let presentedViewController = presentedViewController?.presentedViewController {
            return self.presentedViewController?.findLastPresentedViewController()
        } else {
            return presentedViewController
        }
    }
}
