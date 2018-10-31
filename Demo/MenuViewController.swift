//
//  MenuViewController.swift
//  Demo
//
//  Created by Nguyễn Việt on 10/31/18.
//  Copyright © 2018 Quynhbkhn. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var mViewController: ViewController?

    @IBOutlet weak var mTableView: UITableView!
    let ImageFunc = ["crash", "crash", "crash", "crash"]
    let NameFunc = ["Thông tin cá nhân", "Crash App!!", "Giới thiệu", "Thoát"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mTableView.register(UINib(nibName: "MenuTableViewCell", bundle: nil), forCellReuseIdentifier: "MenuTableViewCell")
        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MenuTableViewCell", for: indexPath) as! MenuTableViewCell
        cell.setData(image: ImageFunc[indexPath.row], label: NameFunc[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
        self.revealViewController()?.revealToggle(animated: true)
      
        let myViewController = PersonalInforViewController(nibName: "PersonalInforViewController", bundle: nil)
        self.revealViewController()?.frontViewController = UINavigationController(rootViewController: myViewController)
            
        } else if indexPath.row == 2 {
            self.revealViewController()?.revealToggle(animated: true)
            
            let myViewController = InforAppViewController(nibName: "InforAppViewController", bundle: nil)
            self.revealViewController()?.frontViewController = UINavigationController(rootViewController: myViewController)
            
        } else if indexPath.row == 1 {
            self.revealViewController()?.revealToggle(animated: true)
            
            let myViewController = CrashViewController(nibName: "CrashViewController", bundle: nil)
            self.revealViewController()?.frontViewController = UINavigationController(rootViewController: myViewController)
            
        }
    }

}
