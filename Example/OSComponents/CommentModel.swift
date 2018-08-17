//
//  NotificationModel.swift
//  baseproject
//
//  Created by AppSimples on 14/08/18.
//  Copyright © 2018 Outsmart. All rights reserved.
//

import Foundation
import ObjectMapper

struct CommentModel: Mappable {
    var image: String = ""
    var comment: String = ""
    var username: String = ""
    
    init(image: String, comment: String, username: String) {
        self.image = image
        self.comment = comment
        self.username = username
    }
    
    init?(map: Map) {
    }
    
    mutating func mapping(map: Map) {
    }
    
    func mapToCell() -> OSSimpleCellData {
        var data = OSSimpleCellData()
        data.primaryImage = image
        data.primaryText = username
        data.secondaryText = comment
        return data
    }
}
