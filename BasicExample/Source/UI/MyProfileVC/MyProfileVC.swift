//
//  MyProfileVC.swift
//  BasicExample
//
//  Created by Serik on 29.01.2020.
//  Copyright © 2020 Serik_Klement. All rights reserved.
//

import UIKit
import Firebase

class MyProfileVC: BaseVC {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var topConstraint: NSLayoutConstraint!

    var user: User?
    var interests = [Interest]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        getMyProfile()
        //setNavigationBarHidden()
        checkConnectedToInternet()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        tableView.reloadData() // fixed bug cropped interests cell
    }
    
    private func configureTableView() {
        tableView.register(UINib(nibName: "MyProfileCell", bundle: nil), forCellReuseIdentifier: "MyProfileCell")
        tableView.register(UINib(nibName: "LogoutCell", bundle: nil), forCellReuseIdentifier: "LogoutCell")

        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.reloadData()
    }
    
    private func configure() {
        self.title = "My Profile"
        if UIApplication.shared.statusBarFrame.size.height > 20 { // iphoneX
            topConstraint.constant = -88
        }
    }

}

// MARK: - NetworkClient

extension MyProfileVC {
    
    private func getMyProfile() {

    }
    
}


// MARK: - MyProfileVCDelegate, Transition

//extension MyProfileVC: MyProfileVCDelegate {
//
//    func showEditMyProfileVC() {
//        
//        let loginVCStoryboard = UIStoryboard(name: "EditMyProfileVC", bundle: nil)
//        guard let vc = loginVCStoryboard.instantiateViewController(withIdentifier: "EditMyProfileVC") as? EditMyProfileVC else {
//            return
//        }
//        vc.user = user
//        pushViewController(vc)
//    }
//    
//}

// MARK: - UITableViewDataSource, UITableViewDelegate

extension MyProfileVC: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
//        switch indexPath.row {
//        case 0:
//            let cell = tableView.dequeueReusableCell(withIdentifier: "MyProfileCell", for: indexPath) as! MyProfileCell
//            cell.delegate = self
//            cell.setProfile(user)
//            return cell
//
//        case 1:
//            let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCellInterests", for: indexPath) as! TableViewCell
//            if let interests = user?.interests, !interests.isEmpty {
//                cell.typeVC = .myProfile
//                cell.configure(interests)
//            }
//            return cell
//
//        case 2:
//            let cell = tableView.dequeueReusableCell(withIdentifier: "LogoutCell", for: indexPath) as! LogoutCell
//            cell.delegate = self
//            return cell
//
//        default:
//            break
//        }
        return UITableViewCell()
    }
    
}
