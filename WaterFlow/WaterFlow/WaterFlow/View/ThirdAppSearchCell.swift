//
//  ThirdAppSearchCell.swift
//  Carloudy
//
//  Created by Zijia Zhai on 1/24/19.
//  Copyright © 2019 Cognitive AI Technologies. All rights reserved.
//

import UIKit

class ThirdAppSearchCell: UICollectionViewCell {
    
    var thirdAppSearchCellData: ThirdAppsModel?{
        didSet{
            guard let data = thirdAppSearchCellData else{ return }
            appName.text = data.RegisterAppName
            if let descriptionText = data.RegisterAppDescription{
                appDescription.text = descriptionText
            }
            
            if let appIcon = data.RegisterAppIcon{
                iconImage.loadImage(urlString: appIcon)
            }
        }
    }

    @IBOutlet weak var appName: UILabel!
    @IBOutlet weak var iconImage: CustomImageView!
    @IBOutlet weak var appDescription: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.backgroundColor = UIColor.background
        self.layer.cornerRadius = 10
        self.layer.masksToBounds = true
    }

}
