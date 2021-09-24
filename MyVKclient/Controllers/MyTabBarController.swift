//
//  MyTabBarController.swift
//  MyVKclient
//
//  Created by Владислав Тихоненков on 27.06.2021.
//

import UIKit
import RealmSwift

final class MyTabBarController: UITabBarController {

    private let network = NetworkFriends()
    private let networkGroup = NetworkGroup()
    private let networkProfile = NetworkProfile()
    private let networkFriendFotos = NetworkFriendFotos()
    private let realm = try! Realm(configuration: Realm.Configuration(deleteRealmIfMigrationNeeded: true))


    override func viewDidLoad() {
        super.viewDidLoad()
        loadQueue()
        print("=============\(realm.configuration.fileURL as Any)")
    }



    func loadQueue() {

        DispatchQueue.global(qos: .userInteractive).async {
            self.network.pingMyFriends()
        }
        DispatchQueue.global(qos: .utility).async {
            self.networkGroup.pingMyGroups()
        }
        DispatchQueue.global(qos: .background).async {
            self.networkProfile.pingMyFotos()
        }
    }

}

