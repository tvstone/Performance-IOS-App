//
//  group.swift
//  MyVKclient
//
//  Created by Владислав Тихоненков on 27.06.2021.
//

import Foundation

struct Group {
    var idGroup : String
    var titleGroup : String
    var avaGroup : String

}
struct GroupsForNews : Hashable {
    var idGroup : String
    var nameGroup : String
    var avaGroup : String
    var textNews :String
    var imageNews : String
    var dateNews : String
    var likeNewsCount : String
    var commentsNewsCount : String
    var repostNewsCount : String
}

