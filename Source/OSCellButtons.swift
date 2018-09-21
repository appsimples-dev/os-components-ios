//
//  OSCellButtons.swift
//  baseproject
//
//  Created by AppSimples on 07/08/18.
//  Copyright © 2018 Outsmart. All rights reserved.
//

import Foundation
import UIKit

public protocol OSCellButtonsDelegate: class {
    func onClick()
    func onLeftClick()
    func onRightClick()
}

public enum OSCellButtonsTypes {
    case single
    case double
    case none
}

public class OSCellButtons: UIView {
    
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var centerButton: UIButton!
    @IBOutlet weak var leftButton: UIButton!
    @IBOutlet weak var rightButton: UIButton!
    weak var delegate: OSCellButtonsDelegate?
    var buttonsData: OSCellButtonsData?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    public func configWith(delegate: OSCellButtonsDelegate, data: OSCellButtonsData, type: OSCellButtonsTypes) {
        self.delegate = delegate
        buttonsData = data
        if type == OSCellButtonsTypes.single {
            configWithSingleButton(data: data)
        } else if type == OSCellButtonsTypes.double {
            configWithDoubleButton(data: data)
        }
    }
    
    private func configWithSingleButton(data: OSCellButtonsData) {
        clear(type: OSCellButtonsTypes.single)
        configButton(button: centerButton, color: data.color ?? UIColor.black, text: data.text ?? "")
        reloadLayout()
    }
    
    private func configWithDoubleButton(data: OSCellButtonsData) {
        clear(type: OSCellButtonsTypes.double)
        configButton(button: rightButton, color: data.rightColor ?? UIColor.black, text: "")
        configButton(button: leftButton, color: data.leftColor ?? UIColor.black, text: "")
        configImage(button: rightButton, image: data.rightIcon, color: data.rightColor ?? UIColor.black)
        configImage(button: leftButton, image: data.leftIcon, color: data.leftColor ?? UIColor.black)
        reloadLayout()
    }
    
    private func configImage(button: UIButton, image: UIImage?, color: UIColor) {
        guard let img = image else { return }
        button.setImage(img.withRenderingMode(UIImageRenderingMode.alwaysTemplate), for: .normal)
        button.tintColor = color
    }
    
    private func configButton(button: UIButton, color: UIColor, text: String) {
        button.isHidden = false
        button.titleLabel?.font =  UIFont.boldSystemFont(ofSize: 12)
        button.tintColor = color
        button.layer.borderColor = color.cgColor
        button.layer.borderWidth = 1.0
        button.layer.cornerRadius = button.frame.height/2
        button.layer.masksToBounds = true
        setButtonSelectionInfo(click: false)
    }
    
    @IBAction func centerButtonClick(_ sender: Any) {
        delegate?.onClick()
        if buttonsData?.selectedColor != nil {
            setButtonSelectionInfo(click: true)
        }
    }
    
    @IBAction func leftButtonClick(_ sender: Any) {
        delegate?.onLeftClick()
    }
    
    @IBAction func rightButtonClick(_ sender: Any) {
        delegate?.onRightClick()
    }
    
    func commonInit() {
        let podBundle = Bundle(for: self.classForCoder)
        podBundle.loadNibNamed("OSCellButtons", owner: self, options: nil)
        addSubview(contentView)
        setupFrames()
    }
    
    private func setButtonSelectionInfo(click: Bool) {
        guard var selected = buttonsData?.selected else { return }
        if click { selected = !selected }
        centerButton.backgroundColor = selected ? buttonsData?.selectedColor : UIColor.clear
        centerButton.setTitleColor(selected ? buttonsData?.selectedTextColor : buttonsData?.color, for: .normal)
        centerButton.setTitle(selected ? buttonsData?.selectedText : buttonsData?.text, for: .normal)
        buttonsData?.selected = selected
    }
    
    private func setupFrames() {
        contentView.frame.size.height = 0
        contentView.frame.size.width = 0
        contentView.layoutIfNeeded() // UPDATE ALL THE SUBVIEWS LAYOUT
    }
    
    func clear(type: OSCellButtonsTypes) {
        if type == OSCellButtonsTypes.single {
            leftButton.isHidden = true
            rightButton.isHidden = true
        } else {
            centerButton.isHidden = true
        }
    }
    
    private func reloadLayout() {
        contentView.frame = self.bounds
        contentView.layoutIfNeeded()
    }
}

public struct OSCellButtonsData {
    var type: OSCellButtonsTypes!
    var color: UIColor?
    var rightColor: UIColor?
    var leftColor: UIColor?
    var text: String?
    var leftIcon: UIImage?
    var rightIcon: UIImage?
    var selectedColor: UIColor?
    var selectedTextColor: UIColor?
    var selectedText: String?
    var selected: Bool = false
    
    init() {
        type = OSCellButtonsTypes.single
    }
}
