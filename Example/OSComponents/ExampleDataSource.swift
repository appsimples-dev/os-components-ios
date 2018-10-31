//
//  ExampleDataSource.swift
//  OSComponents
//
//  Created by AppSimples on 15/08/18.
//  Copyright © 2018 OutSmart. All rights reserved.
//

import Foundation
import OSComponents

class ExampleDataSource {
    var exampleItemsArray = [OSSection]()
    
    func createList() {
        exampleItemsArray.append(OSTableView.buildSectionWith(array: [ExampleModel(title: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.")], header: "Automatic Dimension Cells"))
        exampleItemsArray.append(OSTableView.buildSectionWith(array: [ExampleModel(title: "Cell 1"), ExampleModel(title: "Cell 2"), ExampleModel(title: "Cell 3"), ExampleModel(title: "Cell 4"),
                                                                      ExampleModel(title: "Cell 5"), ExampleModel(title: "Cell 6"), ExampleModel(title: "Cell 7"), ExampleModel(title: "Cell 8")], header: "Cells"))
        exampleItemsArray.append(OSTableView.buildSectionWith(array: [ExampleModel(title: "User 1"), ExampleModel(title: "User 2"), ExampleModel(title: "User 3"), ExampleModel(title: "User 4"),
                                                                      ExampleModel(title: "User 5"), ExampleModel(title: "User 6"), ExampleModel(title: "User 7"), ExampleModel(title: "User 8")], header: "Users"))
    }
    
    func getItems() -> [OSSection] {
        return exampleItemsArray
    }
    
    func paginateList() {
//        exampleItemsArray.removeAll()
        exampleItemsArray.append(OSTableView.buildSectionWith(array: [ExampleModel(title: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.")], header: "Automatic Dimensions Cells"))
        exampleItemsArray.append(OSTableView.buildSectionWith(array: [ExampleModel(title: "Cell 1"), ExampleModel(title: "Cell 2"), ExampleModel(title: "Cell 3"), ExampleModel(title: "Cell 4")], header: "Cells"))
        exampleItemsArray.append(OSTableView.buildSectionWith(array: [ExampleModel(title: "User 1"), ExampleModel(title: "User 2"), ExampleModel(title: "User 3"), ExampleModel(title: "User 4"),
                                                         ExampleModel(title: "User 5"), ExampleModel(title: "User 6"), ExampleModel(title: "User 7"), ExampleModel(title: "User 8"),
                                                         ExampleModel(title: "User 9"), ExampleModel(title: "User 10"), ExampleModel(title: "User 11"), ExampleModel(title: "User 12")], header: "Users"))
    }
}
