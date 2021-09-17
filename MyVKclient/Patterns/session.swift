//
//  session.swift
//  MyVKclient
//
//  Created by Владислав Тихоненков on 03.08.2021.
//

import Foundation

final class Session{
    static let shared = Session()
    
    var token: String = ""
    var userId: String  = ""
  
}
