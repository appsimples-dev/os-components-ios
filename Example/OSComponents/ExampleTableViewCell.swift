//
//  ExampleTableViewCell.swift
//  OSComponents
//
//  Created by AppSimples on 15/08/18.
//  Copyright © 2018 OutSmart. All rights reserved.
//

import UIKit
import Reusable

class ExampleTableViewCell: UITableViewCell, NibReusable {

    @IBOutlet weak var label: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.selectionStyle = .none
    }

    func configWith(model: ExampleModel) {
        label.text = model.title
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

struct ExampleModel {
    var title: String
    
    init(title: String) {
        self.title = title
    }
}
