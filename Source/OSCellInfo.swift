//
//  OSCellInfo.swift
//  baseproject
//
//  Created by AppSimples on 07/08/18.
//  Copyright © 2018 Outsmart. All rights reserved.
//

import Foundation
import UIKit

public protocol OSCellInfoDelegate: class {
    func moreButtonClick()
    func titleClick()
}

public class OSCellInfo: UIView {
    
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var primaryLabel: UILabel!
    @IBOutlet weak var secondaryLabel: UILabel!
    @IBOutlet weak var tertiaryLabel: UILabel!
    @IBOutlet var moreButton: UIButton!
    @IBOutlet var moreButtonImage: UIImageView!
    var delegate: OSCellInfoDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    func commonInit() {
        let podBundle = Bundle(for: self.classForCoder)
        podBundle.loadNibNamed("OSCellInfo", owner: self, options: nil)
        addSubview(contentView)
        setupFrames()
    }
    
    public func config(primaryColor: UIColor?, secondaryColor: UIColor?, selectable: Bool?, delegate: OSCellInfoDelegate, showButton: Bool) {
        primaryLabel.textColor = primaryColor
        primaryLabel.isUserInteractionEnabled = selectable ?? true
        
        secondaryLabel.textColor = secondaryColor
        secondaryLabel.isUserInteractionEnabled = selectable ?? true
        
        tertiaryLabel.textColor = secondaryColor
        tertiaryLabel.isUserInteractionEnabled = selectable ?? true
        
        self.delegate = delegate
        moreButton.isHidden = !showButton
        moreButtonImage.isHidden = !showButton
        
        let image = UIImage(named: "more_horizontal", in: Bundle(for: self.classForCoder), compatibleWith: nil)
        moreButtonImage.image = image
    }
    
    public func setPrimaryText(text: String) {
        primaryLabel.isHidden = false
        primaryLabel.text = text
    }
    
    public func setSecondaryText(text: String?) {
        guard let text = text else {
            secondaryLabel.hide()
            return
        }
        secondaryLabel.isHidden = false
        secondaryLabel.text = text
    }
    
    public func setTertiaryText(text: String?) {
        guard let text = text else {
            tertiaryLabel.hide()
            return
        }
        tertiaryLabel.isHidden = false
        tertiaryLabel.text = text
    }
    
    func clear() {
        primaryLabel.isHidden = true
        secondaryLabel.isHidden = true
        tertiaryLabel.isHidden = true
    }
    
    private func setupFrames() {
        contentView.frame = self.bounds
        contentView.layoutIfNeeded() // UPDATE ALL THE SUBVIEWS LAYOUT
    }
    
    @IBAction func titleClick(_ sender: Any) {
        delegate?.titleClick()
    }
    
    @IBAction func moreButtonClick(_ sender: Any) {
        delegate?.moreButtonClick()
    }
    
}
