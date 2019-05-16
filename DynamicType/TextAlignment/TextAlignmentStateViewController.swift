//
//  TextAlignmentStateViewController.swift
//  DynamicType
//
//  Created by Алексей Берёзка on 15/05/2019.
//  Copyright © 2019 Алексей Берёзка. All rights reserved.
//

import UIKit

class TextAlignmentStateViewController: StateViewController {
    
    @IBOutlet weak var label: UILabel!
    
    private enum State {
        case centered, natural
    }

    private var state: State = .centered {
        didSet {
            if state != oldValue {
                update(for: state)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateStateForCurrentContentSizeCategory()
    }

    private func update(for state: State) {
        label.textAlignment = alignment(for: state)
    }
    
    private func alignment(for state: State) -> NSTextAlignment {
        switch state {
        case .centered:
            return .center
        case .natural:
            return .natural
        }
    }
}

extension TextAlignmentStateViewController {
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        
        updateStateForCurrentContentSizeCategory()
    }
    
    private func updateStateForCurrentContentSizeCategory() {
        updateState(with: traitCollection.preferredContentSizeCategory)
    }
    
    private func updateState(with contentSizeCategory: UIContentSizeCategory) {
        state = contentSizeCategory.isAccessibilityCategory ? .natural : .centered
    }
}
