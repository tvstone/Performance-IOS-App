//
//  likeFoto.swift
//  MyVKclient
//
//  Created by Владислав Тихоненков on 24.08.2021.
//

import Foundation
import RealmSwift

class Likes: Object  {

    @objc dynamic var idFoto = String()
    @objc dynamic var like = String()



    convenience init(idFoto : String, like : String) {
        self.init()
        self.idFoto = idFoto
        self.like = like

    }

    override class func primaryKey() -> String? {
        return "idFoto"
    }
}

