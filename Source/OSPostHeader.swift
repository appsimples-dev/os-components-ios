//
//  OSPostHeader.swift
//  
//
//  Created by Matheus Freitas Venosa on 29/08/18.
//

import Foundation

public class OSPostHeader: UIView {
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var postHeaderImage: UIImageView!
    @IBOutlet weak var postHeaderInfo: OSCellInfo!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    func configHeaderWith(configuration: OSPostHeaderConfiguration, data: OSPostHeaderData) {
        if let url = URL(string: data.imageUrl ?? "") {
            postHeaderImage.af_setImage(withURL: url)
        }
        postHeaderInfo.config(primaryColor: configuration.primaryTextColor, secondaryColor: configuration.secondaryTextColor, selectable: true, delegate: self, showButton: data.buttonEnabled)
        postHeaderInfo.setPrimaryText(text: data.primaryText)
        postHeaderInfo.setSecondaryText(text: data.secondaryText)
//        postHeaderInfo.setTertiaryText(text: data.tertiaryText)
        contentView.layoutIfNeeded()
    }
    
    func commonInit() {
        let podBundle = Bundle(for: self.classForCoder)
        podBundle.loadNibNamed("OSPostHeader", owner: self, options: nil)
        addSubview(contentView)
        setupFrames()
    }
    
    private func setupFrames() {
//        contentView.frame.size.height = 0
//        contentView.frame.size.width = 0
        postHeaderImage.circularCorners()
        contentView.layoutIfNeeded() // UPDATE ALL THE SUBVIEWS LAYOUT
    }
}

extension OSPostHeader: OSCellInfoDelegate {
    public func moreButtonClick() {
        print("button click")
    }
    
    public func titleClick() {
        print("title click")
    }
}

public struct OSPostHeaderConfiguration {
    public var primaryTextColor: UIColor?
    public var secondaryTextColor: UIColor?
    public var tertiaryTextColot: UIColor?
}

public struct OSPostHeaderData {
    public var primaryText: String
    public var secondaryText: String?
    public var tertiaryText: String?
    public var imageUrl: String?
    public var buttonEnabled: Bool = false
    
    init(primaryText: String) {
        self.primaryText = primaryText
    }
}
