//
//  OSPostFooter.swift
//  
//
//  Created by Matheus Freitas Venosa on 29/08/18.
//

import Foundation

public class OSPostFooter: UIView {
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var item1: OSInfoButton!
    @IBOutlet weak var item2: OSInfoButton!
    @IBOutlet weak var item3: OSInfoButton!
    @IBOutlet weak var item4: OSInfoButton!
    @IBOutlet weak var item5: OSInfoButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func config() {
        let like = UIImage(named: "like", in: Bundle(for: self.classForCoder), compatibleWith: nil)
        let share = UIImage(named: "share", in: Bundle(for: self.classForCoder), compatibleWith: nil)
        let comment = UIImage(named: "comment", in: Bundle(for: self.classForCoder), compatibleWith: nil)
        let off = UIImage(named: "off", in: Bundle(for: self.classForCoder), compatibleWith: nil)

        item1.configWith(data: OSInfoButtonData(image: like, selectedImage: like, text: "150", selected: false), textColor: UIColor.gray, bold: false)
        item2.configWith(data: OSInfoButtonData(image: comment, selectedImage: comment, text: "125", selected: false), textColor: UIColor.gray, bold: false)
        item3.configWith(data: OSInfoButtonData(image: off, selectedImage: off, text: nil, selected: false), textColor: UIColor.gray, bold: false)
        item4.configWith(data: OSInfoButtonData(image: nil, selectedImage: nil, text: "novo!", selected: false), textColor: UIColor.black, bold: true)
        item5.configWith(data: OSInfoButtonData(image: share, selectedImage: share, text: nil, selected: false), textColor: UIColor.gray, bold: false)
    }

    func commonInit() {
        let podBundle = Bundle(for: self.classForCoder)
        podBundle.loadNibNamed("OSPostFooter", owner: self, options: nil)
        addSubview(contentView)
        setupFrames()
    }
    
    private func setupFrames() {
        contentView.frame = self.bounds
        config()
        contentView.layoutIfNeeded() // UPDATE ALL THE SUBVIEWS LAYOUT
    }
}

public struct OSPostFooterData {
    
}
