# UIHostingControllerExample
Example project to test automatic size updates of UIHostingView

```
extension UIViewController {
    func hostSwiftUIView<T: View>(
        view: T,
        insideView hostView: UIView? = nil,
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
```

Usage:
```
hostSwiftUIView(
    view: SwiftUIView(),
    insideView: view
)
```

https://github.com/vitalybatrakov/UIHostingControllerExample/assets/20704616/b695c4c3-ba1a-4ab2-82ea-f2c4354f427d

