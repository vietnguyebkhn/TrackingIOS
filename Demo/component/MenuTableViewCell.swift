//
//  MenuTableViewCell.swift
//  Demo
//
//  Created by Nguyễn Việt on 10/31/18.
//  Copyright © 2018 Quynhbkhn. All rights reserved.
//

import UIKit

class MenuTableViewCell: UITableViewCell {
    
    @IBOutlet weak var mImage: UIImageView!
    
    @IBOutlet weak var mLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setData(image: String, label: String){
        mImage.image = UIImage(named: image)
        mLabel.text = label
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
