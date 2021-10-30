//
//  RealmNews.swift
//  MyVKclient
//
//  Created by Владислав Тихоненков on 29.08.2021.
//

import Foundation
import RealmSwift

final class RealmNews: Object  {

    @objc dynamic var idSource = String()
    @objc dynamic var nameGroup = String()
    @objc dynamic var avaGroup = String()
    @objc dynamic var textNews = String()
    @objc dynamic var imageNews = String()
    @objc dynamic var dateNews = String()
    @objc dynamic var likeNewsCount = String()
    @objc dynamic var commentsNewsCount = String()
    @objc dynamic var repostNewsCount = String()
    @objc dynamic var viewsNews = String()
    @objc dynamic var width = String()
    @objc dynamic var height = String()



    convenience init(idGroup : String, nameGroup : String, avaGroup : String, textNews : String, imageNews : String,
                     dateNews : String, likeNewsCount : String,
                     commentsNewsCount : String, repostNewsCount : String, viewsNews : String, width : String,
                     height : String) {
        self.init()
        self.idSource = idGroup
        self.nameGroup = nameGroup
        self.avaGroup = avaGroup
        self.textNews = textNews
        self.imageNews = imageNews
        self.dateNews = dateNews
        self.likeNewsCount = likeNewsCount
        self.commentsNewsCount = commentsNewsCount
        self.repostNewsCount = repostNewsCount
        self.viewsNews = viewsNews
        self.width = width
        self.height = height

    }
}
