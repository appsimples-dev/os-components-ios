//
//  OSInfoButton.swift
//  Alamofire
//
//  Created by Matheus Freitas Venosa on 03/09/18.
//

import Foundation

public class OSInfoButton: UIView {
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var image: UIImageView!
    var data: OSInfoButtonData?
    
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
        podBundle.loadNibNamed("OSInfoButton", owner: self, options: nil)
        addSubview(contentView)
        setupFrames()
    }
    
    public func configWith(data: OSInfoButtonData, textColor: UIColor?, bold: Bool?) {
        configTextLayout(bold: bold, color: textColor)
        if data.selected {
            setInfo(image: data.selectedImage, text: data.text)
        } else {
            setInfo(image: data.image, text: data.text)
        }
        self.data = data
    }
    
    private func configTextLayout(bold: Bool?, color: UIColor?) {
        label.textColor = color
        if bold != nil {
            label.font = UIFont.boldSystemFont(ofSize: 13.0)
        }
    }
    
    private func setInfo(image: UIImage?, text: String?) {
        if image != nil {
            self.image.image = image
        } else {
            self.image.hide()
        }
        
        if text != nil {
            self.label.text = text
        } else {
            self.label.hide()
        }
        
        contentView.layoutIfNeeded()
    }
    
    private func defaultTextLayout() {
        label.textColor = UIColor.fromRGBA(r: 117, g: 117, b: 117, a: 1)
    }
    
    private func setupFrames() {
        contentView.frame = self.bounds
        defaultTextLayout()
        contentView.layoutIfNeeded() // UPDATE ALL THE SUBVIEWS LAYOUT
    }
    
    @IBAction func onClick(_ sender: Any) {
        guard let selected = data?.selected else { return }
        self.image.image = selected ? data?.image : data?.selectedImage
        data?.selected = !selected
    }
}

public struct OSInfoButtonData {
    var selectedImage: UIImage?
    var image: UIImage?
    var text: String?
    var selected: Bool = false
    
    init(image: UIImage?, selectedImage: UIImage?, text: String?, selected: Bool) {
        self.image = image
        self.selectedImage = selectedImage
        self.text = text
        self.selected = selected
    }
}
