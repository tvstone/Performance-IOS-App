//
//  news.swift
//  MyVKclient
//
//  Created by Владислав Тихоненков on 04.07.2021.
//


import UIKit
import RealmSwift

struct News{
<<<<<<< HEAD
<<<<<<< HEAD
=======
    var avaGroup : String
    var nameGroup : String
>>>>>>> lesson2
=======
    var avaGroup : String
    var nameGroup : String
>>>>>>> lesson3
    var titleNews : String
    var imageNews : String
    var dateNews : String
    var likeNews : String
    var commentNews : String
    var repostNews : String
}

final class NewsModel {
    public var newsArray = [News]()
    private var news : Results<RealmNews>!
    private let realm = try! Realm(configuration: Realm.Configuration(deleteRealmIfMigrationNeeded: true))


    init() {
        setupNews()
    }

    func setupNews() {

        news = realm.objects(RealmNews.self)

        for i in 0 ..< news.count {

<<<<<<< HEAD
<<<<<<< HEAD
=======
            let avaGroup = news[i].avaGroup
            let nameGroup = news[i].nameGroup
>>>>>>> lesson2
=======
            let avaGroup = news[i].avaGroup
            let nameGroup = news[i].nameGroup
>>>>>>> lesson3
            let textNews = news[i].textNews
            let imageNews = news[i].imageNews
            let dateNews = news[i].dateNews
            let likeNews = news[i].likeNewsCount
            let commentNews = news[i].commentsNewsCount
            let repostNews = news[i].repostNewsCount
<<<<<<< HEAD
<<<<<<< HEAD
            let newNews = News(titleNews: textNews, imageNews: imageNews, dateNews: dateNews, likeNews: likeNews,
=======
            let newNews = News(avaGroup : avaGroup, nameGroup: nameGroup, titleNews: textNews,
                               imageNews: imageNews, dateNews: dateNews, likeNews: likeNews,
>>>>>>> lesson2
=======
            let newNews = News(avaGroup : avaGroup, nameGroup: nameGroup, titleNews: textNews,
                               imageNews: imageNews, dateNews: dateNews, likeNews: likeNews,
>>>>>>> lesson3
                               commentNews: commentNews, repostNews: repostNews)
            newsArray.append(newNews)
        }
        
        



    }
}

