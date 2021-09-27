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

    private let scheme = "https://"
    private let host = "api.vk.com/"
    private let token = Session.shared.token
    private let id = Session.shared.userId
    private let pathForNews = "method/wall.get"
    private var url = String()
    private var text = String()
    private var groupForNews = [Group]()
    private let realm = try! Realm(configuration: Realm.Configuration(deleteRealmIfMigrationNeeded: true))
    private var itemsGroupRealm : Results<RealmGroup>!


    func  myGroupNameForNews() -> [Group] {
        var itogArray = [Group]()
        itemsGroupRealm = realm.objects(RealmGroup.self)
        let countGroup = itemsGroupRealm.count

        for i in 0 ..< countGroup {
            let nameGroup = itemsGroupRealm[i].titleGroup
            let avaGroup = itemsGroupRealm[i].avaGroup
            let idGroup = itemsGroupRealm[i].idGroup
            let group = Group(idGroup: idGroup, titleGroup: nameGroup, avaGroup: avaGroup)
            itogArray.append(group)
        }
        itogArray = itogArray.sorted(by:{ $0.titleGroup < $1.titleGroup})
        return itogArray
    }


    func pingMyNews(idGroup : String) {

        let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd.MM.yyyy HH:mm"

            groupForNews = myGroupNameForNews()

        let parametersListPhotosFriend : Parameters = [
            "owner_id" : "-\(idGroup)",
<<<<<<< HEAD
            "count" : "3",
=======
            "count" : "5",
>>>>>>> lesson3
            "access_token" : token,
            "v" : "5.131"
        ]
        AF.request(scheme + host + pathForNews ,
                   method: .get,
                   parameters: parametersListPhotosFriend).responseJSON { [weak self] response in
                    guard let self = self else {return}
                    switch response.result {
                    case .failure(let error):
                        print(error)
                    case .success(let data):
                        guard let clearJsonFriendFotos = JSON(rawValue: data) else {return}
                //        print(data)
                        let items = clearJsonFriendFotos["response"]["items"].arrayValue

                        for i in 0 ..< items.count {
                            let text1 = items[i]["text"].stringValue
                            let text2 = items[i]["attachments"]["title"].stringValue
                            let dNews = Date(timeIntervalSince1970: items[i]["date"].doubleValue)
                            let dateNews = dateFormatter.string(from: dNews)
                            let likesNews = items[i]["likes"]["count"].stringValue
                            let comments = items[i]["comments"]["count"].stringValue
                            let repost = items[i]["reposts"]["count"].stringValue

                            if text1 != "" {
                                self.text = text1
                            } else {self.text = text2}
                            let attachments = items[i]["attachments"].arrayValue
                            let count = attachments.count

                            for j in 0 ..< count{
                                let size = attachments[j]["photo"]["sizes"].arrayValue
                                let size2 = attachments[j]["video"]["image"].arrayValue

                                if size != [] {
                                    guard let urlNews = size.last?["url"].stringValue else {return}
                                    self.url = urlNews
                                }
                                else {
                                    guard let urlNews = size2.last?["url"].stringValue else {return}
                                    self.url = urlNews
                                }

                                for i in 0 ..< self.groupForNews.count {
                                    if self.groupForNews[i].idGroup == idGroup {
                                        let nameGroup = self.groupForNews[i].titleGroup
<<<<<<< HEAD
<<<<<<< HEAD
                                        self.saveMyNewsToRealm(idGroup: idGroup,
                                                               nameGroup : nameGroup,
=======
=======
>>>>>>> lesson3
                                        let avaGroup = self.groupForNews[i].avaGroup
                                        self.saveMyNewsToRealm(idGroup: idGroup,
                                                               nameGroup : nameGroup,
                                                               avaGroup : avaGroup ,
<<<<<<< HEAD
>>>>>>> lesson2
=======
>>>>>>> lesson3
                                                               textNews: self.text, imageNews: self.url,
                                                               dateNews: dateNews, likeNewsCount: likesNews,
                                                               commentsNewsCount: comments, repostNewsCount: repost)
                                    }
                                }

                            }
                        }
                    }
            }
    }

<<<<<<< HEAD
<<<<<<< HEAD
    func saveMyNewsToRealm (idGroup : String, nameGroup : String, textNews : String, imageNews : String,
                            dateNews : String, likeNewsCount : String,
=======
    func saveMyNewsToRealm (idGroup : String, nameGroup : String, avaGroup : String, textNews : String,
                            imageNews : String, dateNews : String, likeNewsCount : String,
>>>>>>> lesson2
=======
    func saveMyNewsToRealm (idGroup : String, nameGroup : String, avaGroup : String, textNews : String,
                            imageNews : String, dateNews : String, likeNewsCount : String,
>>>>>>> lesson3
                            commentsNewsCount : String, repostNewsCount : String){

        do {
            let realm = try Realm(configuration: Realm.Configuration(deleteRealmIfMigrationNeeded: true))
            realm.beginWrite()
<<<<<<< HEAD
<<<<<<< HEAD
            let loadNewsRealm = RealmNews(idGroup: idGroup,nameGroup : nameGroup, textNews: textNews, imageNews: imageNews, dateNews: dateNews,
=======
            let loadNewsRealm = RealmNews(idGroup: idGroup, nameGroup : nameGroup,
                                          avaGroup : avaGroup, textNews: textNews,
                                          imageNews: imageNews, dateNews: dateNews,
>>>>>>> lesson2
=======
            let loadNewsRealm = RealmNews(idGroup: idGroup, nameGroup : nameGroup,
                                          avaGroup : avaGroup, textNews: textNews,
                                          imageNews: imageNews, dateNews: dateNews,
>>>>>>> lesson3
                                          likeNewsCount: likeNewsCount, commentsNewsCount: commentsNewsCount,
                                          repostNewsCount: repostNewsCount)
            
            realm.add(loadNewsRealm)
            realm.refresh()

            try realm.commitWrite()
        } catch {
            print(error)
        }
    }

    func deleteMyNewsToRealm (remainingGroupsId : [String]){

        do {
            let realm = try Realm(configuration: Realm.Configuration(deleteRealmIfMigrationNeeded: true))
            realm.beginWrite()
            let delNewsInRealm = realm.objects(RealmNews.self)
                realm.delete(delNewsInRealm)
            for i in 0 ..< remainingGroupsId.count {
                pingMyNews(idGroup: remainingGroupsId[i])
            }
            try realm.commitWrite()
        } catch {
            print(error)
        }
    }


}


