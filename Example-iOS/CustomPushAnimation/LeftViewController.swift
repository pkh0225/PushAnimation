//
//  LeftViewController.swift
//  CustomPushAnimation
//
//  Created by SWIFT on 2018. 8. 17..
//  Copyright © 2018년 SWIFT. All rights reserved.
//

import UIKit

class LeftViewController: UIViewController {

    var popAnimator : PopAnimator?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewDidAppear(_ animated: Bool) {
        if self.popAnimator == nil {
            if let snapShotView = self.view.viewWithTag(SnapShotView.TAG) as? SnapShotView {
                self.popAnimator = PopAnimator(animationType:.left, tagetViewController: self, tagetView: snapShotView)
            }
        }
    }

    @IBAction func onBack(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
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
extension LeftViewController: NavigationAnimatorAble {
    var pushAnimation: PushAnimator? {
        return PushAnimator(animationType: .left)
    }
    var popAnimation: PopAnimator? {
        return self.popAnimator
    }
}
