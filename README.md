# OSComponents

[![CI Status](https://img.shields.io/travis/MatheusFV/OSComponents.svg?style=flat)](https://travis-ci.org/MatheusFV/OSComponents)
[![Version](https://img.shields.io/cocoapods/v/OSComponents.svg?style=flat)](https://cocoapods.org/pods/OSComponents)
[![License](https://img.shields.io/cocoapods/l/OSComponents.svg?style=flat)](https://cocoapods.org/pods/OSComponents)
[![Platform](https://img.shields.io/cocoapods/p/OSComponents.svg?style=flat)](https://cocoapods.org/pods/OSComponents)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

## Installation

OSComponents is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'OSComponents'
```

## Components

### Simple Cell Component

To use this component you'll need two main things!

#### 1- Pass the layout configuration to your cell

There is a simple way to pass the cell configuration, it's done using a object called **OSSimpleCellConfiguration**.

```swift
struct OSSimpleCellConfiguration {
var primaryImagePlaceholder: UIImage?
var secondaryImagePlaceholder: UIImage?
var primaryTextColor: UIColor?
var secondaryTextColor: UIColor?
var tertiaryTextColor: UIColor?
var textSelectable: Bool?
var buttonColor: UIColor?
var leftButtonColor: UIColor?
var rightButtonColor: UIColor?
var buttonText: String?
var leftButtonIcon: UIImage?
var rightButtonIcon: UIImage?
var buttonsType: OSCellButtonsTypes = OSCellButtonsTypes.single
var selectedButtonColor: UIColor?
var selectedButtonTextColor: UIColor?
var selectedButtonText: String?
var selected: Bool = false
var moreButton: Bool = false
}
```

The **OSCellButtonsTypes** are: 

```swift
enum OSCellButtonsTypes {
case single
case double
case none
}
```


#### 2- Pass the data to your cell

To pass the data you create other object, the **OSSimpleCellData**

```swift
struct OSSimpleCellData {
var primaryImage: String?
var secondaryImage: String?
var primaryText: String = ""
var secondaryText: String?
var tertiaryText: String?
var selected: Bool?
}
```

Now you should be asking, how I'm going to do this?

I believe the best way to show is giving a example!

### Example

In this example we are creating multiple **Notifications Cells** and a **Comment Cell**

First, we're going to ser our cell configuration, to do so we can create a separated class with the configs:

```swift
class SimpleCellConfiguration {
class func configNotificationCell() -> OSSimpleCellConfiguration {
var cellConfiguration = OSSimpleCellConfiguration()
cellConfiguration.primaryTextColor = UIColor.black
cellConfiguration.secondaryTextColor = UIColor.gray
cellConfiguration.buttonsType = OSCellButtonsTypes.none
return cellConfiguration
}

class func configFollowCell() -> OSSimpleCellConfiguration {
var cellConfiguration = configNotificationCell()
cellConfiguration.buttonColor = UIColor.fromRGBA(r: 15, g: 195, b: 172, a: 1)
cellConfiguration.selectedButtonColor = UIColor.fromRGBA(r: 15, g: 195, b: 172, a: 1)
cellConfiguration.selectedButtonTextColor = UIColor.white
cellConfiguration.buttonText = "seguir"
cellConfiguration.buttonsType = OSCellButtonsTypes.single
cellConfiguration.selectedButtonText = "seguindo"
return cellConfiguration
}

class func configAddCell() -> OSSimpleCellConfiguration {
var cellConfiguration = configNotificationCell()
cellConfiguration.leftButtonIcon = #imageLiteral(resourceName: "close")
cellConfiguration.leftButtonColor = UIColor.gray
cellConfiguration.rightButtonIcon = #imageLiteral(resourceName: "check")
cellConfiguration.rightButtonColor = UIColor.gray
cellConfiguration.buttonsType = OSCellButtonsTypes.double
return cellConfiguration
}

class func configCommentCell() -> OSSimpleCellConfiguration {
var cellConfiguration = OSSimpleCellConfiguration()
cellConfiguration.primaryTextColor = UIColor.black
cellConfiguration.secondaryTextColor = UIColor.gray
cellConfiguration.buttonsType = OSCellButtonsTypes.none
cellConfiguration.moreButton = true
return cellConfiguration
}
}
```

With those methods we can build our cells layout! Now, we must pass our data to the cells, to do this we can create a methdo inside our project models that convers the properties for us.

For example:

**NotificaionModel**

```swift
struct NotificationModel: Mappable {
var image: String = ""
var title: String = ""
var subtitle: String?
var isFollowing: Bool?
var type: NotificationType = .add

init(image: String, title: String, subtitle: String?, isFollowing: Bool?, type: NotificationType) {
self.image = image
self.subtitle = subtitle
self.title = title
self.isFollowing = isFollowing
self.type = type
}

init?(map: Map) {
}

mutating func mapping(map: Map) {
}

func mapToCell() -> OSSimpleCellData {
var data = OSSimpleCellData()
data.primaryImage = image
data.primaryText = title
data.secondaryText = subtitle
data.selected = isFollowing
return data
}
}
```

**CommentModel**

```swift
struct CommentModel: Mappable {
var image: String = ""
var comment: String = ""
var username: String = ""

init(image: String, comment: String, username: String) {
self.image = image
self.comment = comment
self.username = username
}

init?(map: Map) {
}

mutating func mapping(map: Map) {
}

func mapToCell() -> OSSimpleCellData {
var data = OSSimpleCellData()
data.primaryImage = image
data.primaryText = username
data.secondaryText = comment
return data
}
}
```

As you can see, both Models have the mapToCell() method, that converts the properties and return a **OSSimpleCellData**.

After that we have everything prepared to create our **TableView**

**ViewController**

Inside the ViewController we usually setup the TableView and register the cells:

```swift
func setupTableView() {
tableView.build(delegate: self)
tableView.register(cellType: OSSimpleTableViewCell.self)
tableView.reloadTableViewWith(data: list)
}

```

Then, we always have a array of data, for example:

```swift
func getData() -> [NotificationModel] {
let notif = NotificationModel(image: "https://abrilveja.files.wordpress.com/2017/05/obama-berlim-02.jpg", 
title: "Presidente Obama", subtitle: "200", isFollowing: true, type: NotificationType.follow)
return [notif, notif, notif] // mock with 3 equal notifications
}
```

After that, we configure the cells inside the delegate methods:

```swift
func configCell(for indexPath: IndexPath) -> UITableViewCell {
let cell = tableView.dequeueReusableCell(for: indexPath, cellType: OSSimpleTableViewCell.self)
guard let notif = getData()[indexPath.row] as? NotificationModel else { return UITableViewCell() }
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
```

Inside the cell configuration we pass the **SimpleCellConfiguration** and the **notif.mapToCell()** with the data.

After that everything will be done and the TableView is ready for testing!
## Author

Outsmart

## License

OSComponents is available under the MIT license. See the LICENSE file for more info.
