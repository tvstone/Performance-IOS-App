//
//  news.swift
//  MyVKclient
//
//  Created by Владислав Тихоненков on 04.07.2021.
//


import UIKit
import RealmSwift

struct News : Hashable{
    var idSource : String
    var avaGroup : String
    var nameGroup : String
    var titleNews : String
    var imageNews : String
    var dateNews : String
    var likeNews : String
    var commentNews : String
    var repostNews : String
    var viewsNews : String
    var width : String
    var height : String
}


final class NewsModel {
    public var newsArray = [News]()
    private var news : Results<RealmNews>!
    private let realm = try! Realm(configuration: Realm.Configuration(deleteRealmIfMigrationNeeded: true))


    init() {
        setupNewsRealm()
    }

    func setupNewsRealm() {

        self.news = realm.objects(RealmNews.self)

        for i in 0 ..< news.count {
            let idSourse = news[i].idSource
            let avaGroup = news[i].avaGroup
            let nameGroup = news[i].nameGroup
            let textNews = news[i].textNews
            let imageNews = news[i].imageNews
            let dateNews = news[i].dateNews
            let likeNews = news[i].likeNewsCount
            let commentNews = news[i].commentsNewsCount
            let repostNews = news[i].repostNewsCount
            let viewsNews = news[i].viewsNews
            let width = news[i].width
            let height = news[i].height
            let newNews = News(idSource : idSourse, avaGroup : avaGroup, nameGroup: nameGroup, titleNews: textNews,
                               imageNews: imageNews, dateNews: dateNews, likeNews: likeNews,
                               commentNews: commentNews, repostNews: repostNews,
                               viewsNews: viewsNews, width: width,
                               height: height)
            newsArray.append(newNews)
        }


    }


}

