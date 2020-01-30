//
//  BaseTableViewCell.swift
//  BasicExample
//
//  Created by Serik on 29.01.2020.
//  Copyright © 2020 Serik_Klement. All rights reserved.
//

import UIKit

class BaseTableViewCell: UITableViewCell, UITableViewNibCell {

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        
        setupView()
    }
    
    private func setupView() {
        selectionStyle = .none
        //editingStyle = .none
        //backgroundColor = .white
    }

}
