# UIHostingControllerExample
Example project to test automatic size updates of UIHostingView

```
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
```

Usage:
```
hostSwiftUIView(view: SwiftUIView())
```

https://github.com/vitalybatrakov/UIHostingControllerExample/assets/20704616/b695c4c3-ba1a-4ab2-82ea-f2c4354f427d


### Popovers
```
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
}
```

Usage:
```
presentPopover(
    withSwiftUIView: SwiftUIView().frame(idealWidth: 250, minHeight: 40),
    sourceView: button
)
```


https://github.com/vitalybatrakov/UIHostingControllerExample/assets/20704616/3e7fabf1-f259-4b9d-beb7-f2e16e92dda2


