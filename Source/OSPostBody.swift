//
//  OSPostBody.swift
//
//
//  Created by Matheus Freitas Venosa on 29/08/18.
//

import Foundation
import AlamofireImage

public class OSPostBody: UIView {
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var text: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    func configBodyWith(configuration: OSPostBodyConfiguration, data: OSPostBodyData) {
        if let url = URL(string: data.imageUrl ?? "") {
            image.af_setImage(withURL: url)
        }
        text.text = data.text
        text.textColor = configuration.textColor ?? UIColor.gray
    }
    
    func commonInit() {
        let podBundle = Bundle(for: self.classForCoder)
        podBundle.loadNibNamed("OSPostBody", owner: self, options: nil)
        addSubview(contentView)
        setupFrames()
    }
    
    private func setupFrames() {
        contentView.frame = self.bounds
        contentView.layoutIfNeeded() // UPDATE ALL THE SUBVIEWS LAYOUT
    }
}

public struct OSPostBodyConfiguration {
    var textColor: UIColor?
}

public struct OSPostBodyData {
    var imageUrl: String?
    var text: String?
}


