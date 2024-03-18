import SnapKit
import SwiftUI

extension UIViewController {
    
    func hostSwiftUIView<T: View>(
        view: T,
        insideView hostView: UIView? = nil,
        // Setup sizingOptions here to always have a choice
        // if we want to avoid preformance cost of sizingOptions
        useIntrinsicContentSizeForSizing: Bool = true
    ) {
        let hostingController = UIHostingController(rootView: view)
        if #available(iOS 16.0, *), useIntrinsicContentSizeForSizing {
            hostingController.sizingOptions = [.intrinsicContentSize]
        }
        hostingController.view.backgroundColor = .clear
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
    }
}
