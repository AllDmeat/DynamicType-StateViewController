//
//  PickerViewController.swift
//  DynamicType
//
//  Created by Алексей Берёзка on 15/05/2019.
//  Copyright © 2019 Алексей Берёзка. All rights reserved.
//

import UIKit

class PickerViewController: UIViewController {

    @IBOutlet weak var pickerHeightConstraint: NSLayoutConstraint!
    
    private let defaultPickerHeight: CGFloat = 40
    private let accessiblePickerHeight: CGFloat = 200
    
    override func viewDidLoad() {
        super.viewDidLoad()

        updateStateForCurrentContentSizeCategory()
    }
    
}

extension PickerViewController {
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        
        guard let previousTraitCollection = previousTraitCollection,
            previousTraitCollection.preferredContentSizeCategory.isAccessibilityCategory != traitCollection.preferredContentSizeCategory.isAccessibilityCategory else {
                return
        }
        
        updateStateForCurrentContentSizeCategory()
    }
    
    private func updateStateForCurrentContentSizeCategory() {
        updatePickerHeight(for: traitCollection.preferredContentSizeCategory)
    }
    
    private func updatePickerHeight(for contentSizeCategory: UIContentSizeCategory) {
        let pickerHeight = contentSizeCategory.isAccessibilityCategory ? accessiblePickerHeight : defaultPickerHeight
        
        pickerHeightConstraint.constant = pickerHeight
        
        view.setNeedsLayout()
    }
}
