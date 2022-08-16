//
//  NavigationManager.swift
//  ssg
//
//  Created by pkh on 2017. 12. 8..
//  Copyright © 2017년 emart. All rights reserved.
//

import UIKit

class NavigationManager: NSObject {
    
    static let shared = NavigationManager()
    
    weak var mainNavigation: UINavigationController? {
        didSet {
            mainNavigation?.delegate = self
            mainNavigation?.interactivePopGestureRecognizer?.delegate = self
        }
    }
}

//MARK: - UINavigationControllerDelegate
extension NavigationManager: UINavigationControllerDelegate, UIGestureRecognizerDelegate {
    func navigationController(_ navigationController: UINavigationController,
                              animationControllerFor operation: UINavigationController.Operation,
                              from fromVC: UIViewController,
                              to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        
        
        if operation == .push {
            if let vc = toVC as? NavigationAnimatorAble {
                return vc.pushAnimation
            }
        }
        else if operation == .pop {
            if let vc = fromVC as? NavigationAnimatorAble, let popAnimation = vc.popAnimation {
                if (popAnimation.isAnimation) {
                    return vc.popAnimation
                }
            }
        }
        
        return nil
    }
    
    func navigationController(_ navigationController: UINavigationController, interactionControllerFor animationController: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        
        if let animator = animationController as? PopAnimator {
            return animator.interactionController
        }
        return nil
    }
    
    public func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
    }
    
    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        
        if navigationController.viewControllers.count < 2 {
            navigationController.interactivePopGestureRecognizer?.isEnabled = false
        }
        
    }
    
    public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    
}

