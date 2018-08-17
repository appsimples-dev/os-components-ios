//
//  ComponentsListCell.swift
//  OSComponents
//
//  Created by AppSimples on 15/08/18.
//  Copyright © 2018 OutSmart. All rights reserved.
//

import UIKit
import Reusable

protocol ComponentListCellDelegate: class {
    func didSelectButtonFor(model: ComponentListCellModel?)
}

class ComponentsListCell: UITableViewCell, NibReusable {
    
    @IBOutlet weak var cellButton: UIButton!
    weak var delegate: ComponentListCellDelegate?
    var model: ComponentListCellModel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        cellButton.layer.borderWidth = 1.0
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configWith(model: ComponentListCellModel, delegate: ComponentListCellDelegate) {
        self.cellButton.setTitle(model.viewController.nibName, for: .normal)
        self.delegate = delegate
        self.model = model
    }
    
    @IBAction func onButtonClick(_ sender: Any) {
        delegate?.didSelectButtonFor(model: model)
    }
    
}

struct ComponentListCellModel {
    var viewController: UIViewController
    
    init(viewController: UIViewController) {
        self.viewController = viewController
    }
}
