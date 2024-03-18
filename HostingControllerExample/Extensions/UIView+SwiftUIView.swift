import SnapKit
import SwiftUI

extension UIView {
    func addSwiftUIView<T: View>(view: T) {
        let hostingController = UIHostingController(rootView: view)
        if #available(iOS 16.0, *) {
            hostingController.sizingOptions = [.intrinsicContentSize]
        }
        addSubview(hostingController.view)
        hostingController.view.backgroundColor = .clear
        hostingController.view.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func addSwiftUIView2<T: View>(view: T) -> UIHostingController<T> {
        let hostingController = UIHostingController(rootView: view)
        if #available(iOS 16.0, *) {
            hostingController.sizingOptions = [.intrinsicContentSize]
        }
        addSubview(hostingController.view)
        hostingController.view.backgroundColor = .clear
        hostingController.view.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        return hostingController
    }
    
    func hostSwiftUIView<T: View>(view: T) {
        guard let vc = findViewController() else { return }
        vc.hostSwiftUIView(
            view: view,
            insideView: self
        )
    }

    func findViewController() -> UIViewController? {
        if let nextResponder = self.next as? UIViewController {
            return nextResponder
        } else if let nextResponder = self.next as? UIView {
            return nextResponder.findViewController()
        } else {
            return nil
        }
    }
}
