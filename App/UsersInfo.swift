//
//  UsersData.swift
//  NavigationControllerHW
//
//  Created by Anastasiya Orlova on 07.06.2024.
//

import Foundation

struct UserInfo {
    let name: String?
    let fullName: String?
    let position: String?
}

class UsersList {
    
    let users: [UserInfo] = [
        UserInfo(name: "Антон", fullName: "Антонов Антон Антонович", position: "QA Engineer"),
        UserInfo(name: "Иван", fullName: "Иванов Иван Иванович", position: "Team Lead"),
        UserInfo(name: "Павел", fullName: "Павлов Павел Павлович", position: "Developer"),
        UserInfo(name: "Петр", fullName: "Петров Петр Петрович", position: "Data Scientist")
    ]
}



