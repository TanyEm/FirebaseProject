//
//  CategoriesData.swift
//  GOSU
//
//  Created by Tanya Tomchuk on 31/01/2018.
//  Copyright © 2018 Tanya Tomchuk. All rights reserved.
//

import Foundation
import FirebaseDatabase

class CategoriesData {

    var name: String?
    //var image: String?
    var description: String?


    init(name: String?, description: String?){
        self.name = name
        //self.image = image
        self.description = description
    }

}
