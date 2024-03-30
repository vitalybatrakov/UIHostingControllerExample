import SnapKit
import SwiftUI

extension UIViewController: UIPopoverPresentationControllerDelegate {
    @discardableResult
    func presentPopover<T: View>(
        withSwiftUIView view: T,
        sourceView: UIView,
        permittedArrowDirections: UIPopoverArrowDirection = .any
    ) -> UIHostingController<T> {
        let hostingController = UIHostingController(rootView: view)
        if #available(iOS 16.0, *) {
            hostingController.sizingOptions = [.preferredContentSize]
        }
        hostingController.modalPresentationStyle = .popover
        if let popoverPC = hostingController.popoverPresentationController {
            popoverPC.permittedArrowDirections = permittedArrowDirections
            popoverPC.sourceView = sourceView
            popoverPC.delegate = self
        }
        present(hostingController, animated: true)
        return hostingController
    }

    // to test popovers on the iPhone
    public func adaptivePresentationStyle(
        for controller: UIPresentationController,
        traitCollection: UITraitCollection
    ) -> UIModalPresentationStyle {
        return .none
    }
}
