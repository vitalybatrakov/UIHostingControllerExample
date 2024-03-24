import SnapKit
import UIKit

class ViewController: UIViewController {
    
    let scrollView = UIScrollView()
    let stackView = UIStackView()
    
    let view1 = UIView()
    let view2 = UIView()
    let view3 = UIView()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        setupSwiftUIView()
    }

    func setupLayout() {
        view.addSubview(scrollView)
        scrollView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        stackView.axis = .vertical
        scrollView.addSubview(stackView)
        stackView.snp.makeConstraints {
            $0.leading.trailing.equalTo(self.view)
            $0.top.bottom.equalTo(self.scrollView)
        }
        
        stackView.addArrangedSubview(view1)
        view1.backgroundColor = .red
        view1.snp.makeConstraints {
            $0.width.equalToSuperview()
            $0.height.equalTo(200)
        }
        
        stackView.addArrangedSubview(view2)
        view2.backgroundColor = .yellow
        view2.snp.makeConstraints {
            $0.width.equalToSuperview()
        }
        
        stackView.addArrangedSubview(view3)
        view3.backgroundColor = .green
        view3.snp.makeConstraints {
            $0.width.equalToSuperview()
            $0.height.equalTo(800)
        }
    }
    
    func setupSwiftUIView() {
//        addSwiftUIView()
//        addSwiftUIViewAndRetainHostingController()
        hostSwiftUIView()
    }
    
    // MARK: 1 case - Size updates doesn't work properly
    
    func addSwiftUIView() {
        view2.addSwiftUIView(view: SwiftUIView())
    }
    
    // MARK: 2 case - Size updates work but we use UIHostingController in a wrong way
     
    var hostingController: UIViewController?
    
    func addSwiftUIViewAndRetainHostingController() {
        // UIHostingController isn't set up properly, only retained in current vc
        let hostingController = view2.addSwiftUIView2(view: SwiftUIView())
        if #available(iOS 16.0, *) {
            hostingController.sizingOptions = [.intrinsicContentSize]
        }
        self.hostingController = hostingController
    }
    
    // MARK: 3 case - UIHostingController set up properly
    
    func hostSwiftUIView() {
        // If you add SwiftUI from some UIView and have no access to VC
        // You can find VC using responder chain
        // guard let vc = view2.findViewController() else { return }
        let hostingController = hostSwiftUIView(
            view: SwiftUIView(),
            insideView: view2
        )
        if #available(iOS 16.0, *) {
            hostingController.sizingOptions = [.intrinsicContentSize]
        }
    }
}

