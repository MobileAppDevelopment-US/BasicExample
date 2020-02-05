//
//  UserCell.swift
//  BasicExample
//
//  Created by Serik on 29.01.2020.
//  Copyright © 2020 Serik_Klement. All rights reserved.
//


import Foundation
import UIKit
import Kingfisher

class UserCell: BaseTableViewCell {
    
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func setUser(_ user: User) {
        
        nameLabel.text = user.name
        
        if let textUrl = user.images?.first?.fullSrc, let url = URL(string: textUrl) {
            avatarImageView.kf.setImage(with: url,
                                        placeholder: Utill.getPlaceholder(),
                                        options: [.transition(.fade(1)),
                                                  .cacheOriginalImage])
        } else {
            avatarImageView.image = Utill.getPlaceholder()
        }
    }
    
}
