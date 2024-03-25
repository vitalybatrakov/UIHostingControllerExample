import SnapKit
import SwiftUI

extension UIViewController {
    @discardableResult
    func hostSwiftUIView<T: View>(
        view: T,
        insideView hostView: UIView? = nil
    ) -> UIHostingController<T> {
        let hostingController = UIHostingController(rootView: view)
        addChild(hostingController)
        hostingController.didMove(toParent: self)
        if let hostView {
            hostView.addSubview(hostingController.view)
        } else {
            self.view.addSubview(hostingController.view)
        }
        hostingController.view.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        if #available(iOS 16.0, *) {
            hostingController.sizingOptions = [.intrinsicContentSize]
        }
        return hostingController
    }
}

extension UIViewController: UIPopoverPresentationControllerDelegate {
    @discardableResult
    func presentPopover<T: View>(
        withSwiftUIView view: T,
        sourceView: UIView
    ) -> UIHostingController<T> {
        let hostingController = UIHostingController(rootView: view)
        if #available(iOS 16.0, *) {
            hostingController.sizingOptions = [.preferredContentSize]
        }
        hostingController.modalPresentationStyle = .popover
        if let popoverPC = hostingController.popoverPresentationController {
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
