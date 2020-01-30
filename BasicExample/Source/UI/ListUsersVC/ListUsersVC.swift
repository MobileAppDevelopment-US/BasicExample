//
//  ListUsersVC.swift
//  BasicExample
//
//  Created by Serik on 21.01.2020.
//  Copyright © 2020 Serik_Klement. All rights reserved.
//

import UIKit

class ListUsersVC: BaseTableVC {
    // СДЕЛАТЬ ПАГИНАЦИЮ ДЛЯ МУСОРОК!!!
    
    // gitignore
    // ПАГИНАЦИЯ 
    
    
    // fileprivate
    // constant
    // иконки в таб баре
        
    // описать замену рута после входа в приложения или логаута
    // сделать отдельный базовый клас для коллекции
    // просмотреть трекер про на свифт
    // подтянуть пару примеров нотификаций
    
    
    var refreshControl: UIRefreshControl!
    var shouldLoadMore: Bool!
    var nextPage : Int!
    var PER_PAGE = 20
    var users = [User]()
    var isShowSpinner: Bool = false

    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        addRefreshControl()
    }
    
      override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        checkConnectedToInternet()
    }
    
    deinit {
        Utill.printToConsole("ListUsersVC -- deinit")
        NotificationCenter.default.removeObserver(self,
                                                  name: UIApplication.didBecomeActiveNotification,
                                                  object: nil)
    }
    
    // MARK: - Methods

    private func addRefreshControl() {
        
        refreshControl = UIRefreshControl()
        refreshControl.attributedTitle = NSAttributedString(string: "")
        refreshControl.addTarget(self,
                                 action: #selector(getUserList),
                                 for: .valueChanged)
        tableView.addSubview(refreshControl)
    }
    
    
//    lazy var autoScroller: AutoScroller = {
//        return AutoScroller(collectionView: infiniteCollectionView,
//                            size: infiniteSize,
//                            modelSize: infiniteItems.count)
//    }()
    
    
//    override func viewDidAppear(_ animated: Bool) {
//        super.viewDidAppear(animated)
//        
//        updateUIComponents()
//        NotificationCenter.default.addObserver(self,
//                                               selector: #selector(applicationDidBecomeActive),
//                                               name: UIApplication.didBecomeActiveNotification,
//                                               object: nil)
//        checkUserPushClick()
//    }
//    
//    override func viewDidDisappear(_ animated: Bool) {
//        super.viewDidDisappear(animated)
//        
//        //NotificationCenter.default.removeObserver(self)
//        NotificationCenter.default.removeObserver(self,
//                                                  name: UIApplication.didBecomeActiveNotification,
//                                                  object: nil)
//    }


    private func registredNotification() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(getUserList),
                                               name: UIApplication.didBecomeActiveNotification,
                                               object: nil)
    }

}


// MARK: - NetworkClient

extension ListUsersVC {
    
    
    @objc func getUserList() {
        shouldLoadMore = false
        nextPage = 1
        
        users = []
        reloadTableView()
        loadUserList()
    }
    
    func loadUserList() {
        
        networkClient.getUserList(nextPage: nextPage,
                                  perPage: PER_PAGE,
                                  success:
            { [weak self] (listUsers) in
                guard let self = self else { return }
                
                if let users = listUsers?.data {
                    
                    for user in users {
                        self.users.append(user)
                    }
                    self.reloadTableView()
                    self.shouldLoadMore = users.count == self.PER_PAGE
                    print(">>>>>>self.users.count = \(self.users.count)")

                }
                self.refreshControl.endRefreshing()
                self.hideSpinner()
                self.isShowSpinner = false
            },
                                  failure:
            { [weak self] (message) in
                guard let self = self else { return }
                self.refreshControl.endRefreshing()
                self.hideSpinner()
                self.isShowSpinner = false
                Utill.showErrorAlert(message, vc: self)
        })
    }

}
// MARK: - UITableViewDelegate UICollectionViewDataSource

extension ListUsersVC {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let user = users[indexPath.row]
        let cell = tableView.dequeueReusableCellWithRegistration(type: UserCell.self, indexPath: indexPath)
        cell.setUser(user)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let user = users[indexPath.row]
        self.showUserDetailVC(user: user)
    }

    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {

        if indexPath.row == users.count - 1, shouldLoadMore {
            shouldLoadMore = false
            nextPage += 1
            loadUserList()
        }
    }
    
}

// MARK: - Transition

extension ListUsersVC {
    
    private func showUserDetailVC(user: User) {
        guard let vc = UIViewController.instanceFromStoryboard(.userProfileVC) as? UserProfileVC else { return }
        vc.user = user
        pushViewController(vc)
    }
    
}
