//
//  ArticlesData.swift
//  GOSU
//
//  Created by Tanya Tomchuk on 03/02/2018.
//  Copyright © 2018 Tanya Tomchuk. All rights reserved.
//

import Foundation
import FirebaseDatabase
import SwiftyJSON


class ArticlesData {

    var title: String?
    var pictureURL: String?
    var description: String?
    var body: String?
    var category_id: Int?
    var video_link: String?


    func setArticles(_ json: JSON) {
        self.title = json["title"].string
        self.description = json["description"].string
        self.category_id = json["category_id"].int
        self.body = json["body"].string
        self.video_link = json["video_link"].string

        let image = json["picture"].dictionary
        let imageData = image?["data"]?.dictionary
        self.pictureURL = imageData?["url"]?.string
    }


    init(title: String?, description: String?, pictureURL: String?, category_id: Int?, body: String?, video_link: String?){
        self.title = title
        self.pictureURL = pictureURL
        self.description = description
        self.category_id = category_id
        self.body = body
        self.video_link = video_link
    }

}
