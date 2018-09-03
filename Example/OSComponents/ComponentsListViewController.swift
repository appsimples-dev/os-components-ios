//
//  ComponentsListViewController.swift
//  OSComponents
//
//  Created by AppSimples on 15/08/18.
//  Copyright © 2018 OutSmart. All rights reserved.
//

import UIKit

class ComponentsListViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var components: [ComponentListCellModel?] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        components.append(ComponentListCellModel(viewController: OSTableViewControllerExample(nibName: "OSTableViewControllerExample", bundle: nil)))
        components.append(ComponentListCellModel(viewController: NotificationsExampleViewController(nibName: "NotificationsExampleViewController", bundle: nil)))
        components.append(ComponentListCellModel(viewController: CommentsExampleViewController(nibName: "CommentsExampleViewController", bundle: nil)))
        components.append(ComponentListCellModel(viewController: PostsViewController(nibName: "PostsViewController", bundle: nil)))
        setupTableView()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 40.0
        tableView.separatorStyle = .none
        tableView.register(cellType: ComponentsListCell.self)
    }
}

extension ComponentsListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return components.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let model = components[indexPath.row] else { return UITableViewCell() }
        let cell = tableView.dequeueReusableCell(for: indexPath, cellType: ComponentsListCell.self)
        cell.configWith(model: model, delegate: self)
        return cell
    }
}

extension ComponentsListViewController: ComponentListCellDelegate {
    func didSelectButtonFor(model: ComponentListCellModel?) {
        guard let vc = model?.viewController else {
            print("Error while opening the ViewController, model is nil")
            return
        }
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
