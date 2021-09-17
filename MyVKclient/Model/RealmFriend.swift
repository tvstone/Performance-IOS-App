//
//  realm.swift
//  MyVKclient
//
//  Created by Владислав Тихоненков on 15.08.2021.
//

import Foundation
import RealmSwift

final class RealmFriend: Object  {

    @objc dynamic var idFriend = String()
    @objc dynamic var friendName = String() 
    @objc dynamic var avatar = String()
  //  let fotos = List<RealmFotos>()


    convenience init(friendName : String, avatar : String, idFriend : String) { 
        self.init()
        self.idFriend = idFriend
        self.friendName = friendName
        self.avatar = avatar
    }

override class func primaryKey () -> String?{
    return "idFriend"
}
}
