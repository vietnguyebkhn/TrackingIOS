

//
//  AViewController.swift
//  Demo
//
//  Created by Nguyễn Việt on 10/31/18.
//  Copyright © 2018 Quynhbkhn. All rights reserved.
//

import UIKit

class AViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let myBtn : UIButton = UIButton()
        myBtn.setImage(UIImage(named: "menu"), for: .normal)
        myBtn.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        myBtn.addTarget(self, action:  #selector(self.btnClick(_:)) , for: .touchUpInside)
        self.navigationItem.setLeftBarButton(UIBarButtonItem(customView: myBtn), animated: true)
    }


    @objc func btnClick(_ sender:UIButton) {
        view.endEditing(true)
        self.revealViewController().revealToggle(sender)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
