//
//  NetworkNews.swift
//  MyVKclient
//
//  Created by Владислав Тихоненков on 29.08.2021.
//

import Foundation
import Alamofire
import SwiftyJSON
import RealmSwift

final class NetworkNews {

    private let baseUrl = "https://api.vk.com/method"
    private let method = "/newsfeed.get"
    private var urlNews = String()
    private var textNews = String()
    private var dateNews = String()
    private var likeNewsCount = String()
    private var commentsNewsCount = String()
    private var repostNewsCount = String()
    private var viewsNews = String()
    private var params: Parameters = [:]
    private let dateFormatter : DateFormatter = {
        let df = DateFormatter()
        df.dateFormat = "dd.MM.yyyy HH:mm"
        return df
    }()
    private var width = ""
    private var height = ""

    private let realm = try! Realm(configuration: Realm.Configuration(deleteRealmIfMigrationNeeded: true))

    init() {

        let session = Session.shared

        self.params = [
            "user_id": session.userId,
            "access_token": session.token,
            "v": session.version,
            "filters": "post",
            "count": "20",
        ]

    }

    func newsRequest(startFrom: String = "",
                     startTime: Double? = nil,
                     completion: @escaping ([News], _ nextFrom : String) -> Void){

        params["start_from"] = startFrom
        if let startTime = startTime {
            params["start_time"] = startTime
        }

        let newsModel = NewsModel()
        var idSourse = ""
        var ava = ""
        var name = ""
        newsModel.newsArray = [News]()

        AF.request(baseUrl + method, method: .get, parameters: params).responseJSON(queue: .global()) { response in
            switch response.result {
            case .failure(let error):
                print(error)
            case .success(let value):
                let json = JSON(value)
      //          print(value)
                var friends = [ShotProfileFriends]()
                var groups = [Group]()
                let nextFrom = json["response"]["next_from"].stringValue

                let parsingGroup = DispatchGroup()
                DispatchQueue.global().async(group: parsingGroup) {
                    let myProfile = json["response"]["profiles"].arrayValue

                    myProfile.forEach { prof in
                        let first_name = prof["first_name"].stringValue
                        let id = prof["id"].stringValue
                        let photo_100 = prof["photo_100"].stringValue
                        let singleProfile = ShotProfileFriends(photo_100: photo_100, id: id, first_name: first_name)
                        friends.append(singleProfile)

                    }
                }
                DispatchQueue.global().async(group: parsingGroup) {

                    let allGroups = json["response"]["groups"].arrayValue

                    allGroups.forEach { gr in
                        let id = gr["id"].stringValue
                        let name = gr["name"].stringValue
                        let photo_200 = gr["photo_200"].stringValue
                        let group = Group(idGroup: id, titleGroup: name, avaGroup: photo_200)
                        groups.append(group)
                    }
                }

                parsingGroup.notify(queue: .global()) { [weak self] in
                    guard let self = self else {return}
                    let news = json["response"]["items"].arrayValue

                    news.forEach { newsItem in
                        let source_id = newsItem["source_id"].intValue
                        self.textNews = newsItem["text"].stringValue
                        let dNews = Date(timeIntervalSince1970: newsItem["date"].doubleValue)
                        self.dateNews = self.dateFormatter.string(from: dNews)
                        self.likeNewsCount = newsItem["likes"]["count"].stringValue
                        self.commentsNewsCount = newsItem["comments"]["count"].stringValue
                        self.repostNewsCount = newsItem["reposts"]["count"].stringValue
                        self.viewsNews = newsItem["views"]["count"].stringValue
                        guard let attachments = newsItem["attachments"].arrayValue.first else {return}

                        guard let sizesArray = attachments["photo"]["sizes"].array,
                              let xSize = sizesArray.first(where: { $0["type"].stringValue == "x" }) else {return}
                        self.urlNews = xSize["url"].stringValue
                        self.width = xSize["width"].stringValue
                        self.height = xSize["height"].stringValue

                        if source_id > 0,
                           let source = friends.first(where: { $0.id == String(source_id) }) {
                            idSourse = source.id
                            ava = source.photo_100
                            name = source.first_name

                        } else {
                            guard let source = groups.first(where: { $0.idGroup == String(-source_id) }) else{return}
                            idSourse = source.idGroup
                            ava = source.avaGroup
                            name = source.titleGroup
                        }

                        let newElement = News(idSource: idSourse,
                                              avaGroup: ava,
                                              nameGroup: name,
                                              titleNews: self.textNews,
                                              imageNews: self.urlNews,
                                              dateNews: self.dateNews,
                                              likeNews: self.likeNewsCount,
                                              commentNews: self.commentsNewsCount,
                                              repostNews: self.repostNewsCount,
                                              viewsNews: self.viewsNews,
                                              width : self.width,
                                              height: self.height)
                        newsModel.newsArray.append(newElement)
                    }
                       DispatchQueue.main.async {
                           completion(newsModel.newsArray, nextFrom)
                       }
                   }
               }
           }
       }

}

