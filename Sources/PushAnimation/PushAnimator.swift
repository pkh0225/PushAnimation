//
//  PopAnimator.swift
//  ssg
//
//  Created by pkh on 2017. 11. 30..
//  Copyright © 2017년 emart. All rights reserved.
//

import UIKit

public typealias VoidClosure = () -> Void
public typealias NavigationAnimationClosure     = (_ fromViewController: UIViewController, _ toViewController: UIViewController, _ completion:@escaping VoidClosure) -> Void


public enum NavigationAnimationType: Int {
    case none = 0
    case left
    case right
    case up
    case down
    case snapShot
}

protocol NavigationAnimatorAble {
    var pushAnimation: PushAnimator? { get }
    var popAnimation: PopAnimator? { get }
}

class PushAnimator: NSObject  {

    let leftrightGap: CGFloat = 40
    let upGap: CGFloat = 30
    
    var duration: TimeInterval = 0.2
    var type: NavigationAnimationType = .none
    var animation: NavigationAnimationClosure?

    
    public init(animationType: NavigationAnimationType, duration: TimeInterval = 0.2){
        super.init()
        self.duration = duration
        self.type = animationType
    }
    
    public init(animation: @escaping NavigationAnimationClosure){
        super.init()
        self.animation = animation
    }
    
    func setAnimation(_ closure: @escaping NavigationAnimationClosure) -> Void {
        self.animation = closure
    }
    
    
    
}

extension PushAnimator: UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return self.duration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        guard let toViewController = transitionContext.viewController(forKey: .to),
            let fromViewController = transitionContext.viewController(forKey: .from) else {
                transitionContext.completeTransition(false)
                return
        }
        
        func complete() {
            toViewController.view.transform = .identity
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        }
        
        toViewController.view.frame = transitionContext.containerView.bounds
        transitionContext.containerView.addSubview(toViewController.view)
        
        if let callback = self.animation {
            callback(fromViewController, toViewController, {
                complete()
            })
        }
        else {
            
            switch self.type {
            case .none:
                complete()
                
            case .snapShot:
                let snapShotView = SnapShotView(view: fromViewController.view, shadows: .right)
                toViewController.view.addSubview(snapShotView)
                toViewController.view.sendSubview(toBack: snapShotView)
                complete()
                
            case .left, .right:
                let snapShotView = SnapShotView(view: fromViewController.view, shadows: [.left, .right])
                snapShotView.layerButton?.alpha = 0
                toViewController.view.addSubview(snapShotView)
                
                var posX = -fromViewController.view.frame.size.width + self.leftrightGap
                if self.type == .left {
                    posX = fromViewController.view.frame.size.width - self.leftrightGap
                }
                UIView.animate(withDuration: self.duration, delay: 0, options: .curveEaseOut, animations: {() -> Void in
                    snapShotView.frame.origin.x = posX
                    snapShotView.layerButton?.alpha = LeftRigthLayerAlpha
                }, completion: {(_ finished: Bool) -> Void in
                    complete()
                })
                
                
            case .up:
                let snapShotView = SnapShotView(view: fromViewController.view)
                toViewController.view.addSubview(snapShotView)
                toViewController.view.sendSubview(toBack: snapShotView)
                snapShotView.isHidden = true
                
                let layerView = UIView(frame: fromViewController.view.bounds)
                layerView.backgroundColor = UIColor.black
                layerView.alpha = 0;
                fromViewController.view.addSubview(layerView)
                
                toViewController.view.frame.origin.y = toViewController.view.frame.size.height
                toViewController.view.alpha = 0.5
                
                let backgroundColor: UIColor? = toViewController.view.backgroundColor
                toViewController.view.backgroundColor = UIColor.clear
                
                UIView.animate(withDuration: self.duration, delay: 0, options: .curveEaseOut, animations: {() -> Void in
                    toViewController.view.frame.origin.y = 0
                    toViewController.view.alpha = 1
                    layerView.alpha = SnapShotView.DimLayerAlpha
                    
                }, completion: {(_ finished: Bool) -> Void in
                    snapShotView.isHidden = false
                    layerView.removeFromSuperview()
                    toViewController.view.backgroundColor = backgroundColor
                    complete()
                })
                
                
            case .down:
                let snapShotView = SnapShotView(view: fromViewController.view)
                toViewController.view.addSubview(snapShotView)
                toViewController.view.sendSubview(toBack: snapShotView)
                snapShotView.isHidden = true
                
                let layerView = UIView(frame: fromViewController.view.bounds)
                layerView.backgroundColor = UIColor.black
                layerView.alpha = 0;
                fromViewController.view.addSubview(layerView)
                
                toViewController.view.frame.origin.y = -toViewController.view.frame.size.height
                toViewController.view.alpha = 0.5
                
                let backgroundColor: UIColor? = toViewController.view.backgroundColor
                toViewController.view.backgroundColor = UIColor.clear
                
                UIView.animate(withDuration: self.duration, delay: 0, options: .curveEaseOut, animations: {() -> Void in
                    toViewController.view.frame.origin.y = 0
                    toViewController.view.alpha = 1
                    layerView.alpha = SnapShotView.DimLayerAlpha
                    
                }, completion: {(_ finished: Bool) -> Void in
                    snapShotView.isHidden = false
                    layerView.removeFromSuperview()
                    toViewController.view.backgroundColor = backgroundColor
                    complete()
                })
                
            }
            
        }
        
    }
}
