//
//  OSPostCell.swift
//  Alamofire
//
//  Created by Matheus Freitas Venosa on 29/08/18.
//

import UIKit
import Reusable

public class OSPostCell: UITableViewCell, NibReusable {
    @IBOutlet weak var header: OSPostHeader!
    @IBOutlet weak var body: OSPostBody!
    @IBOutlet weak var container: UIView!
    
    override public func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        configBody()
        configHeader()
        container.layer.backgroundColor = UIColor.white.cgColor
        container.layer.shadowColor = UIColor.black.cgColor
        container.layer.shadowOffset = CGSize(width: 0, height: 1.0)
        container.layer.shadowOpacity = 0.2
        container.layer.shadowRadius = 4.0
        // Initialization code
    }

    override public func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    private func configHeader() {
        var configuration = OSPostHeaderConfiguration()
        configuration.primaryTextColor = UIColor.black
        configuration.secondaryTextColor = UIColor.gray
        configuration.tertiaryTextColot = UIColor.gray
        
        var data = OSPostHeaderData(primaryText: "Matheus")
        data.secondaryText = "8km - Vila Mariana, São Paulo"
        data.tertiaryText = "Há 10 min atrás"
        data.buttonEnabled = true
        data.imageUrl = "https://upload.wikimedia.org/wikipedia/commons/thumb/3/3a/Cat03.jpg/1200px-Cat03.jpg"
        
        header.configHeaderWith(configuration: configuration, data: data)
    }
    
    private func configBody() {
        var configuration = OSPostBodyConfiguration()
        configuration.textColor = UIColor.gray
        
        var data = OSPostBodyData()
        data.text = "Olha que gato mais fofo que eu adotei! Mas já cansei dele e quero trocar, alguém aí afim?"
        data.imageUrl = "https://i.ytimg.com/vi/YCaGYUIfdy4/maxresdefault.jpg"
        
        body.configBodyWith(configuration: configuration, data: data)
    }
}
