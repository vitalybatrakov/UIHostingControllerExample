import SnapKit
import SwiftUI

extension UIView {
    func addSwiftUIView<T: View>(view: T) {
        let hostingController = UIHostingController(rootView: view)
        addSubview(hostingController.view)
        hostingController.view.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func addSwiftUIView2<T: View>(view: T) -> UIHostingController<T> {
        let hostingController = UIHostingController(rootView: view)
        addSubview(hostingController.view)
        hostingController.view.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        return hostingController
    }
    
    func hostSwiftUIView<T: View>(view: T) -> UIHostingController<T>? {
        guard let vc = findViewController() else { return nil }
        return vc.hostSwiftUIView(
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
