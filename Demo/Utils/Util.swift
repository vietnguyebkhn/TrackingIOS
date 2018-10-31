//
//  Util.swift
//  Demo
//
//  Created by Nguyễn Việt on 10/31/18.
//  Copyright © 2018 Quynhbkhn. All rights reserved.
//

import Foundation

class Util {
    
    static func showMessage(title: String?, message: String?, viewcontroler: UIViewController) {
        let alert = UIAlertController.init(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction.init(title: "OK", style: .default, handler: { (action) in
            alert.dismiss(animated: true, completion: nil)
        }))
        
        viewcontroler.present(alert, animated: true, completion: nil)
    }
}
