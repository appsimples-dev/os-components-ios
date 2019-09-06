//
//  NotificationModel.swift
//  baseproject
//
//  Created by AppSimples on 14/08/18.
//  Copyright © 2018 Outsmart. All rights reserved.
//

import Foundation
import ObjectMapper
import OSComponents

struct CommentModel: Mappable {
    var image: String = ""
    var comment: String = ""
    var username: String = ""
    var timeAgo: String = ""
    var edited: String = ""
    
    init(image: String, comment: String, username: String, timeAgo: String, edited: String) {
        self.image = image
        self.comment = comment
        self.username = username
        self.timeAgo = timeAgo
        self.edited = edited
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
        data.tertiaryText = timeAgo
        data.quarternaryText = edited
        return data
    }
}
