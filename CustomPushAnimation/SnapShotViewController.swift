//
//  LeftViewController.swift
//  CustomPushAnimation
//
//  Created by SWIFT on 2018. 8. 17..
//  Copyright © 2018년 SWIFT. All rights reserved.
//

import UIKit

class SnapShotViewController: UIViewController {

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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension SnapShotViewController: NavigationAnimatorAble {
    var pushAnimation: PushAnimator? {
        return PushAnimator(animationType: .snapShot)
    }
    var popAnimation: PopAnimator? {
        return PopAnimator(animationType: .none)
    }
}
