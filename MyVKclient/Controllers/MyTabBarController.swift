//
//  MyTabBarController.swift
//  MyVKclient
//
//  Created by Владислав Тихоненков on 27.06.2021.
//

import UIKit
import RealmSwift
<<<<<<< HEAD
import Kingfisher
=======
>>>>>>> lesson3

final class MyTabBarController: UITabBarController {

    private let network = NetworkFriends()
    private let networkGroup = NetworkGroup()
    private let networkProfile = NetworkProfile()
<<<<<<< HEAD
    private let realm = try! Realm(configuration: Realm.Configuration(deleteRealmIfMigrationNeeded: true))
    private var itemsRealm : Results<RealmFriend>!
    private var fotosRealm : Results<RealmFotos>!
    private var itemsRealmMyProfile : Results<RealmMyFoto>!
    private var arrayFriend = [String]()
    private var likes = [String]()

    func  setupFriend() -> [Friend] {

        var itogArray = [Friend]()
        itemsRealm = realm.objects(RealmFriend.self)
        fotosRealm = realm.objects(RealmFotos.self)
        let count = itemsRealm.count
        for i in 0 ..< count {

            let name = itemsRealm[i].friendName
            let ava = itemsRealm[i].avatar

            arrayFriend = [String]()
            likes = [String]()

            for j in 0 ..< fotosRealm.count{
                let fot = fotosRealm [j].allFotosOfFriend
                let like = fotosRealm[j].like
                if itemsRealm[i].idFriend == fotosRealm[j].idFriend {
                    arrayFriend.append(fot)
                    likes.append(like)
                }
            }
            let friend = Friend(nameFriend: name, avaFriend: ava, fotos: arrayFriend, like: likes)
            itogArray.append(friend)
        }
        return itogArray
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        network.pingMyFriends()
        networkGroup.pingMyGroups()
        networkProfile.pingMyFotos()
        print("=============\(realm.configuration.fileURL as Any)")

    }


=======
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

>>>>>>> lesson3
}

