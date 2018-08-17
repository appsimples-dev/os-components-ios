//
//  UIView+.swift
//  OSComponents
//
//  Created by AppSimples on 15/08/18.
//  Copyright © 2018 OutSmart. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    func circularCorners() {
        self.layer.masksToBounds = false
        self.layer.cornerRadius = self.frame.size.width / 2
        self.clipsToBounds = true
    }
    
    func hide() {
        self.constraints.map {
            $0.constant = 0 // remove height and width
        }
        
        self.isHidden = true
    }
}
