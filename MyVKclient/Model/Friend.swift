//
//  File.swift
//  MyVKclient
//
//  Created by Владислав Тихоненков on 15.08.2021.
//
import Foundation

struct  Friend : Hashable {
    var nameFriend : String
    var avaFriend : String
    var fotos : [String]
    var like : [String]
    var idFriend : String
}

struct FriendId {
    var friendId : String
}

struct ShotProfileFriends {
    var photo_100 : String
    var id : String
    var first_name : String
}
