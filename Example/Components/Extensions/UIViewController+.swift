//
//  UIViewController+.swift
//  OSComponents
//
//  Created by AppSimples on 15/08/18.
//  Copyright © 2018 OutSmart. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    func presentAlertSheetWith(title: String, description: String, actions: [UIAlertAction]) {
        let alertController = UIAlertController(title: title, message: description, preferredStyle: .actionSheet)
        actions.forEach { (action) in
            alertController.addAction(action)
        }
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(alertController, animated: true, completion: nil)
    }
}
