//
//  NetworkLayer.swift
//  MyVKclient
//
//  Created by Владислав Тихоненков on 10.08.2021.
//

import Foundation
import Alamofire
import SwiftyJSON
import RealmSwift

final class NetworkFriends {

    private let scheme = "https://"
    private let host = "api.vk.com/"
    private let token = Session.shared.token
    private let id = Session.shared.userId
    private let pathForFriends = "method/friends.get"
    private let pathForFriendFoto = "method/photos.getAll"
<<<<<<< HEAD

    func pingMyFriends(){

        DispatchQueue.global(qos: .userInitiated).async {
=======
    private var itemsRealm : Results<RealmFriend>!
    private var fotosRealm : Results<RealmFotos>!
    private let realm = try! Realm(configuration: Realm.Configuration(deleteRealmIfMigrationNeeded: true))
    private let networkFriendFotos = NetworkFriendFotos()


    func pingMyFriends(){


>>>>>>> lesson3
        let parametersListFriends: Parameters = [
            "user_id": self.id,
            "fields": "nickname,photo_200_orig",
            "order": "name",
            "count": "0",
            "access_token" : self.token,
            "v" : "5.131"
        ]
<<<<<<< HEAD
            AF.request(self.scheme + self.host + self.pathForFriends ,
                   method:.get,
                   parameters: parametersListFriends).responseJSON { [weak self] response in
                    guard let self = self else {return}
=======
        AF.request(self.scheme + self.host + self.pathForFriends ,
                   method:.get,
                   parameters: parametersListFriends).responseJSON { response in
>>>>>>> lesson3
                    switch response.result {
                    case .failure(let error):
                        print(error)
                    case .success(let data):
                        guard let clearJson = JSON(rawValue: data) else {return}
                        let items = clearJson["response"]["items"].arrayValue
                        let countItems = items.count

                        for i in 0 ..< countItems {

                            let firstName = items[i]["first_name"].stringValue
                            let lastName = items[i]["last_name"].stringValue
                            let friendName = firstName + " " + lastName
                            let avatar = items[i]["photo_200_orig"].stringValue
                            let idFriend = items[i]["id"].stringValue
                            self.saveFriensToRealm(friendName: friendName, avatar: avatar, idFriend: idFriend)
<<<<<<< HEAD
                            self.pingMyFriendFotos(idFriend: idFriend)
                        }
                    }
                   }
        }
    }

    func pingMyFriendFotos(idFriend :String) {

        usleep(250000) // Вынужденная задержка из за ВК
        DispatchQueue.global(qos: .background).async {
            let parametersListPhotosFriend : Parameters = [
                "owner_id": idFriend, // id,
                "extended": "1",
                "no_service_albums": "0",
                "photo_sizes" : "0",
                "access_token" : self.token,
                "v" : "5.131"
            ]

            AF.request(self.scheme + self.host + self.pathForFriendFoto ,
                       method: .get,
                       parameters: parametersListPhotosFriend).responseJSON { [weak self] response in
                        guard let self = self else {return}
                        switch response.result {
                        case .failure(let error):
                            print(error)

                        case .success(let data):
                            guard let clearJsonFriendFotos = JSON(rawValue: data) else {return}
                            let items = clearJsonFriendFotos["response"]["items"].arrayValue
                            let countItemsFriendFotos = clearJsonFriendFotos["response"]["count"].intValue
                            let countFR = countItemsFriendFotos > 20 ? 20 : countItemsFriendFotos

                            for i in 0 ..< countFR {

                                let size = items[i]["sizes"].arrayValue
                                guard let url = size.last?["url"].stringValue else {return}
                                let idFoto = items[i]["id"].stringValue
                                let likeFoto = items[i]["likes"]["count"].stringValue
                                self.saveFriendFotoToRealm(idFriend: idFriend,
                                                           foto: url,
                                                           idFoto: idFoto,
                                                           like: likeFoto )
                            }
                        }
                        }
                       }
    }

=======
                            Session.shared.idFriend.append(idFriend)
                        }
                    }
                   }

    }


>>>>>>> lesson3
    func saveFriensToRealm (friendName name: String, avatar ava : String, idFriend : String){

        do {
            let realm = try Realm(configuration: Realm.Configuration(deleteRealmIfMigrationNeeded: true))
            realm.beginWrite()
            let loadFriendsInRealm = RealmFriend(friendName: name, avatar: ava, idFriend : idFriend)
            realm.add(loadFriendsInRealm, update: .modified)
            try realm.commitWrite()
        } catch {
            print(error)
        }
    }

<<<<<<< HEAD
    func saveFriendFotoToRealm (idFriend : String, foto : String, idFoto : String, like : String){

        do {
            let realm = try Realm(configuration: Realm.Configuration(deleteRealmIfMigrationNeeded: true))
            realm.beginWrite()
            let loadFotosInRealm = RealmFotos(idFriend: idFriend, allFotosOfFriend: foto, idFoto: idFoto, like: like)
            realm.add(loadFotosInRealm, update: .modified)
            try realm.commitWrite()
        } catch {
            print(error)
        }
    }

=======

    func  setupFriend() -> [Friend] {

        var itogArray = [Friend]()
        itemsRealm = realm.objects(RealmFriend.self)
        fotosRealm = realm.objects(RealmFotos.self)
        let count = itemsRealm.count
        for i in 0 ..< count {

            let name = itemsRealm[i].friendName
            let ava = itemsRealm[i].avatar
            let idFriend = itemsRealm[i].idFriend
            var arrayFriend = [String]()
            var likes = [String]()

            for j in 0 ..< fotosRealm.count{
                let fot = fotosRealm [j].allFotosOfFriend
                let like = fotosRealm[j].like

                if itemsRealm[i].idFriend == fotosRealm[j].idFriend {
                    arrayFriend.append(fot)
                    likes.append(like)
                }
            }
            let friend = Friend(nameFriend: name, avaFriend: ava, fotos: arrayFriend, like: likes, idFriend: idFriend)
            itogArray.append(friend)
        }
        return itogArray
    }


>>>>>>> lesson3
}

