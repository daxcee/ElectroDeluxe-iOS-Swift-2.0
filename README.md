# ElectroDeluxe-Swift-2.0


## Prerequisites

* [Xcode 7.0+](https://developer.apple.com/xcode/downloads/)
* [iOS9](https://developer.apple.com/xcode/downloads/)
* [CocoaPods](https://cocoapods.org)

### [NSURLSession API](https://developer.apple.com/library/ios/documentation/Foundation/Reference/NSURLSession_class/)

Networking is done with the `NSURLSession API`. With the new `iOS 9` SDK there are enforcements on HTTP requests.
iOS 9 introduces the [App Transport Security](https://developer.apple.com/library/prerelease/ios/technotes/App-Transport-Security-Technote/index.html#//apple_ref/doc/uid/TP40016240) which forces network requests to be `non-clear text`, thus disallows requests with the HTTP protocol by default
and enforces the use of HTTPS protocol. Every out going request in Electro Deluxe App app is done through the `HTTPS` protocol and thereby
adopting the additional changes and best practices on the usage of NSURLSession API.

### [Core Data API](https://developer.apple.com/library/mac/documentation/Cocoa/Conceptual/CoreData/Articles/cdBasics.html#//apple_ref/doc/uid/TP40001650-TP1)

This application relies heavily on the Core Data stack
to locally persist retrieved data from the [Flow API](https://flow-api.herokuapp.com). Therefore I created an overview of how the Core Data stack is implemented and utilized within the application.

![CoreData Thread confinement](http://i.imgur.com/RxHbRbD.jpg)

#### Thread confinement

You can see that there are three layers used, this is to provide true concurrency and also
utilize thread confinement.

The `minions* workers` are the workers in the `PersistenceManager` that save each `parsed`
and prepared `NSManagedObject` within it's own Thread. Eventually when all NSManagedObjects are stored within the thread confined context, the `PersistenceManager` calls the `MainContext` in the ContextManager, which will cause the `minions` to merge / synchronize with the MainContext and finally with the `Master application context`, which will call the `Persistence Store Coordinator` in the DatastoreManager to actually store the NSManagedObjects to the datastore.

*No copyright infringement intended.
