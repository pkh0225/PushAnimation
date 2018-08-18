//
//  DownViewController.swift
//  CustomPushAnimation
//
//  Created by Kimkeeyun on 18/08/2018.
//  Copyright © 2018 SWIFT. All rights reserved.
//

import UIKit

class DownViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    var popAnimator : PopAnimator?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.register(UITableViewCell.self)
        
        self.popAnimator = PopAnimator(animationType:.up, tagetViewController: self, tagetView: self.view)
        self.popAnimator?.addTagetView(self.tableView)
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
    
    func assembleModule(identifier: String) -> UIViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let vc = storyboard.instantiateViewController(withIdentifier: identifier)
        return vc
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 50
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(UITableViewCell.self, for: indexPath)
        cell.textLabel?.text = "row : \(indexPath.row)"
        return cell
    }
    
}

extension DownViewController: NavigationAnimatorAble {
    var pushAnimation: PushAnimator? {
        return PushAnimator(animationType:.down)
    }
    var popAnimation: PopAnimator? {
        return self.popAnimator
    }
}
