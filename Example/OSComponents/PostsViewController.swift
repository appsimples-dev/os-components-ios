//
//  PostsViewController.swift
//  OSComponents_Example
//
//  Created by Matheus Freitas Venosa on 29/08/18.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import UIKit
import OSComponents

class PostsViewController: UIViewController {
    @IBOutlet weak var tableView: OSTableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupTableView() {
        tableView.build(delegate: self)
        tableView.register(cellType: OSPostCell.self)
        tableView.reloadTableViewWith(data: [OSTableView.buildSectionWith(array: [1,2,3,4,5], header: nil)])
    }

}

extension PostsViewController: OSTableViewDelegate {
    func configCell(with model: Any, for indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(for: indexPath, cellType: OSPostCell.self)
        return cell
    }
    
    func swipeRefresh() {
        print("swipe")
    }
    
    // Pagination happens in the last section (Use one section for a simple tableView with pagination)
    func paginate() {
        print("paginate")
    }
}
