//
//  RealmMyFoto.swift
//  MyVKclient
//
//  Created by Владислав Тихоненков on 27.08.2021.
//

import Foundation
import RealmSwift

final class RealmMyFoto: Object  {

    @objc dynamic var allMyFotos = String()
    @objc dynamic var idFoto = String()
    @objc dynamic var like = String()


    convenience init(idFoto : String, allMyFotos : String, like :String) {
        self.init()
        self.idFoto = idFoto
        self.allMyFotos = allMyFotos
        self.like = like
    }

    override class func primaryKey() -> String? {
        return "idFoto"
    }
}

