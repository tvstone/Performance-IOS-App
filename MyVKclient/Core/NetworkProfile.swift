//
//  NetworkProfile.swift
//  MyVKclient
//
//  Created by Владислав Тихоненков on 27.08.2021.
//

<<<<<<< HEAD
import UIKit
=======
import Foundation
>>>>>>> lesson3
import Alamofire
import SwiftyJSON
import RealmSwift

final class NetworkProfile {

    private let scheme = "https://"
    private let host = "api.vk.com/"
    private let token = Session.shared.token
    private let id = Session.shared.userId
    private let pathForFriendFoto = "method/photos.getAll"
    private var fotos = [String]()
<<<<<<< HEAD
    private var likesFotoCount = String()
=======
>>>>>>> lesson3

    func pingMyFotos() {

        let parametersListPhotosFriend : Parameters = [
            "owner_id": id,
            "extended": "1",
            "no_service_albums": "0",
            "photo_sizes" : "0",
            "access_token" : token,
            "v" : "5.131"
        ]

        AF.request(scheme + host + pathForFriendFoto ,
                   method: .get,
                   parameters: parametersListPhotosFriend).responseJSON {[weak self] response in
                    guard let self = self else {return}
                    switch response.result {
                    case .failure(let error):
                        print(error)
                    case .success(let data):
                        guard let clearJsonFriendFotos = JSON(rawValue: data) else {return}
                        let items = clearJsonFriendFotos["response"]["items"].arrayValue
                        let countItemsMyFotos = clearJsonFriendFotos["response"]["count"].intValue
                        let count = countItemsMyFotos > 20 ? 20 : countItemsMyFotos

                        for i in 0 ..< count {
<<<<<<< HEAD

=======
>>>>>>> lesson3
                            let size = items[i]["sizes"].arrayValue
                            guard let url = size.last?["url"].stringValue else {return}
                            let idFoto = items[i]["id"].stringValue
                            let likeFoto = items[i]["likes"]["count"].stringValue
                            self.fotos.append(url)
                            self.saveMyFotoToRealm(idFoto: idFoto, foto: url, like: likeFoto)
                        }

                    }
                   }
    }

    func saveMyFotoToRealm (idFoto : String, foto : String, like : String){

        do {
            let realm = try Realm(configuration: Realm.Configuration(deleteRealmIfMigrationNeeded: true))
            realm.beginWrite()

            let loadFotosInRealm = RealmMyFoto(idFoto: idFoto, allMyFotos: foto, like: like)
            realm.add(loadFotosInRealm, update: .modified)
<<<<<<< HEAD
  //          realm.refresh()
=======
>>>>>>> lesson3
            try realm.commitWrite()
        } catch {
            print(error)
        }
    }


    
}
