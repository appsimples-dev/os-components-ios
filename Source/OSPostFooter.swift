//
//  OSPostFooter.swift
//  
//
//  Created by Matheus Freitas Venosa on 29/08/18.
//

import Foundation

public class OSPostFooter: UIView {
    @IBOutlet var contentView: UIView!
    
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
        podBundle.loadNibNamed("OSPostFooter", owner: self, options: nil)
        addSubview(contentView)
        setupFrames()
    }
    
    private func setupFrames() {
        contentView.frame = self.bounds
        contentView.layoutIfNeeded() // UPDATE ALL THE SUBVIEWS LAYOUT
    }
}
