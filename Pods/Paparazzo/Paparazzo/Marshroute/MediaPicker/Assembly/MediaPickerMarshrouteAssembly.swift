import Marshroute
import UIKit

public protocol MediaPickerMarshrouteAssembly: class {
    func module(
        items: [MediaPickerItem],
        selectedItem: MediaPickerItem?,
        maxItemsCount: Int?,
        cropEnabled: Bool,
        cropCanvasSize: CGSize,
        routerSeed: RouterSeed,
        configuration: (MediaPickerModule) -> ())
        -> UIViewController
}

public protocol MediaPickerMarshrouteAssemblyFactory: class {
    func mediaPickerAssembly() -> MediaPickerMarshrouteAssembly
}
