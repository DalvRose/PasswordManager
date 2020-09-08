
import Foundation


/// `DataSource` class provides base implementation for objects access by index path and for listners,
/// which can be notified by appropriate events described in `DataSourceDelegate`.

class DataSource: NSObject {

    /** Indicates is data loading. */
    var loading: Bool = false

    var isFirstPage = true

    var isLastPage = false

    var count = 20

    var page = 1

    var listeners = NSMutableArray()

    /** Property of mutable array for loading data. */
    var sections: [[AnyObject]] = []


    //MARK: - Interface -

    func reloadData() {
    }
    
    func itemAtIndexPath(_ indexPath: IndexPath) -> AnyObject {
        if self.sections.count > 0 {
            return self.sections[indexPath.section][indexPath.row] as AnyObject
        } else {
            return [] as AnyObject
        }
    }

    func indexPathForItem(_ item: AnyObject) -> IndexPath? {

        var sectionIndex = 0

        for section in self.sections {
            var rowIndex = 0

            for currentItem in section {
                if (currentItem as AnyObject).isEqual(item) {
                    return IndexPath(item: rowIndex, section: sectionIndex)
                }

                rowIndex += 1
            }

            sectionIndex += 1
        }

        return nil
    }

    func numberOfSections() -> Int {
        return self.sections.count
    }

    func numberOfItemsInSection(_ section: Int) -> Int {
        if self.sections.count == 0 {
            return 0
        }

        return self.sections[section].count
    }

    func nextPage() -> Int {
        page = page + 1

        return page
    }


    // MARK: - Privates -

    private func containsListner(_ listener: AnyObject) -> Int? {
        var index = 0

        for listnerWrapper in listeners {
            if let listnerWeak = listnerWrapper as? Weak<AnyObject> {
                if let unwrappedListner = listnerWeak.value as? NSObject {
                    if let listnerToCheck = listener as? NSObject {
                        if unwrappedListner == listnerToCheck {
                            return index
                        }
                    }
                }
            }

            index += 1
        }

        return nil
    }


    // MARK: - Listeners -

    func addListener(_ listener: AnyObject) {
        if containsListner(listener) == nil {
            let weakListener = Weak(value: listener)
            listeners.add(weakListener)
        }
    }

    func removeListener(_ listener: AnyObject) {
        if let index = containsListner(listener) {
            listeners.removeObject(at: index)
        }
    }

    func notifyListenersDidLoadItems() {
        DispatchQueue.main.async {
            for object in self.listeners {
                if let weakObject = object as? Weak<AnyObject> {
                    if let conformingObject = weakObject.value as? DataSourceDelegate {
                        conformingObject.dataSourceDidLoadItems?(self.sections as AnyObject)
                    }
                }
            }
        }
    }
    
    func notifyListenersRemoveItems() {
        DispatchQueue.main.async {
            for object in self.listeners {
                if let weakObject = object as? Weak<AnyObject> {
                    if let conformingObject = weakObject.value as? DataSourceDelegate {
                        conformingObject.dataSourceDidRemoveItems?(self.sections as AnyObject)
                    }
                }
            }
        }
    }


    func notifyListenersWillLoadItems() {
        DispatchQueue.main.async {
            for object in self.listeners {
                if let weakObject = object as? Weak<AnyObject> {
                    if let conformingObject = weakObject.value as? DataSourceDelegate {
                        conformingObject.dataSourceWillLoadItems?()
                    }
                }
            }
        }
    }

    func notifyListenersDidLoadWithError(_ error: String) {
        DispatchQueue.main.async {
            for object in self.listeners {
                if let weakObject = object as? Weak<AnyObject> {
                    if let conformingObject = weakObject.value as? DataSourceDelegate {
                        conformingObject.dataSourceDidLoadWithError?(error)
                    }
                }
            }
        }
    }
}


/// `DataSourceDelegate` contains methods about downloading state of data source.

@objc public protocol DataSourceDelegate : class {
    
    @objc optional func dataSourceWillLoadItems()
    
    @objc optional func dataSourceDidRemoveItems(_ items: AnyObject)
    
    @objc optional func dataSourceDidLoadItems(_ items: AnyObject)

    @objc optional func dataSourceDidLoadWithError(_ error: String)
}

class Weak<T: AnyObject> {
    
    weak var value : T?
    
    init (value: T) {
        self.value = value
    }
}
