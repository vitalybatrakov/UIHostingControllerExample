import SnapKit
import SwiftUI

extension UIViewController {
    
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
        return hostingController
    }
}
