//
//  BaseTableVC.swift
//  BasicExample
//
//  Created by Serik on 30.01.2020.
//  Copyright © 2020 Serik_Klement. All rights reserved.
//

import UIKit

class BaseTableVC: BaseVC {

    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.delegate = self
            tableView.dataSource = self
        }
    }
    
    @IBOutlet weak var collectionView: UICollectionView! {
        didSet {
            collectionView.delegate = self
            collectionView.dataSource = self
        }
    }

}

// MARK: - UITableViewDataSource

extension BaseTableVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return false
    }
    
}

// MARK: - UITableViewDelegate

extension BaseTableVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
   
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        // pagination
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return .zero
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return .zero
    }

}

// MARK: - reloadTableView, reloadRows, reloadSections, reloadCollectionView

extension BaseTableVC {
    
    func reloadTableView(queue: DispatchQueue? = nil, completion: VoidCompletion? = nil) {
        
        if queue != nil {
            queue?.sync {
                DispatchQueue.main.async { [weak self] in
                    guard let self = self else { return }
                    self.tableView.reloadData()
                    self.tableView.layoutIfNeeded()
                    completion?()
                }
            }
        } else {
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                self.tableView.reloadData()
                self.tableView.layoutIfNeeded()
                completion?()
            }
        }
    }
    
    func reloadRows(at indexPath: IndexPath, animated: Bool = false) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.tableView.reloadRows(at: [indexPath], with: (animated) ? .fade : .none)
        }
    }
    
    func reloadSections(at indexSet: IndexSet, animated: Bool = false) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.tableView.reloadSections(indexSet, with: (animated) ? .fade : .none)
        }
    }

    func reloadCollectionView(queue: DispatchQueue? = nil, completion: VoidCompletion? = nil) {
        
        if queue != nil {
            queue?.sync {
                DispatchQueue.main.async { [weak self] in
                    guard let self = self else { return }
                    self.collectionView.reloadData()
                    self.collectionView.layoutIfNeeded()
                    completion?()
                }
            }
        } else {
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                self.collectionView.reloadData()
                self.collectionView.layoutIfNeeded()
                completion?()
            }
        }
    }
    
}

// MARK: - UICollectionViewDataSource

extension BaseTableVC: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return UICollectionViewCell()
    }

}

// MARK: - UICollectionViewDelegate

extension BaseTableVC: UICollectionViewDelegate {
    
    func collectionView(_ tableView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        // pagination
    }

    func collectionView(_ tableView: UICollectionView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
        
}
