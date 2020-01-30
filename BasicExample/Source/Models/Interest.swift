//
//  Interest.swift
//  BasicExample
//
//  Created by Serik on 29.01.2020.
//  Copyright © 2020 Serik_Klement. All rights reserved.
//

import Foundation

class InteresList: Decodable {
    enum CodingKeys: String, CodingKey {
        case data
    }
    let data: [Interest]
}

class Interest: Codable, Equatable {
    let filled: Bool? = false

    var id: Int?
    var name: String?
    
    enum CodingKeys: String, CodingKey {
        case id, name
    }

    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        self.id = try? values.decode(Int.self, forKey: .id)
        self.name = try? values.decode(String.self, forKey: .name)
    }

    static func == (lhs: Interest, rhs: Interest) -> Bool {
        return lhs.id == rhs.id
    }
}
