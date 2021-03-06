//
//  OSTableView.swift
//  baseproject
//
//  Created by AppSimples on 01/08/18.
//  Copyright © 2018 Outsmart. All rights reserved.
//

import Foundation
import UIKit
import Reusable

@objc public protocol OSTableViewDelegate: class {
    func configCell(with model: Any, for indexPath: IndexPath) -> UITableViewCell
    @objc optional func swipeRefresh()
    @objc optional func paginate()
}

public class OSTableView: UITableView {
    weak var osDelegate: OSTableViewDelegate?
    var sections: [OSSection] = []
    public var lastElementCount: Int = 0
    var paginating: Bool = false
    public var canPaginate: Bool = false // Set this variable to enable pagination
    
    // MARK: CONSTANTS
    // CHANGE THIS CONSTANT TO CHANGE THE MOMENT OF PAGINATION
    var PAGINATE_AT = 1
    var DEFAULT_HEADER_HEIGHT: CGFloat = 40.0
    
    public func build(delegate: OSTableViewDelegate) {
        self.delegate = self
        self.dataSource = self
        self.osDelegate = delegate
        self.rowHeight = UITableViewAutomaticDimension
        self.separatorStyle = .none
    }
    
    public func useRefresh() {
        if #available(iOS 10.0, *) {
            self.refreshControl = UIRefreshControl()
            refreshControl?.addTarget(self, action: #selector(handleRefresh(_:)),
                                      for: UIControlEvents.valueChanged)
        } else {
            // Fallback on earlier versions
        }
    }
    
    public func reloadTableViewWith(data: OSSection) {
        sections = [data]
        paginating = false
        self.reloadData()
        if #available(iOS 10.0, *) {
            refreshControl?.endRefreshing()
        } else {
            // Fallback on earlier versions
        }
    }
    
    public func reloadTableViewWithoutPagination(data: OSSection) {
        sections = [data]
        self.reloadData()
        if #available(iOS 10.0, *) {
            refreshControl?.endRefreshing()
        } else {
            // Fallback on earlier versions
        }
    }
    
    public func reloadTableViewWith(data: [OSSection]) {
        sections = data
        paginating = false
        tableFooterView?.isHidden = true
        self.reloadData()
        if #available(iOS 10.0, *) {
            refreshControl?.endRefreshing()
        } else {
            // Fallback on earlier versions
        }
    }
    
    @objc func handleRefresh(_ refreshControl: UIRefreshControl) {
        osDelegate?.swipeRefresh?()
        lastElementCount = 0
    }
    
}

extension OSTableView: UITableViewDelegate, UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections.count < section ? 0 : sections[section].items.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let element = sections[indexPath.section].items[indexPath.row]
        
        guard let del = osDelegate else { return UITableViewCell() }
        
        if canPaginateFor(indexPath: indexPath) {
            del.paginate?()
        }
        
        return del.configCell(with: element, for: indexPath)
    }
    
    public func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    public func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if sections.count > section {
            if let header = sections[section].headerView {
                return header
            } else if let text = sections[section].headerTitle {
                return simpleHeaderWith(text: text)
            }
        }
        return nil
    }
    
    public func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if sections.count > section {
            if sections[section].headerView == nil, sections[section].headerTitle == nil {
                return 0
            } else if sections[section].headerView == nil {
                return DEFAULT_HEADER_HEIGHT
            } else {
                return sections[section].headerView?.frame.height ?? 0
            }
        }
        return 0
    }
    
    public func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let lastSectionIndex = tableView.numberOfSections - 1
        let lastRowIndex = tableView.numberOfRows(inSection: lastSectionIndex) - 1
        if indexPath.section ==  lastSectionIndex && indexPath.row == lastRowIndex, paginating {
            let spinner = UIActivityIndicatorView(activityIndicatorStyle: .gray)
            spinner.startAnimating()
            spinner.frame = CGRect(x: CGFloat(0), y: CGFloat(0), width: tableView.bounds.width, height: CGFloat(44))
            
//            self.tableFooterView = spinner
//            self.tableFooterView?.isHidden = false
        }
    }
}

// Mark: Helpers

extension OSTableView {
    public func simpleHeaderWith(text: String) -> UIView {
        let label = UILabel()
        label.text = text
        label.textAlignment = NSTextAlignment.center
        label.textColor = UIColor.lightGray
        label.backgroundColor = UIColor.white
        return label
    }
    
    public class func buildSectionWith(array: [Any], header: Any?) -> OSSection {
        var section = OSSection()
        
        if let header = header as? UIView {
            section.headerView = header
        } else if let header = header as? String {
            section.headerTitle = header
        }
        section.items = array
        
        return section
    }
    
    public func canPaginateFor(indexPath: IndexPath) -> Bool {
        if (!canPaginate) { return false }
        if indexPath.section == sections.count - 1, indexPath.row == sections[indexPath.section].items.count - PAGINATE_AT,
            numberOfItems() > lastElementCount, !paginating {
            lastElementCount = numberOfItems()
            paginating = canPaginate
            return true
        } else {
            return false
        }
    }
    
    public func numberOfItems() -> Int {
        return sections.reduce(0) { (accumulation: Int, nextValue: OSSection) -> Int in
            return accumulation + nextValue.items.count
        }
    }
}

// Mark: Models

public struct OSSection {
    var headerTitle: String?
    var headerView: UIView?
    var items: [Any]
    
    init() {
        self.items = []
    }
    
    init(headerTitle: String?, headerView: UIView?, items: [Any]) {
        self.headerTitle = headerTitle
        self.headerView = headerView
        self.items = items
    }
}
