//
//  Storyboardable.swift
//  DynamicType
//
//  Created by Алексей Берёзка on 15/05/2019.
//  Copyright © 2019 Алексей Берёзка. All rights reserved.
//

import UIKit

protocol Storyboardable { }

extension Storyboardable where Self: UIViewController {
    static func instantiateInitialFromStoryboard() -> Self {
        let controller = self.storyboard().instantiateInitialViewController()
        return controller! as! Self
    }
    
    static func storyboard(fileName: String? = nil) -> UIStoryboard {
        let storyboard = UIStoryboard(name: fileName ?? self.storyboardIdentifier, bundle: nil)
        return storyboard
    }
    
    static var storyboardIdentifier: String {
        return String(describing: self)
    }
}

