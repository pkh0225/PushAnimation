//
//  LeftViewController.swift
//  CustomPushAnimation
//
//  Created by SWIFT on 2018. 8. 17..
//  Copyright © 2018년 SWIFT. All rights reserved.
//

import UIKit
import PushAnimation

class RightViewController: UIViewController {

    var popAnimator: PopAnimator?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onBack(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }

    override func viewDidAppear(_ animated: Bool) {
        if self.popAnimator == nil {
            if let snapShotView = self.view.viewWithTag(SnapShotView.TAG) as? SnapShotView {
                self.popAnimator = PopAnimator(animationType:.right, tagetViewController: self, tagetView: snapShotView)
            }
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

// MARK:- NevigationAnimatorAble
extension RightViewController: NavigationAnimatorAble {
    var pushAnimation: PushAnimator? {
        return PushAnimator(animationType:.right)
    }
    var popAnimation: PopAnimator? {
        return self.popAnimator
    }
}
