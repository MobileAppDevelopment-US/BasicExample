//
//  BaseVCToolsProtocol.swift
//  BasicExample
//
//  Created by Serik on 22.01.2020.
//  Copyright © 2020 Serik_Klement. All rights reserved.
//

import UIKit

// MARK: - UITableViewNibCell
protocol UITableViewNibCell: NibLoadableCell, ReusableView where Self: UITableViewCell { }

// MARK: - UICollectionViewNibCell
protocol UICollectionViewNibCell: NibLoadableCell, ReusableView where Self: UICollectionViewCell { }


// MARK: - NibLoadableCell
protocol NibLoadableCell {
    static var nib: UINib { get }
}

extension NibLoadableCell where Self: UIView {
    
    static var nib: UINib {
        let nibName = String(describing: self)
        return UINib(nibName: nibName, bundle: nil)
    }
    
}

// MARK: - ReusableView
protocol ReusableView {
    static var reuseIdentifier: String { get }
}

extension ReusableView where Self: UIView {
    
    static var reuseIdentifier: String {
        return String(describing: self)
    }
    
}

// MARK: - UITableView
extension UITableView {
    
    func dequeueReusableCellWithRegistration<T: UITableViewNibCell>(type: T.Type, indexPath: IndexPath) -> T {
        
        let identifier = T.reuseIdentifier
        register(T.nib, forCellReuseIdentifier: identifier)
        return dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! T
    }

}

// MARK: - UICollectionView
extension UICollectionView {
    
    func dequeueReusableCellWithRegistration<T: UICollectionViewNibCell>(type: T.Type, indexPath: IndexPath) -> T {
        
        let identifier = T.reuseIdentifier
        register(T.nib, forCellWithReuseIdentifier: identifier)
        return dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as! T
    }
    
}
// BasicExample - create and register a cell

// let cell = tableView.dequeueReusableCellWithRegistration(type: ChannelCell.self, indexPath: indexPath)


