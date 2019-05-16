//
//  StateViewController.swift
//  DynamicType
//
//  Created by Алексей Берёзка on 15/05/2019.
//  Copyright © 2019 Алексей Берёзка. All rights reserved.
//

import UIKit

class StateViewController: UIViewController {
    weak var currentViewController: UIViewController?
    
    func updateController(with newController: UIViewController) {
        removeController()
        addController(newController)
        
        currentViewController = newController
    }
    
    private func addController(_ controller: UIViewController) {
        addChild(controller)
        view.addSubview(controller.view)
        pin(controller.view)
        controller.didMove(toParent: self)
    }
    
    private func removeController() {
        if let controller = currentViewController {
            controller.willMove(toParent: nil)
            controller.view.removeFromSuperview()
            controller.removeFromParent()
        }
    }
    
    private func pin(_ subview: UIView) {
        subview.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo: subview.topAnchor),
            view.leftAnchor.constraint(equalTo: subview.leftAnchor),
            view.bottomAnchor.constraint(equalTo: subview.bottomAnchor),
            view.rightAnchor.constraint(equalTo: subview.rightAnchor),
            ])
    }
}
