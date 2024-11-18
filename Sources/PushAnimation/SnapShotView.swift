//
//  SnapShotView.swift
//  ssg
//
//  Created by pkh on 2017. 12. 8..
//  Copyright © 2017년 emart. All rights reserved.
//

import UIKit

public let LeftRigthLayerAlpha: CGFloat = 0.1

public class SnapShotView: UIView {
    public struct ShadowDirection: OptionSet {
        public let rawValue: Int
        public init(rawValue: Int) {
            self.rawValue = rawValue
        }
        public static let left = ShadowDirection(rawValue: 1 << 0)
        public static let right = ShadowDirection(rawValue: 1 << 1)
        public static let up = ShadowDirection(rawValue: 1 << 2)
        public static let down = ShadowDirection(rawValue: 1 << 3)
        public static let none = ShadowDirection(rawValue: 1 << 4)
        public static let all: ShadowDirection = [.left, .right, .up, .down]
    }

    public static let TAG = 900100
    public static let DimLayerAlpha: CGFloat = 0.7

    public var snapshotView: UIView?
    public var layerButton: UIButton?
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public init(view: UIView, shadows: ShadowDirection = ShadowDirection.none) {
        super.init(frame: view.bounds)
        self.tag = SnapShotView.TAG
        guard let snapshot = view.snapshotView(afterScreenUpdates: false) else {
            return
        }
        
        snapshot.frame = view.bounds
        snapshot.autoresizingMask = [.flexibleWidth , .flexibleHeight]
        let layerButton = UIButton(type: .custom)
        layerButton.frame = snapshot.bounds
        layerButton.autoresizingMask = [.flexibleWidth , .flexibleHeight]
        layerButton.backgroundColor = UIColor.black
        layerButton.alpha = SnapShotView.DimLayerAlpha
        
        layerButton.addTarget(self, action: #selector(onBack(_:)), for: .touchUpInside)
        snapshot.addSubview(layerButton)
        
        
        snapshot.layer.shadowOffset = CGSize(width: 0, height: 0)
        snapshot.layer.shadowColor = UIColor.black.cgColor
        snapshot.layer.shadowOpacity = Float(SnapShotView.DimLayerAlpha)
        snapshot.layer.masksToBounds =  false
        
        // Snapshot에 Shadow 기능 추가
        let shadowWidth = 2
        var path = (0,0,0,0) // 좌,우,상,하
        
        if shadows.contains(.left) {
            path.0 = -shadowWidth
        }
        if shadows.contains(.right) {
            path.1 = shadowWidth
        }
        if shadows.contains(.up) {
            path.2 = -shadowWidth
        }
        if shadows.contains(.down) {
            path.3 = shadowWidth
        }
        
        snapshot.layer.shadowPath = UIBezierPath(rect: CGRect(x: path.0, y: path.2, width: Int(snapshot.frame.size.width) + path.1, height: Int(snapshot.frame.size.height) + path.3)).cgPath
        
        self.addSubview(snapshot)
        self.layerButton = layerButton
        self.snapshotView = snapshot

    }
    
    
    
    @objc func onBack(_ sender: UIButton) {
        self.parentViewController?.navigationController?.popViewController(animated: true)
    }
    
    public var parentViewController: UIViewController? {
        var parentResponder: UIResponder? = self
        while parentResponder != nil {
            parentResponder = parentResponder!.next
            if let viewController = parentResponder as? UIViewController {
                return viewController
            }
        }
        return nil
    }
}
