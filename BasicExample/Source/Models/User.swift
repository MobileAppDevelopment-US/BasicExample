//
//  User.swift
//  BasicExample
//
//  Created by Serik on 28.01.2020.
//  Copyright © 2020 Serik_Klement. All rights reserved.
//

import UIKit

class UserData: Decodable {
    enum CodingKeys: String, CodingKey {
        case data
    }
    let data: User
}

class User: Codable {
    
    static var me : User?

    var id: Int?
    var name: String?
    var email: String?
    var password: String?
    var dateOfBirth: String?
    var gender: String?
    var interests: [Interest]?
    var images: [Images]?
    var whereWork: String?
    var distance: Double?
    var avatar: UIImage?

    enum CodingKeys: String, CodingKey {
        case id, name, email, password, gender, interests, images, distance
        case dateOfBirth = "date_of_birth"
        case whereWork = "where_work"
    }

    var profilePhoto : String? {
        return images?.first?.fullSrc
    }

    init(id: Int? = nil,
         name: String?,
         email: String?,
         password: String?,
         dateOfBirth: String?,
         gender: String?,
         interests: [Interest]? = nil,
         images: [Images]? = nil,
         whereWork: String? = nil,
         distance: Double? = nil,
         avatar: UIImage? = nil)

    {
        self.id = id
        self.name = name
        self.email = email
        self.password = password
        self.dateOfBirth = dateOfBirth
        self.gender = gender
        self.interests = interests
        self.images = images
        self.whereWork = whereWork
        self.distance = distance
        self.avatar = avatar
    }
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)

        self.id = try? values.decode(Int.self, forKey: .id)
        self.name = try? values.decode(String.self, forKey: .name)
        self.email = try? values.decode(String.self, forKey: .email)
        self.password = try? values.decode(String.self, forKey: .password)
        self.dateOfBirth = try? values.decode(String.self, forKey: .dateOfBirth)
        self.gender = try? values.decode(String.self, forKey: .gender)
        self.interests = try? values.decode([Interest].self, forKey: .interests)
        self.images = try? values.decode([Images].self, forKey: .images)
        self.whereWork = try? values.decode(String.self, forKey: .whereWork)
        self.distance = try? values.decode(Double.self, forKey: .distance)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container .encode(id, forKey: .id)
        try container .encode(name, forKey: .name)
        try container .encode(email, forKey: .email)
        try container .encode(password, forKey: .password)
        try container .encode(dateOfBirth, forKey: .dateOfBirth)
        try container .encode(gender, forKey: .gender)
        try container .encode(interests, forKey: .interests)
        try container .encode(images, forKey: .images)
        try container .encode(whereWork, forKey: .whereWork)
        try container .encode(distance, forKey: .distance)
    }

}

class Images: Codable {
    
    var id: Int?
    var name: String?
    var src: String?
    var cover: String?
    var fullSrc: String?

    enum CodingKeys: String, CodingKey {
        case id, name, src, cover
        case fullSrc = "full_src"
    }
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        self.id = try? values.decode(Int.self, forKey: .id)
        self.name = try? values.decode(String.self, forKey: .name)
        self.src = try? values.decode(String.self, forKey: .src)
        self.cover = try? values.decode(String.self, forKey: .cover)
        self.fullSrc = try? values.decode(String.self, forKey: .fullSrc)
    }
    
}
