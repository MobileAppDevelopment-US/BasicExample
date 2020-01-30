//
//  ListUsers.swift
//  BasicExample
//
//  Created by Serik on 29.01.2020.
//  Copyright © 2020 Serik_Klement. All rights reserved.
//

import Foundation

class DataListUsers: Decodable {
    enum CodingKeys: String, CodingKey {
        case data
    }
    let data: ListUsers
}

class ListUsers: Decodable {
    
    var currentPage: Int?
    let data: [User]?
    var total: Int?
    
    enum CodingKeys: String, CodingKey {
        case total, data
        case currentPage = "current_page"
    }
    
    init(currentPage: Int?,
         data: [User]?,
         total: Int?)
    {
        self.currentPage = currentPage
        self.data = data
        self.total = total
    }
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        self.currentPage = try? values.decode(Int.self, forKey: .currentPage)
        self.data = try? values.decode([User].self, forKey: .data)
        self.total = try? values.decode(Int.self, forKey: .total)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container .encode(currentPage, forKey: .currentPage)
        try container .encode(data, forKey: .data)
        try container .encode(total, forKey: .total)
    }
    
}
