//
//  OSCellImage.swift
//  baseproject
//
//  Created by AppSimples on 07/08/18.
//  Copyright © 2018 Outsmart. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import AlamofireImage

public protocol OSCellImageDelegate {
    func imageClick()
}

// Input: primaryImageUrl, secondaryImageUrl
public class OSCellImage: UIView {
    @IBOutlet var contentView: UIView!
    @IBOutlet internal var secondaryImageView: UIImageView!
    @IBOutlet internal var primaryImageView: UIImageView!
    var delegate: OSCellImageDelegate?
    
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
        podBundle.loadNibNamed("OSCellImage", owner: self, options: nil)
        addSubview(contentView)
        setupFrames()
    }
    
    public func setPrimaryImage(imageUrl: String?, placeholder: UIImage?, delegate: OSCellImageDelegate?) {
        primaryImageView.circularCorners()
        primaryImageView.isHidden = false
        if let imageUrl = imageUrl, let url = URL(string: imageUrl) {
            primaryImageView.af_setImage(withURL: url)
        } else if let placeholder = placeholder {
            primaryImageView.image = placeholder
        } else {
            primaryImageView.isHidden = true
        }
        self.delegate = delegate
    }
    
    public func setSecondaryImage(imageUrl: String?, placeholder: UIImage?) {
        secondaryImageView.circularCorners()
        secondaryImageView.isHidden = false
        if let imageUrl = imageUrl, let url = URL(string: imageUrl) {
            secondaryImageView.af_setImage(withURL: url)
        } else if let placeholder = placeholder {
            secondaryImageView.image = placeholder
        } else {
            secondaryImageView.isHidden = true
        }
    }
    
    @IBAction func imageClick(_ sender: Any) {
        delegate?.imageClick()
    }
    
    func clear() {
        primaryImageView.isHidden = true
        secondaryImageView.isHidden = true
    }
    
    private func setupFrames() {
        contentView.frame = self.bounds
        contentView.layoutIfNeeded() // UPDATE ALL THE SUBVIEWS LAYOUT
    }
}
