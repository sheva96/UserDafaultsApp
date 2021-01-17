//
//  Model.swift
//  UserDafaultsApp
//
//  Created by Yevhen Shevchenko on 17.01.2021.
//

import Foundation

struct Contact: Codable {
    let firstName: String
    let lastName: String
    var fullName: String {
        "\(firstName) \(lastName)"
    }
}
