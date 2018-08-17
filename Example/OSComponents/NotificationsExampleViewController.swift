//
//  NotificationsExampleViewController.swift
//  OSComponents
//
//  Created by AppSimples on 15/08/18.
//  Copyright © 2018 OutSmart. All rights reserved.
//

import UIKit

class NotificationsExampleViewController: UIViewController {

    @IBOutlet weak var tableView: OSTableView!
    var dataSource: ExampleDataSource?
    var list = [OSSection]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataSource = ExampleDataSource()
        dataSource?.createList()
        setupTableView()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.navigationController?.navigationBar.topItem?.title = "Notifications"
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupTableView() {
        tableView.build(delegate: self)
        tableView.register(cellType: OSSimpleTableViewCell.self)
        let notif = NotificationModel(image: "https://abrilveja.files.wordpress.com/2017/05/obama-berlim-02.jpg", title: "Presidente Obama", subtitle: "200", isFollowing: true, type: NotificationType.follow)
        let notif2 = NotificationModel(image: "https://abrilveja.files.wordpress.com/2017/05/obama-berlim-02.jpg", title: "Presidente Obama", subtitle: "200", isFollowing: false, type: NotificationType.follow)
        let notif3 = NotificationModel(image: "https://abrilveja.files.wordpress.com/2017/05/obama-berlim-02.jpg", title: "Presidente Obama", subtitle: "Quer ser seu amigo", isFollowing: nil, type: NotificationType.add)
        let notif4 = NotificationModel(image: "https://abrilveja.files.wordpress.com/2017/05/obama-berlim-02.jpg", title: "Presidente Obama", subtitle: "Te enviou um pedido de troca", isFollowing: nil, type: NotificationType.text)
        list.append(OSTableView.buildSectionWith(array: [notif, notif2, notif3, notif4, notif, notif2, notif3, notif, notif2, notif3, notif4, notif, notif2, notif3, notif, notif2, notif3, notif4, notif, notif2, notif3, notif, notif2, notif3, notif4, notif, notif2, notif3], header: nil))
        tableView.reloadTableViewWith(data: list)
    }
}


extension NotificationsExampleViewController: OSTableViewDelegate {
    func configCell(with model: Any, for indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(for: indexPath, cellType: OSSimpleTableViewCell.self)
        guard let notif = model as? NotificationModel else { return UITableViewCell() }
        switch notif.type {
        case NotificationType.add:
            cell.configWith(cellConfiguration: SimpleCellConfiguration.configAddCell(), cellData: notif.mapToCell(), delegate: self, indexPath: indexPath)
            break
        case NotificationType.follow:
            cell.configWith(cellConfiguration: SimpleCellConfiguration.configFollowCell(), cellData: notif.mapToCell(), delegate: self, indexPath: indexPath)
            break
        case NotificationType.text:
            cell.configWith(cellConfiguration: SimpleCellConfiguration.configNotificationCell(), cellData: notif.mapToCell(), delegate: self, indexPath: indexPath)
            break
        }
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

extension NotificationsExampleViewController: OSSimpleTableViewCellDelegate {
    func titleClickFor(indexPath: IndexPath?) {
        print("title click")
    }
    
    func imageClickFor(indexPath: IndexPath?) {
        print("image click")
    }
    
    func singleButtonClickFor(indexPath: IndexPath?) {
        print("single button click")
    }
    
    func leftButtonClickFor(indexPath: IndexPath?) {
        print("left button click")
    }
    
    func rightButtonClickFor(indexPath: IndexPath?) {
        print("right button click")
    }
    
    func moreButtonClickFor(indexPath: IndexPath?) {
        print("more button click")
    }
}
