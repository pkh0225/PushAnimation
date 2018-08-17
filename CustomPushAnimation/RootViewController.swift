//
//  ViewController.swift
//  CustomPushAnimation
//
//  Created by SWIFT on 2018. 8. 17..
//  Copyright © 2018년 SWIFT. All rights reserved.
//

import UIKit

class RootViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.register(UITableViewCell.self)
        
        NavigationManager.shared.mainNavigation = self.navigationController
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func assembleModule(identifier: String) -> UIViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let vc = storyboard.instantiateViewController(withIdentifier: identifier)
        return vc
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(UITableViewCell.self, for: indexPath)
        
        switch indexPath.row {
        case 0:
            cell.textLabel?.text = "left"
        case 1:
            cell.textLabel?.text = "rigth"
        case 2:
            cell.textLabel?.text = "up"
        case 3:
            cell.textLabel?.text = "none"
        case 4:
            cell.textLabel?.text = "snapShot"
            
        default:
            break
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            let vc = assembleModule(identifier: "LeftViewController")
            self.navigationController?.pushViewController(vc, animated: true)
            break
        case 1:
            let vc = assembleModule(identifier: "RightViewController")
            self.navigationController?.pushViewController(vc, animated: true)
            break
        case 2:
            let vc = assembleModule(identifier: "UpViewController")
            self.navigationController?.pushViewController(vc, animated: true)
            break
        case 3:
            let vc = assembleModule(identifier: "NoneViewController")
            self.navigationController?.pushViewController(vc, animated: true)
            break
        case 4:
            let vc = assembleModule(identifier: "SnapShotViewController")
            self.navigationController?.pushViewController(vc, animated: true)
            break
            
        default:
            break
        }
    }
}

