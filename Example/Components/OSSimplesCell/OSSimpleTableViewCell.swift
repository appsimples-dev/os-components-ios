//
//  OSSimpleTableViewCell.swift
//  baseproject
//
//  Created by AppSimples on 08/08/18.
//  Copyright © 2018 Outsmart. All rights reserved.
//

import UIKit
import Reusable
import ObjectMapper

protocol OSSimpleTableViewCellDelegate: class {
    func singleButtonClickFor(indexPath: IndexPath?)
    func leftButtonClickFor(indexPath: IndexPath?)
    func rightButtonClickFor(indexPath: IndexPath?)
    func moreButtonClickFor(indexPath: IndexPath?)
    func titleClickFor(indexPath: IndexPath?)
    func imageClickFor(indexPath: IndexPath?)
}

class OSSimpleTableViewCell: UITableViewCell, NibReusable {
    
    @IBOutlet weak var cellImage: OSCellImage!
    @IBOutlet weak var cellInfo: OSCellInfo!
    @IBOutlet weak var cellButtons: OSCellButtons!
    @IBOutlet weak var buttonWidth: NSLayoutConstraint!
    @IBOutlet weak var buttonHeight: NSLayoutConstraint!
    weak var delegate: OSSimpleTableViewCellDelegate?
    var indexPath: IndexPath?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        // Initialization code
    }
    
    func configWith(cellConfiguration: OSSimpleCellConfiguration, cellData: OSSimpleCellData, delegate: OSSimpleTableViewCellDelegate?, indexPath: IndexPath) {
        configImage(configuration: cellConfiguration, data: cellData)
        configInfo(configuration: cellConfiguration, data: cellData)
        configButtons(configuration: cellConfiguration, data: cellData)
        self.delegate = delegate
        self.indexPath = indexPath
        self.layoutIfNeeded()
    }
    
    private func configImage(configuration: OSSimpleCellConfiguration, data: OSSimpleCellData) {
        cellImage.setPrimaryImage(imageUrl: data.primaryImage, placeholder: configuration.primaryImagePlaceholder, delegate: self)
        cellImage.setSecondaryImage(imageUrl: data.secondaryImage, placeholder: configuration.secondaryImagePlaceholder)
    }
    
    private func configInfo(configuration: OSSimpleCellConfiguration, data: OSSimpleCellData) {
        cellInfo.setPrimaryText(text: data.primaryText)
        cellInfo.setSecondaryText(text: data.secondaryText)
        cellInfo.setTertiaryText(text: data.tertiaryText)
        cellInfo.config(primaryColor: configuration.primaryTextColor, secondaryColor: configuration.secondaryTextColor, selectable: configuration.textSelectable, delegate: self, showButton: configuration.moreButton)
    }
    
    private func configButtons(configuration: OSSimpleCellConfiguration, data: OSSimpleCellData) {
        if configuration.buttonsType == .none {
            cellButtons.hide()
            return
        }
        var btnData = OSCellButtonsData()
        btnData.text = configuration.buttonText
        btnData.color = configuration.buttonColor
        btnData.rightColor = configuration.rightButtonColor
        btnData.rightIcon = configuration.rightButtonIcon
        btnData.leftColor = configuration.leftButtonColor
        btnData.leftIcon = configuration.leftButtonIcon
        btnData.selectedColor = configuration.selectedButtonColor
        btnData.selectedTextColor = configuration.selectedButtonTextColor
        btnData.selectedText = configuration.selectedButtonText
        btnData.selected = data.selected ?? false
        cellButtons.configWith(delegate: self, data: btnData, type: configuration.buttonsType)
    }
    
    override func prepareForReuse() {
        buttonWidth.constant = 110.0
        buttonHeight.constant = 36.0
        cellButtons.isHidden = false
    }
}

extension OSSimpleTableViewCell: OSCellButtonsDelegate {
    func onClick() {
        delegate?.singleButtonClickFor(indexPath: indexPath)
    }
    
    func onLeftClick() {
        delegate?.leftButtonClickFor(indexPath: indexPath)
    }
    
    func onRightClick() {
        delegate?.rightButtonClickFor(indexPath: indexPath)
    }
}

extension OSSimpleTableViewCell: OSCellInfoDelegate {
    func titleClick() {
        delegate?.titleClickFor(indexPath: indexPath)
    }
    
    func moreButtonClick() {
        delegate?.moreButtonClickFor(indexPath: indexPath)
    }
}

extension OSSimpleTableViewCell: OSCellImageDelegate {
    func imageClick() {
        delegate?.imageClickFor(indexPath: indexPath)
    }
}

// MARK: models

struct OSSimpleCellConfiguration {
    var primaryImagePlaceholder: UIImage?
    var secondaryImagePlaceholder: UIImage?
    var primaryTextColor: UIColor?
    var secondaryTextColor: UIColor?
    var tertiaryTextColor: UIColor?
    var textSelectable: Bool?
    var buttonColor: UIColor?
    var leftButtonColor: UIColor?
    var rightButtonColor: UIColor?
    var buttonText: String?
    var leftButtonIcon: UIImage?
    var rightButtonIcon: UIImage?
    var buttonsType: OSCellButtonsTypes = OSCellButtonsTypes.single
    var selectedButtonColor: UIColor?
    var selectedButtonTextColor: UIColor?
    var selectedButtonText: String?
    var selected: Bool = false
    var moreButton: Bool = false
}

struct OSSimpleCellData: Mappable {
    var primaryImage: String?
    var secondaryImage: String?
    var primaryText: String = ""
    var secondaryText: String?
    var tertiaryText: String?
    var selected: Bool?
    
    init() {
    }
    
    init?(map: Map) {
    }
    
    mutating func mapping(map: Map) {
        primaryImage <- map["primaryImage"]
        secondaryImage <- map["secondaryImage"]
        primaryText <- map["primaryText"]
        secondaryText <- map["secondaryText"]
        tertiaryText <- map["tertiaryText"]
        selected <- map["selected"]
    }
    
    static func fromJson(_ json: String?) -> OSSimpleCellData {
        if let json = json, let data = Mapper<OSSimpleCellData>().map(JSONString: json) {
            return data
        } else {
            return OSSimpleCellData()
        }
    }
}
