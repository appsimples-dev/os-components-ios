//
//  SimpleCellConfiguration.swift
//  OSComponents
//
//  Created by AppSimples on 15/08/18.
//  Copyright © 2018 OutSmart. All rights reserved.
//

import Foundation
import UIKit
import OSComponents

class SimpleCellConfiguration {
    class func configNotificationCell() -> OSSimpleCellConfiguration {
        var cellConfiguration = OSSimpleCellConfiguration()
        cellConfiguration.primaryTextColor = UIColor.black
        cellConfiguration.secondaryTextColor = UIColor.gray
        cellConfiguration.buttonsType = OSCellButtonsTypes.none
        return cellConfiguration
    }
    
    class func configFollowCell() -> OSSimpleCellConfiguration {
        var cellConfiguration = configNotificationCell()
        cellConfiguration.buttonColor = UIColor.fromRGBA(r: 15, g: 195, b: 172, a: 1)
        cellConfiguration.selectedButtonColor = UIColor.fromRGBA(r: 15, g: 195, b: 172, a: 1)
        cellConfiguration.selectedButtonTextColor = UIColor.white
        cellConfiguration.buttonText = "seguir"
        cellConfiguration.buttonsType = OSCellButtonsTypes.single
        cellConfiguration.selectedButtonText = "seguindo"
        return cellConfiguration
    }
    
    class func configAddCell() -> OSSimpleCellConfiguration {
        var cellConfiguration = configNotificationCell()
        cellConfiguration.leftButtonIcon = #imageLiteral(resourceName: "close")
        cellConfiguration.leftButtonColor = UIColor.gray
        cellConfiguration.rightButtonIcon = #imageLiteral(resourceName: "check")
        cellConfiguration.rightButtonColor = UIColor.gray
        cellConfiguration.buttonsType = OSCellButtonsTypes.double
        return cellConfiguration
    }
    
    class func configCommentCell() -> OSSimpleCellConfiguration {
        var cellConfiguration = OSSimpleCellConfiguration()
        cellConfiguration.primaryTextColor = UIColor.black
        cellConfiguration.secondaryTextColor = UIColor.gray
        cellConfiguration.buttonsType = OSCellButtonsTypes.none
        cellConfiguration.moreButton = true
        return cellConfiguration
    }
}
