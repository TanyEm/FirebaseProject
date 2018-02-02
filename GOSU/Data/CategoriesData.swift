//
//  CategoriesData.swift
//  GOSU
//
//  Created by Tanya Tomchuk on 31/01/2018.
//  Copyright © 2018 Tanya Tomchuk. All rights reserved.
//

import Foundation
import FirebaseDatabase
import SwiftyJSON


class CategoriesData {

    var name: String?
    var pictureURL: String?
    var description: String?
    var id: Int?

    func setCategories(_ json: JSON) {
        self.name = json["name"].string
        self.description = json["description"].string
        self.id = json["id"].int

        let image = json["picture"].dictionary
        let imageData = image?["data"]?.dictionary
        self.pictureURL = imageData?["url"]?.string
    }


    init(name: String?, description: String?, pictureURL: String?, id: Int?){
        self.name = name
        self.pictureURL = pictureURL
        self.description = description
        self.id = id
    }

}
