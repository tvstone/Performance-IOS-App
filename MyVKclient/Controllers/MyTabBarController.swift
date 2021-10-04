//
//  MyTabBarController.swift
//  MyVKclient
//
//  Created by Владислав Тихоненков on 27.06.2021.
//

import UIKit
import RealmSwift
import PromiseKit


final class MyTabBarController: UITabBarController {

    private let network = NetworkFriends()
    private let networkGroup = NetworkGroup()
    private let networkProfile = NetworkProfile()
    private let networkFriendFotos = NetworkFriendFotos()
    private let networkNews = NetworkNews()
    private let realm = try! Realm(configuration: Realm.Configuration(deleteRealmIfMigrationNeeded: true))



    override func viewDidLoad() {
        super.viewDidLoad()

        network.pingMyFriends()
            .done { [weak self] idFriends  in

                guard let self = self else {return}
                DispatchQueue.global(qos: .userInteractive).async {
                    var flag = 0
                    for i in idFriends {
                        let idFriend = i.friendId
                        if flag != 2 {
                            self.networkFriendFotos.pingMyFriendFotos(idFriend: idFriend)
                            flag += 1
                        }
                        else {
                        usleep(450000) // вынужденная задержка из за ограниченного количества запросов  всекунду в ВК
                        self.networkFriendFotos.pingMyFriendFotos(idFriend: idFriend)
                        flag = 0
                        }
                    }

                }

                self.networkGroup.pingMyGroups()
                    .done {  group in
                        DispatchQueue.global(qos: .userInitiated).async {
                            for i in group {
                                let idGroup = i.idGroup
                                let nameGroup = i.titleGroup
                                let avaGroup = i.avaGroup
                                self.networkNews.pingMyNews(idGroup: idGroup, nameGroup: nameGroup, avaGroup: avaGroup)
                                usleep(400000) // вынужденная задержка из за ограниченного количества запросов  в секунду в ВК
                            }
                        }
                    }
                DispatchQueue.global(qos: .utility).async {
                    self.networkProfile.pingMyFotos()
                }
            }
            .catch { error in
                print(error)
            }
//        DispatchQueue.global(qos: .utility).async {
//            self.networkProfile.pingMyFotos()
//        }

        print("=============\(realm.configuration.fileURL as Any)")
    }

}

