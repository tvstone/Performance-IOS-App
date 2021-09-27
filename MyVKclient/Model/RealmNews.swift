//
//  RealmNews.swift
//  MyVKclient
//
//  Created by Владислав Тихоненков on 29.08.2021.
//

import Foundation
import RealmSwift

final class RealmNews: Object  {

    @objc dynamic var idGroup = String()
    @objc dynamic var nameGroup = String()
<<<<<<< HEAD
<<<<<<< HEAD
=======
    @objc dynamic var avaGroup = String()
>>>>>>> lesson2
=======
    @objc dynamic var avaGroup = String()
>>>>>>> lesson3
    @objc dynamic var textNews = String()
    @objc dynamic var imageNews = String()
    @objc dynamic var dateNews = String()
    @objc dynamic var likeNewsCount = String()
    @objc dynamic var commentsNewsCount = String()
    @objc dynamic var repostNewsCount = String()


<<<<<<< HEAD
<<<<<<< HEAD
    convenience init(idGroup : String, nameGroup : String, textNews : String, imageNews : String,
=======
    convenience init(idGroup : String, nameGroup : String, avaGroup : String, textNews : String, imageNews : String,
>>>>>>> lesson2
=======
    convenience init(idGroup : String, nameGroup : String, avaGroup : String, textNews : String, imageNews : String,
>>>>>>> lesson3
                     dateNews : String, likeNewsCount : String,
                     commentsNewsCount : String, repostNewsCount : String) {
        self.init()
        self.idGroup = idGroup
        self.nameGroup = nameGroup
<<<<<<< HEAD
<<<<<<< HEAD
=======
        self.avaGroup = avaGroup
>>>>>>> lesson2
=======
        self.avaGroup = avaGroup
>>>>>>> lesson3
        self.textNews = textNews
        self.imageNews = imageNews
        self.dateNews = dateNews
        self.likeNewsCount = likeNewsCount
        self.commentsNewsCount = commentsNewsCount
        self.repostNewsCount = repostNewsCount

    }
}
