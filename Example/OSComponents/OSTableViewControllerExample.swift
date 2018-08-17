//
//  OSTableViewControllerExample.swift
//  OSComponents
//
//  Created by AppSimples on 15/08/18.
//  Copyright © 2018 OutSmart. All rights reserved.
//

import UIKit

class OSTableViewControllerExample: UIViewController {

    @IBOutlet weak var tableView: OSTableView!
    var dataSource: ExampleDataSource?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataSource = ExampleDataSource()
        dataSource?.createList()
        setupTableView()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupTableView() {
        tableView.build(delegate: self)
        tableView.register(cellType: ExampleTableViewCell.self)
        tableView.reloadTableViewWith(data: dataSource?.getItems() ?? [])
    }
}


extension OSTableViewControllerExample: OSTableViewDelegate {
    func configCell(with model: Any, for indexPath: IndexPath) -> UITableViewCell {
        if let model = model as? ExampleModel {
            let cell = tableView.dequeueReusableCell(for: indexPath, cellType: ExampleTableViewCell.self)
            cell.configWith(model: model)
            return cell
        }
        return UITableViewCell()
    }
    
    func swipeRefresh() {
        print("swipe")
    }
    
    // Pagination happens in the last section (Use one section for a simple tableView with pagination)
    func paginate() {
        dataSource?.paginateList()
        tableView.reloadTableViewWith(data: dataSource?.getItems() ?? [])
    }
}
