//
//  CommentsExampleViewController.swift
//  OSComponents
//
//  Created by AppSimples on 15/08/18.
//  Copyright © 2018 OutSmart. All rights reserved.
//

import UIKit
import ObjectMapper
import OSComponents

class CommentsExampleViewController: UIViewController {
    
    @IBOutlet weak var tableView: OSTableView!
    var list = [OSSection]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.navigationController?.navigationBar.topItem?.title = "Comments"
    }
    
    func setupTableView() {
        tableView.build(delegate: self)
        tableView.register(cellType: OSSimpleTableViewCell.self)
        let comment = CommentModel(image: "https://abrilveja.files.wordpress.com/2017/05/obama-berlim-02.jpg", comment: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor. Ipsum dolor sit amet, consectetur adipiscing elit, Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor. Ipsum dolor sit amet, consectetur adipiscing elit por. Ipsum dolor sit amet, consectetur adipiscing elit, Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor. Ipsum dolor sit amet, consectetur adipiscing elit", username: "Presidente Obama")
        list.append(OSTableView.buildSectionWith(array: [comment, comment, comment, comment, comment, comment, comment], header: nil))
        tableView.reloadTableViewWith(data: list)
    }
}

extension CommentsExampleViewController: OSTableViewDelegate {
    func configCell(with model: Any, for indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(for: indexPath, cellType: OSSimpleTableViewCell.self)
        guard let comment = model as? CommentModel else { return UITableViewCell() }
        cell.configWith(cellConfiguration: SimpleCellConfiguration.configCommentCell(), cellData: comment.mapToCell(), delegate: self, indexPath: indexPath)
        return cell
    }
}

extension CommentsExampleViewController: OSSimpleTableViewCellDelegate {
    func titleClickFor(indexPath: IndexPath?) {
        print("title click")
    }
    
    func imageClickFor(indexPath: IndexPath?) {
        print("image click")
    }
    
    func singleButtonClickFor(indexPath: IndexPath?) {
        
    }
    
    func leftButtonClickFor(indexPath: IndexPath?) {
        
    }
    
    func rightButtonClickFor(indexPath: IndexPath?) {
        
    }
    
    func moreButtonClickFor(indexPath: IndexPath?) {
        presentAlertSheetWith(title: "", description: "", actions: [
            UIAlertAction(title: "Report", style: .default, handler: { (action) in
                print("report")
            }),
            UIAlertAction(title: "Delete", style: .default, handler: { (action) in
                print("delete")
            })])
    }
}
