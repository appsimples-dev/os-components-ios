//
//  NotificationModel.swift
//  OSComponents
//
//  Created by AppSimples on 15/08/18.
//  Copyright © 2018 OutSmart. All rights reserved.
//

import Foundation
import ObjectMapper
import OSComponents

enum NotificationType {
    case add
    case follow
    case text
}

struct NotificationModel: Mappable {
    var image: String = ""
    var title: String = ""
    var subtitle: String?
    var isFollowing: Bool?
    var type: NotificationType = .add
    
    init(image: String, title: String, subtitle: String?, isFollowing: Bool?, type: NotificationType) {
        self.image = image
        self.subtitle = subtitle
        self.title = title
        self.isFollowing = isFollowing
        self.type = type
    }
    
    init?(map: Map) {
    }
    
    mutating func mapping(map: Map) {
    }
    
    func mapToCell() -> OSSimpleCellData {
        var data = OSSimpleCellData()
        data.primaryImage = image
        data.primaryText = title
        data.secondaryText = subtitle
        data.selected = isFollowing
        return data
    }
}
