//
//  RootViewController.swift
//  swift-gamecenter
//
//  Created by 이재성 on 7/22/25.
//

import UIKit

class RootViewController: UIViewController {
    var id = UUID()
    
    override var children: [UIViewController] {
        self._children
    }
    
    override var presentedViewController: UIViewController? {
        self._children.first
    }
    
    private var _children: [UIViewController] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func present(_ viewControllerToPresent: UIViewController, animated flag: Bool, completion: (() -> Void)? = nil) {
        debugPrint(#function)
        super.present(viewControllerToPresent, animated: flag, completion: completion)
        self._children.append(viewControllerToPresent)
    }
}
