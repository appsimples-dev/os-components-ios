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

public protocol OSSimpleTableViewCellDelegate: class {
    func singleButtonClickFor(indexPath: IndexPath?)
    func leftButtonClickFor(indexPath: IndexPath?)
    func rightButtonClickFor(indexPath: IndexPath?)
    func moreButtonClickFor(indexPath: IndexPath?)
    func titleClickFor(indexPath: IndexPath?)
    func imageClickFor(indexPath: IndexPath?)
}

public class OSSimpleTableViewCell: UITableViewCell, NibReusable {
    
    @IBOutlet weak var cellImage: OSCellImage!
    @IBOutlet weak var cellInfo: OSCellInfo!
    @IBOutlet weak var cellButtons: OSCellButtons!
    @IBOutlet weak var buttonWidth: NSLayoutConstraint!
    @IBOutlet weak var buttonHeight: NSLayoutConstraint!
    weak var delegate: OSSimpleTableViewCellDelegate?
    var indexPath: IndexPath?
    
    public override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        // Initialization code
    }
    
    public func configWith(cellConfiguration: OSSimpleCellConfiguration, cellData: OSSimpleCellData, delegate: OSSimpleTableViewCellDelegate?, indexPath: IndexPath) {
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
    
    public override func prepareForReuse() {
        buttonWidth.constant = 110.0
        buttonHeight.constant = 36.0
        cellButtons.isHidden = false
    }
}

extension OSSimpleTableViewCell: OSCellButtonsDelegate {
    public func onClick() {
        delegate?.singleButtonClickFor(indexPath: indexPath)
    }
    
    public func onLeftClick() {
        delegate?.leftButtonClickFor(indexPath: indexPath)
    }
    
    public func onRightClick() {
        delegate?.rightButtonClickFor(indexPath: indexPath)
    }
}

extension OSSimpleTableViewCell: OSCellInfoDelegate {
   public  func titleClick() {
        delegate?.titleClickFor(indexPath: indexPath)
    }
    
    public func moreButtonClick() {
        delegate?.moreButtonClickFor(indexPath: indexPath)
    }
}

extension OSSimpleTableViewCell: OSCellImageDelegate {
    public func imageClick() {
        delegate?.imageClickFor(indexPath: indexPath)
    }
}

// MARK: models

public struct OSSimpleCellConfiguration {
    public var primaryImagePlaceholder: UIImage?
    public var secondaryImagePlaceholder: UIImage?
    public var primaryTextColor: UIColor?
    public var secondaryTextColor: UIColor?
    public var tertiaryTextColor: UIColor?
    public var textSelectable: Bool?
    public var buttonColor: UIColor?
    public var leftButtonColor: UIColor?
    public var rightButtonColor: UIColor?
    public var buttonText: String?
    public var leftButtonIcon: UIImage?
    public var rightButtonIcon: UIImage?
    public var buttonsType: OSCellButtonsTypes = OSCellButtonsTypes.single
    public var selectedButtonColor: UIColor?
    public var selectedButtonTextColor: UIColor?
    public var selectedButtonText: String?
    public var selected: Bool = false
    public var moreButton: Bool = false
    
    public init(){
    }
}

public struct OSSimpleCellData: Mappable {
    public var primaryImage: String?
    public var secondaryImage: String?
    public var primaryText: String = ""
    public var secondaryText: String?
    public var tertiaryText: String?
    public var selected: Bool?
    
    public init() {
    }
    
    public init?(map: Map) {
    }
    
    public mutating func mapping(map: Map) {
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
