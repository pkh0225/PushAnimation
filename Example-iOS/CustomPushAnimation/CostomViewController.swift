//
//  LeftViewController.swift
//  CustomPushAnimation
//
//  Created by SWIFT on 2018. 8. 17..
//  Copyright © 2018년 SWIFT. All rights reserved.
//

import UIKit
import PushAnimation

class CostomViewController: UIViewController {

    @IBOutlet weak var testLabel: UILabel!
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

extension CostomViewController: NavigationAnimatorAble {
    var pushAnimation: PushAnimator? {
        return PushAnimator(animation: { (fromVC, toVC, completion) in
            self.testLabel.frame.size.width = 0
            
            UIView.animate(withDuration: 0.3, animations: {
                self.testLabel.sizeToFit()
            }, completion: { (_) in
                completion()
            })
        })
    }
    var popAnimation: PopAnimator? {
        return PopAnimator(animation: { (fromVC, toVC, completion) in
            
            UIView.animate(withDuration: 0.3, animations: {
                self.testLabel.frame.size.width = 0
            }, completion: { (_) in
                completion()
            })
        })
    }
}
