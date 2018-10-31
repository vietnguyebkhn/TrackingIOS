//
//  PersonalInforViewController.swift
//  Demo
//
//  Created by Nguyễn Việt on 10/31/18.
//  Copyright © 2018 Quynhbkhn. All rights reserved.
//

import UIKit

class PersonalInforViewController: UIViewController {

    @IBOutlet weak var mExitButton: UIButton!
    @IBOutlet weak var mReWrite: UIButton!
    @IBOutlet weak var mLink: UILabel!
    @IBOutlet weak var mImage: UIImageView!
   
    @IBAction func mReWriteTouched(_ sender: Any) {
     // TouchedButton!(0)
    }
    
    @IBAction func mExitTouched(_ sender: Any) {
     //   TouchedButton!(1)

    }
    
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
    


}
